/*
title = "Electric Potential"

date = 2022-01-25



[taxonomies]

categories = ["Physics"]

tags = ["Physics"]
*/

Besides electrical charge and field, there's another force that is relevant to electricity: #strong[electric potential].

== Potential Energy
<potential-energy>
Gravity is similar to the electrostatic force, apart from the fact that it acts on mass instead of electric charge. The equations are practically identical. We're familiar with the idea of gravitational potential energy; why not apply the concept to charge as well?

Recall that #strong[work] is expressed as the difference between potential energy. The equation for work done #emph[by] an electric force is:

$ W_(A B) = E P E_A - E P E_B $

where $A$ and $B$ are the positions that the charges are in.

== Electric Potential Difference
<electric-potential-difference>
Remember that the electric force depends on the small test charge $q_0$. If we divide all parts of the previous equation by $q_0$, then we get the work per-unit-charge.

For the first time, we're going to be talking about #strong[electric potential], expressed in #strong[volts] $\(V\)$. This is different from electric potential energy, which is expressed in joules ($J\)$. The equation for electric potential derived from EPE is $V = frac(E P E, q_0)$, showing that volts are the same as joule/coulomb.

$V$ can only truly be measured as $Delta V$, because it is relative measurement in terms of work, similar to energy. This potential difference $Delta V$ is known as #strong[voltage]. When we talk about voltage in common parlance, that is the electric potential difference between two charges, typically the terminals of a capacitor.

We can think of positives and negatives here like gravity. Because electricity flows from positive to negative, that's the direction of "gravity". Positive charges accelerate to lower electric potential like massive objects accelerate to lower heights. Negative charges oppose this acceleration like the normal force to higher electric potential.

You might have also seen the unit $e V$, $M e V$, or $G e V$ with reference to energy. This is the unit #emph[electron-volt], which is, as implied, the charge of an electron multiplied by one volt. This value is $1.60 times 10^(- 19) J$, and the mega and giga versions are six and nine order magnitudes greater than it, respectively.

== Volts and Point Charges
<volts-and-point-charges>
If we apply this concept to the point charges we have discussed, we get a pretty simple formula:

$ Delta V = frac(- W_(A B), q_0) = frac(k q, r_B) - frac(k q, r_A) $

And in order to determine $V$ for the $q$ at just point $A$, we consider point $B$ to be infinitely far away and eliminate it, leaving us with the final potential equation:

$ V = frac(k q, r) $

Note here that $q$ is not absolute. $V$ will have the same sign as $q$.

Like with electrostatic force, we can calculate $V$ with respect to many point charges by adding them together, minding our signs .

We can calculate electric potential energy for multiple point charges in a similar way by adding together every pair EPE $frac(k q_1 q_2, r)$.

== Equipotential Surfaces
<equipotential-surfaces>
An #strong[equipotential surface] is one where the electric potential is the same everywhere. Think of a hollow sphere which surrounds a point charge. Every point on that surface is the same distance from the charge and so will have the same electric potential.

If you have a charge on an equipotential surface, then no work is done on it by the net electric force if it moves along it. This is because the potential is the same everywhere, looking at the equations from earlier.

On the same equipotential sphere, the electric field is perpendicular to the surface and points to decreasing potential, like gravity. The most clear example of this is a parallel plate capacitor. If we try to calculate the electric field from electric potential, it is simply

$ E = - frac(Delta V, Delta s) $

where $Delta s$ is an expression of displacement, like distance. This is what we would use to find the electric field or distance for a parallel plate capacitor.

== Capacitors and Dielectrics
<capacitors-and-dielectrics>
We have already discussed one kind of #strong[capacitor], the parallel plate capacitor. A capacitor is simply two conductors placed close together, which are not touching. There will often be an insulator placed in between them called a #strong[dielectric].

The capacitor stores electric charge, with the positive plate having more electric potential. That potential difference is the voltage of the capacitor, although the plates have the same charge.

#strong[The magnitude $q$ of the charge on each plate of a capacitor is directly proportional to the magnitude $V$ of the potential difference between the plates:]

$ q = C V $

#strong[where $C$ is the capacitance in farad $\(F\)$.]

As you can tell from the equation, capitance is coulomb/volt and it represents how well the capacitor can store charge. Like coulombs, it is typically expressed in smaller forms like $mu F$ and $p F$ which are six and twelve orders of magnitude less.

We can increase capacitance by adding a dielectric in the capacitor. The molecules in the dielectric will form dipole moments oriented towards the positive and negative plate as appropriate. These dipole moments will stop the electric field from passing through the dielectric, and instead some of it will begin and end at the surface. This reduces the strength of the electric field and allows it to store more charge.

The equation for capacitance of a parallel plate capacitor based on the dielectric constant $kappa$ is:

$ C = frac(kappa epsilon.alt_0 A, d) $

There is also work done to fill a capacitor with charge, because it stores energy. The work done by a battery, for example, to fill up a capacitor's charge is expressed in multiple ways as:

$ E n e r g y = 1 / 2 q V = 1 / 2 C V = frac(q^2, 2 C) = 1 / 2\(frac(kappa epsilon.alt_0 A, d)\)\(E d\)^2 $
