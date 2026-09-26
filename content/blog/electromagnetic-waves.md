+++
title = "Electromagnetic Waves"

date = 2022-03-01

[taxonomies]

categories = ["Physics"]

tags = ["Physics"]

+++

We have discussed electric fields and magnetic fields, and the way that they change and interact. The full interaction of these fields will create **electromagnetic waves**, the study of which will consume the rest of these notes.

## The Electromagnetic Spectrum

It's easiest to understand electromagnetic waves (EM waves) in the same way that we understand any other waves, through frequency \\(f\\) or wavelength \\(\\lambda\\).

> Throughout these notes, we will refer almost exclusively to the wavelength of an EM wave as identification for consistency's sake. Note however that this is always mapped to a corresponding frequency, though inversely related.

Visible light is an EM wave, with wavelengths in the hundreds of nanometers. Stronger EM waves like X-rays or gamma rays go from \\(10^{-8}\\) to \\(10^{-16}\\) meters, which is extremely small! In contrast, weaker EM waves like radio waves can have wavelengths in the thousands of meters. As you can see, EM waves have a broad spectrum.

The wavelength of an EM wave in a vacuum is given by 

$$
f\\lambda = c
$$

where \\(c\\) is the well-known *speed of light* at \\(3 \\times 10^{8}\\) meters per second. \\(c\\) can also be more precisely defined as

$$
c = \frac{1}{\sqrt{\\epsilon_0\\mu_0}}
$$

where \\(\\epsilon_0\\) is the permittivity of free space \\(8.85\\times10^{-12}\\) and \\(\\mu_0\\) is the permeability of free space \\(4\\pi \\times 10^{-7}\\).

## Energy

EM waves transport energy, and that energy has a certain value depending on the electric and magnetic fields that created the EM wave. The *electric energy density* is:

$$
u_E=\frac{1}{2}\\epsilon_0E^2
$$

In contrast, the *magnetic energy density* is given by:

$$
\\mu_B=\frac{1}{2\\mu_0}B^2
$$

Notice the different units here. The electric energy density is dependent on permittivity, while the magnetic energy density is dependent on the inverse permeability.

We can combine these two to get the total energy density:

$$
u = \frac{1}{2}\\epsilon_0E^2 + \frac{1}{2\\mu_0}B^2 = \\epsilon_0E^2 = \frac{B^2}{\\mu_0}
$$

The direction of the wave must always be mutually perpendicular to the direction to the electric field and the magnetic field. This follows the **right hand rule** where the thumb is the magnetic field \\(B\\), the pointer finger is the propagation of the wave, and the middle finger is the electric field \\(E\\). You can remember this because the pointer finger points to where the wave is going, and \\(B\\) comes before \\(E\\) in the alphabet, so the first one is the thumb and the second is the middle finger.

> An EM wave has a magnetic field with an rms value of \\(3.40 \\times 10^{-6} T\\). The wave passes perpendicularly through an opening that has an area of \\(0.35 m^2.\\)
> 
> To get the electric field value \\(E\\), we multiply the magnetic field \\(B\\) by \\(c\\) to get \\(3 \\times 10^8\ m/s\ \\cdot\ 3.4 \\times 10^{-6} T = 1020\ N/C\\).
> 
> To get the energy densities \\(\\mu_E\\) and \\(\\mu_B\\), we simply apply the earlier formulas here.
> 
> $$
> \\mu_E = \frac{1}{2}\\epsilon_0E^2 = \frac{1}{2}(8.85\\times10^{-12})(1020)^2 = 4.604 \\times 10^{-6} J/m^3
> $$
> 
> $$
> \\mu_B = \frac{B^2}{2\\mu_0} = \frac{(3.4\\times10^{-6})^2}{2\ \\cdot\ 4\\pi \\times 10^{-7}} = 4.6\\times10^{-6} J/m^3
> $$
> 
> After getting the electric energy density and the magnetic energy density, getting the total energy density is as simple as adding them together to get \\(9.204\\times10^{-6}\ J/m^3\).
> 
> The intensity of a wave is a simple equation; you can think of it as the density multiplied by speed being how much is being transferred per unit time: \\(S = cu\\).
> 
> $$
> S = cu = (3\\times10^8 m/s)(9.204\\times10^{-7} J/m^3) = 2761.2 W/m^2
> $$
> 
> Let's say we want to find the energy that is carried through this opening over twenty seconds. Energy is in the unit joules \\(J\\) and \\(W\\) is \\(J/s\\). In order to convert a dimensions properly, we're going to need multiply the intensity by \\(s\ \\cdot\ m^2\\). With this in mind, it's clear how we should form our equation. We're multiplying the density by the time passed (20 seconds) and the area \\(0.35 m^2\\).
> 
> $$
> E = StA = (2761.2 W/m^2)(20 s)(0.35 m^2) = 19328.4\ J
> $$

## Polarization

Electromagnetic waves can be **polarized** in a a particular direction by passing throw a material which only allows for one vector to pass through. Unpolarized light passing through a polarizing material will have *half* the intensity that it originally had.

**Malus' Law** states that an *analyzer* which alters the intensity and polarization direction of an EM wave will decrease the intensity as so:

$$
\bar{S} = \bar{S_0}\cos^2{\\theta}
$$

and changing the polarization direction to match the analyzer. \\(\\theta\\) in this case is the *difference* between the polarized light and the analyzer. Say the light is polarized at angle of \\(30^\\circ\\) clockwise to the vertical and it passes through a filter that is at an angle of \\(15^\\circ\\) counterclockwise to the vertical. The \\(\\theta\\) in this case will be \\(45^\\circ\\).

> A vertically polarized beam of intensity \\(S_0 = 60.0\\) is incident through three polarizers \\(\\theta_1 = 38.0^\\circ\\) counter-clockwise, \\(\\theta_2 = 17.0^\\circ\\) clockwise, and \\(\\theta_3 = 30.0^\\circ\\) counter-clockwise.
> 
> $$
> S_1 = S_0\cos^2{\\theta_1} = 60\cos^2{38^\\circ} = 37.258\ W/m^2
> $$
> 
> $$
> S_2 = S_1\cos^2{\\theta_2} = 37.258\cos^2{55^\\circ} = 12.257\ W/m^2
> $$
> 
> $$
> S_3 = S_2\cos^2{\\theta_3} = 12.257\cos^2{47^\\circ} = 5.701\ W/m^2
> $$
