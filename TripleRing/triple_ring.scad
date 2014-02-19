///////////////////////////////////////////////////////
// Triple ring design
/////////////////////////////////
// Copyleft 2014 Adam L. Winter
/////////////////////////////////
// Creates a 3-way ring based on your own measurements.
//
// The design is inspired in this kind of toy:
// 
//   http://image.dhgate.com/albu_251966915_00/1.0x0.jpg
//   (usage illustration, sort of NSFW) 
// An example of suggested measures:
// 
//  - Small: 
//  - Medium:
//  - Large: 50 mm, 44 mm, 38 mm, 
//    (http://www.amazon.com/Best-Triad-Chamber-Cock-Ball/dp/B008Z3CW82)
//
// These examples are merely informative in case you
// don't feel like measuring yourself down there.)
//
// Usage: Edit the values below. Print a low-res prototype model to see if it fits. 
// Adjust and print your final piece. Lovingly sand it until smoooth. Finish it
// so it's fully safe to use.
//
// If you try this, let me know how it went at longlongevenings [at] the gmail thing.

// EDIT THESE ///////////////////////////////////////

// Measures are in millimeters, multiply by 2.54 
// for inches.

// Ring thickness
ring_diameter = 8; // mm
// Diameter of the largest ring (base)
bottom_diam = 50; // mm
// Diameter of the middle ring (testicles)
left_diam = 40; // mm
// Diameter of the smaller ring (penis)
right_diam = 38; // mm
// Note that these will be the measurements of the 
// holes in the rings, not the rings themselves.

// Now hit F5 and see your new ring.
// No need to edit further down!
//
// Ideas for future versions:
//  - Use a cylinder design like http://cockringsonline.com/images/Super%20Tri-Ring%20Large.jpg
//  - Strengthen the joints
//  - How to soften the mesh with Blender

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
translate([circle_radius*2, 0, 0])
circle(ring_diameter, $fn=circle_detail);

// FIXME: This math works but is poorly expressed
r = ring_diameter/2+left_diam/2;    
// Adjust position so that it rotates along the bottom ring
translate([0,-bottom_diam-ring_diameter,0])
  rotate(a=[left_angle, 0, 0])
    translate([0,r*2,0])
    // Create the ring
    rotate_extrude(convexity = 10, $fn=extrude_detail)
      translate([r*2, 0, 0])
        circle(ring_diameter, $fn=circle_detail);

// FIXME: This shouldn't be a module, but won't work correctly
// outside it.  I don't yet know why.
module right_ring(ring_diameter, hole_diameter, rota) {
  r = ring_diameter/2+right_diam/2; 
  translate([0,bottom_diam+ring_diameter,0])
    rotate(a=[-right_angle, 0, 0])
      translate([0,-r*2,0])
        rotate_extrude(convexity = 10, $fn=extrude_detail)
          translate([r*2, 0, 0])
            circle(ring_diameter, $fn=circle_detail);
}
right_ring(ring_diameter, right_diam, -right_angle);
