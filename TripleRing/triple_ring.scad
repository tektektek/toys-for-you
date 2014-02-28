///////////////////////////////////////////////////////
// Triple ring design
/////////////////////////////////
// Copyleft 2014 Adam L. Winter
/////////////////////////////////
// Creates a 3-way ring based on your own measurements.
// See README.md for much more.

// EDIT THESE ///////////////////////////////////////

// Measures are in millimeters, multiply by 2.54 for inches. 
// E.g. if you want 2 inches, input 5.08 (2 times 2.54)

// Ring thickness
ring_diameter = 5; // mm
// Diameter of the largest ring (base)
bottom_diam = 50; // mm
// Diameter of the middle ring (testicles)
left_diam = 44; // mm
// Diameter of the smaller ring (penis)
right_diam = 38; // mm
// Note that these will be the diameters of the 
// holes in the rings, not the rings themselves.

// 1 means perfect circle.
// Less than 1 (e.g. 0.5) makes the ring narrower. You will need joints for this to be usable.
// More than 1 will make it fatter.
roundness_ratio = 1;

// Now hit F5 and see your new ring.
// No need to edit further down!

/////////////////////////////////////////////////////
///// Here be dragons, but they be cute dragons /////
/////////////////////////////////////////////////////

// detail level for rendering and extrude quality
circle_detail = 100;
extrude_detail = 50;

// Apply the law of cosines to find the correct angles.
// Source: http://www.clarku.edu/~djoyce/trig/oblique.html
rd = right_diam + ring_diameter;
ld = left_diam + ring_diameter;
bd = bottom_diam + ring_diameter;
left_angle = acos((pow(rd,2)-pow(ld,2)-pow(bd,2))/-2*ld*bd);
right_angle = acos((pow(ld,2)-pow(rd,2)-pow(bd,2))/-2*rd*bd);

// Bottom ring
circle_radius = ring_diameter/2+bottom_diam/2;  
// Create the ring by rotate-extruding a circle
rotate_extrude(convexity = 10, $fn=extrude_detail)
  translate([circle_radius, 0, 0])
    scale([roundness_ratio,1,1])
      circle(r=ring_diameter/2, $fn=circle_detail);

// FIXME: This math works but is poorly expressed
r = ring_diameter/2+left_diam/2;    
// Adjust position so that it rotates along the bottom ring
translate([0,-bottom_diam/2-ring_diameter/2,0])
  rotate(a=[left_angle, 0, 0])
    translate([0,r,0])
      // Create the ring
      rotate_extrude(convexity = 10, $fn=extrude_detail)
        translate([r, 0, 0])
          scale([roundness_ratio,1,1])
            circle(r=ring_diameter/2, $fn=circle_detail);

// FIXME: This shouldn't be a module, but won't work correctly
// outside it.  I don't yet know why.
module right_ring(ring_diameter, hole_diameter, rota) {
  r = ring_diameter/2+right_diam/2; 
  translate([0,bottom_diam/2+ring_diameter/2,0])
    rotate(a=[-right_angle, 0, 0])
      translate([0,-r,0])
        rotate_extrude(convexity = 10, $fn=extrude_detail)
          translate([r, 0, 0])
            scale([roundness_ratio,1,1])
              circle(r=ring_diameter/2, $fn=circle_detail);
}
right_ring(ring_diameter, right_diam, -right_angle);

// debug shape for measuring
//cube([bottom_diam, bottom_diam, 10], center=true);