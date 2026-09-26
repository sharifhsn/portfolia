/*
title = "Electromagnetic Induction"

date = 2022-02-18

[taxonomies]

categories = ["Physics"]

tags = ["Physics"]
*/

The final piece to the puzzle of electromagnetism here is #strong[electromagnetic induction], where we use magnets to create current.

== Induced Emf/Current
<induced-emfcurrent>
Like with charges in a magnetic field, magnets do not generate current unless they are moving relative to a wire. The changing magnetic field $arrow(B)$ is what creates the current. This current is called an #strong[induced current], and the "emf" that causes it which is the wire itself is an #strong[induced emf].

The emf can also be induced by changing the area of coil in a magnetic field, as that changes the relationship between the magnetic field and coil.

These examples are in a closed circuit, which has a current. An open circuit would not have a current, but it would still have the induced emf.

== Motional Emf
<motional-emf>
An induced emf is created in a metal rod that moves through a magnetic field as long as the velocity is not parallel to the magnetic field. We can use RHR1 to determine where the positive and negative sides of the rod are when the rod has a velocity through a magnetic field. The movement of these charges to either end of the rod cause a charge separation to occur, which leads to a current running from the negative end to the positive end. This is called #strong[motional emf] because it comes from the motion through a magnetic field.

We can find the motional emf when the length, velocity, and magnetic field are all perpendicular i.e.~they all have their own axis:

$ E = v B L $

There is another magnetic force that opposes the motional emf. The current creates its own magnetic field, which by RHR1 would actually oppose the velocity of a mutually perpendicular system. We have to have an external force moving the rod otherwise the magnetic field produced by its own current will cause it to stop.

== Magnetic Flux
<magnetic-flux>
Remember electric flux? Magnetic flux is quite similar in that it is defined as amount of magnetic field passing through an area, so $Phi = B A cos theta$ in $W b$ or $T dot.op m^2$. We can define motional emf through magnetic flux like so:

$ E = - frac(Delta Phi, Delta t) $

or, emf is the rate of change of magnetic flux. This is why we can induce an emf by changing the area of a coil. The reason that the equation is negative is because the induced current will create a magnetic force which will oppose its velocity direction.

== Faraday's Law
<faradays-law>
#strong[Faraday's Law] is precisely the equation we just laid out but with one additional component to account for loops:

$ E = - N frac(Delta Phi, Delta t) $

The emf is generated if the flux changes, which depends on $B$, $A$, or $phi.alt$, which are magnetic field, area, and angle of the magnetic field with respect to the normal of the surface.

== Lenz's Law
<lenzs-law>
#strong[Lenz's Law] is less of an equation and more of a method to understand the polarity of an induced emf. Let's follow the reasoning:

+ Check whether the flux is increasing or decreasing.

+ Find the direction of the induced magnetic field to #emph[oppose] the change in flux.

+ Use RHR2 with the previous step to find the positive and negative end, with the polarity coming out of your palm.

This is best understood through an example. Let's imagine we have a loop with a bar magnet approaching at north side head on.

+ The flux is increasing, because the magnet is getting closer.

+ The induced magnetic field must oppose the magnet field to decrease the flux.

+ RHR2 tells us that if the magnetic field is coming out of our palm at the magnet, the current must be going counter-clockwise. Therefore, the left point is positive and the right is negative, as the external circuit must have positive going to negative.

== Transformers
<transformers>
A #strong[transformer] is a device that increases or decreases ac voltage. It is responsible for reducing the voltage in your phone charge so you're not sending 120 V to your phone that doesn't need it. This change is called a #strong[step-up] or #strong[step-down] which increases or decreases the voltage, respectively, directly.

When we send power over power lines, there is a certain power loss that happens depending on the voltage and the resistance of the transmitting power wire:

$ P_(l o s t) = I^2 R $

which we subtract from our initial power to get the final power.

If we want to figure out how much voltage we need to step-up or step-down to get a specific power loss, we just resubstitute the desired power loss into that equation to get the current and proportion it to the voltage.
