const DAY: f64 = 1.0 / 365.0;

#[derive(Clone, Copy)]
struct Market {
    spot: f64,
    usd_rate: f64,
    mxn_rate: f64,
    atm: f64,
    rr: f64,
    fly: f64,
    low_strike: f64,
    atm_strike: f64,
    high_strike: f64,
}

#[derive(Clone, Copy)]
struct Position {
    kind: i32,
    notional: f64,
    strike: f64,
    maturity: f64,
}

fn discount(rate: f64, maturity: f64) -> f64 {
    (-rate * maturity).exp()
}

fn forward(market: Market, maturity: f64) -> f64 {
    market.spot * ((market.mxn_rate - market.usd_rate) * maturity).exp()
}

fn erf(x: f64) -> f64 {
    let sign = if x < 0.0 { -1.0 } else { 1.0 };
    let absolute = x.abs();
    let t = 1.0 / (1.0 + 0.3275911 * absolute);
    let polynomial =
        ((((1.061_405_429 * t - 1.453_152_027) * t + 1.421_413_741) * t - 0.284_496_736) * t
            + 0.254_829_592)
            * t;
    sign * (1.0 - polynomial * (-absolute * absolute).exp())
}

fn normal_cdf(x: f64) -> f64 {
    0.5 * (1.0 + erf(x / std::f64::consts::SQRT_2))
}

fn surface_vol(strike: f64, forward: f64, market: Market) -> Option<f64> {
    let x = strike - forward;
    let xs = [
        market.low_strike - market.atm_strike,
        0.0,
        market.high_strike - market.atm_strike,
    ];
    let ys = [
        market.atm + market.fly - market.rr / 2.0,
        market.atm,
        market.atm + market.fly + market.rr / 2.0,
    ];
    if !(xs[0] < 0.0 && xs[2] > 0.0) {
        return None;
    }

    let mut volatility = 0.0;
    for i in 0..3 {
        let mut term = ys[i];
        for j in 0..3 {
            if i != j {
                term *= (x - xs[j]) / (xs[i] - xs[j]);
            }
        }
        volatility += term;
    }
    (volatility.is_finite() && volatility > 0.0).then_some(volatility)
}

fn value(position: Position, market: Market) -> f64 {
    let inputs = [
        market.spot,
        market.usd_rate,
        market.mxn_rate,
        market.atm,
        market.rr,
        market.fly,
        market.low_strike,
        market.atm_strike,
        market.high_strike,
        position.notional,
        position.strike,
        position.maturity,
    ];
    if inputs.iter().any(|number| !number.is_finite()) || market.spot <= 0.0 {
        return f64::NAN;
    }
    let maturity = position.maturity.max(0.0);
    let (usd_discount, mxn_discount) = (
        discount(market.usd_rate, maturity),
        discount(market.mxn_rate, maturity),
    );
    if !usd_discount.is_finite() || !mxn_discount.is_finite() {
        return f64::NAN;
    }

    if position.strike <= 0.0 {
        return f64::NAN;
    }
    if position.kind == 2 {
        return position.notional * (usd_discount - position.strike / market.spot * mxn_discount);
    }
    if position.kind != 0 && position.kind != 1 {
        return f64::NAN;
    }
    if position.maturity <= 0.0 {
        let intrinsic = if position.kind == 0 {
            (1.0 - position.strike / market.spot).max(0.0)
        } else {
            (position.strike / market.spot - 1.0).max(0.0)
        };
        return position.notional * intrinsic;
    }

    let Some(volatility) = surface_vol(position.strike, forward(market, maturity), market) else {
        return f64::NAN;
    };
    let scaled_volatility = volatility * maturity.sqrt();
    if !scaled_volatility.is_finite() || scaled_volatility <= 0.0 {
        return f64::NAN;
    }
    let d1 = ((market.spot / position.strike).ln()
        + (market.mxn_rate - market.usd_rate
            + scaled_volatility * scaled_volatility / (2.0 * maturity))
            * maturity)
        / scaled_volatility;
    let d2 = d1 - scaled_volatility;
    let value = if position.kind == 0 {
        position.notional
            * (usd_discount * normal_cdf(d1)
                - position.strike / market.spot * mxn_discount * normal_cdf(d2))
    } else {
        position.notional
            * (position.strike / market.spot * mxn_discount * normal_cdf(-d2)
                - usd_discount * normal_cdf(-d1))
    };
    if value.is_finite() {
        value
    } else {
        f64::NAN
    }
}

fn position_value(position: Position, market: Market, notional: f64, maturity: f64) -> f64 {
    value(
        Position {
            notional,
            maturity,
            ..position
        },
        market,
    )
}

/// Returns a model value or USD impact, selected by `metric`.
///
/// Metric IDs: 0 value, 1 delta (+1% spot), 2 gamma (half × 1%²),
/// 3 ATM vega (+1 vol point), 4 risk reversal, 5 butterfly, 6 USD rho,
/// 7 MXN rho, 8 one-day carry, 9 forward.
#[allow(clippy::too_many_arguments)]
#[no_mangle]
pub extern "C" fn hornet_metric(
    metric: i32,
    kind: i32,
    side: f64,
    spot: f64,
    strike: f64,
    maturity: f64,
    notional: f64,
    usd_rate: f64,
    mxn_rate: f64,
    atm: f64,
    rr: f64,
    fly: f64,
    low_strike: f64,
    atm_strike: f64,
    high_strike: f64,
) -> f64 {
    let market = Market {
        spot,
        usd_rate,
        mxn_rate,
        atm,
        rr,
        fly,
        low_strike,
        atm_strike,
        high_strike,
    };
    let position = Position {
        kind,
        notional: side * notional,
        strike,
        maturity,
    };
    let base = value(position, market);
    if !base.is_finite() {
        return f64::NAN;
    }
    if metric == 0 {
        return base;
    }
    if metric == 9 {
        return forward(market, maturity.max(0.0));
    }

    let spot_bump = 0.0001 * market.spot;
    let small_bump = 0.0001;
    let result = match metric {
        1 | 2 => {
            let down = value(
                position,
                Market {
                    spot: market.spot - spot_bump,
                    ..market
                },
            );
            let up = value(
                position,
                Market {
                    spot: market.spot + spot_bump,
                    ..market
                },
            );
            if metric == 1 {
                ((up - down) / (2.0 * spot_bump)) * market.spot * 0.01
            } else {
                0.5 * (up - 2.0 * base + down) / (spot_bump * spot_bump) * spot_bump * spot_bump
            }
        }
        3..=7 => {
            let (down_market, up_market, scale) = match metric {
                3 => (
                    Market {
                        atm: market.atm - small_bump,
                        ..market
                    },
                    Market {
                        atm: market.atm + small_bump,
                        ..market
                    },
                    0.01,
                ),
                4 => (
                    Market {
                        rr: market.rr - small_bump,
                        ..market
                    },
                    Market {
                        rr: market.rr + small_bump,
                        ..market
                    },
                    0.01,
                ),
                5 => (
                    Market {
                        fly: market.fly - small_bump,
                        ..market
                    },
                    Market {
                        fly: market.fly + small_bump,
                        ..market
                    },
                    0.01,
                ),
                6 => (
                    Market {
                        usd_rate: market.usd_rate - small_bump,
                        ..market
                    },
                    Market {
                        usd_rate: market.usd_rate + small_bump,
                        ..market
                    },
                    0.0001,
                ),
                _ => (
                    Market {
                        mxn_rate: market.mxn_rate - small_bump,
                        ..market
                    },
                    Market {
                        mxn_rate: market.mxn_rate + small_bump,
                        ..market
                    },
                    0.0001,
                ),
            };
            ((value(position, up_market) - value(position, down_market)) / (2.0 * small_bump))
                * scale
        }
        8 => position_value(position, market, position.notional, position.maturity - DAY) - base,
        _ => f64::NAN,
    };
    if result.is_finite() {
        result
    } else {
        f64::NAN
    }
}
