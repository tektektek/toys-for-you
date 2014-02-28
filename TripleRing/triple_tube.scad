///////////////////////////////////////////////////////
// Triple tube design
/////////////////////////////////
// Copyleft 2014 Adam L. Winter
/////////////////////////////////
// Creates a 3-way ring based on your own measurements.
// This one is more tube-shaped than ring-shaped.
// See README.md for much more.

// EDIT THESE ///////////////////////////////////////

// Measures are in millimeters, multiply by 2.54 for inches. 
// E.g. if you want 2 inches, input 5.08 (2 times 2.54)

// Ring thickness
ring_diameter = 3; // mm
// Tube length
bottom_tube_length = 10;
left_tube_length = 15;
right_tube_length = 20;

// Diameter of the largest ring (base)
bottom_diam = 50; // mm
// Diameter of the middle ring (testicles)
left_diam = 44; // mm
// Diameter of the smaller ring (penis)
right_diam = 38; // mm
// Note that these will be the diameters of the 
// holes in the rings, not the rings themselves.

// If you don't want joints, change both values here to 0.
// How much thicker than the rings the joint should be.
joint_padding = 4;
// Sideways length of the joint
joint_width = 10;
// Remove joint insides?
remove_joint_insides = true;

// 1 means perfect circle.
// Less than 1 (e.g. 0.5) makes the ring narrower. You will need joints for this to be usable.
// More than 1 will make it fatter.
// Warning: this is an experimental feature, it will mess up the measurements since I didn't include
// code to compensate for the shrinking.
roundness_ratio = 1;

// Now hit F5 and see your new ring.
// No need to edit further down!

/////////////////////////////////////////////////////
///// Here be dragons, but they be cute dragons /////
/////////////////////////////////////////////////////

// detail level for rendering and extrude quality
circle_detail = 100;
extrude_detail = 50;
joint_detail = 50;

// Apply the law of cosines to find the correct angles.
// Source: http://www.clarku.edu/~djoyce/trig/oblique.html
rd = right_diam + ring_diameter;
ld = left_diam + ring_diameter;
bd = bottom_diam + ring_diameter;
left_angle = acos((pow(rd,2)-pow(ld,2)-pow(bd,2))/-2*ld*bd);
right_angle = acos((pow(ld,2)-pow(rd,2)-pow(bd,2))/-2*rd*bd);

// Variable short names
btl = bottom_tube_length;
ltl = left_tube_length;
rtl = right_tube_length;
rr = ring_diameter / 2;

// Bottom ring
circle_radius = ring_diameter/2+bottom_diam/2;  
// Create the ring by rotate-extruding a circle
rotate_extrude(convexity = 10, $fn=extrude_detail)
  translate([circle_radius, 0, 0])
    scale([roundness_ratio,1,1])
      union () {
        // This is the tube shape
        circle(r=rr, $fn=circle_detail);
        translate([0,-btl,0])
          circle(r=rr, $fn=circle_detail);
        translate([0,-btl/2,0])
        square([rr*2,btl], center=true);
      }

// Left ring
r1 = ring_diameter/2+left_diam/2;    
// Adjust position so that it rotates along the bottom ring
translate([0,-bottom_diam/2-ring_diameter/2,0])
  rotate(a=[left_angle, 0, 0])
    translate([0,r1,0])
      // Create the ring
      rotate_extrude(convexity = 10, $fn=extrude_detail)
        translate([r1, 0, 0])
          scale([roundness_ratio,1,1])
            union () {
              // This is the tube shape
              circle(r=rr, $fn=circle_detail);
              translate([0,ltl,0])
                circle(r=rr, $fn=circle_detail);
              translate([0,ltl/2,0])
                square([rr*2,ltl], center=true);
            }

// Right ring
r2 = ring_diameter/2+right_diam/2; 
translate([0,bottom_diam/2+ring_diameter/2,0])
  rotate(a=[-right_angle, 0, 0])
    translate([0,-r2,0])
      rotate_extrude(convexity = 10, $fn=extrude_detail)
        translate([r2, 0, 0])
          scale([roundness_ratio,1,1])
            union () {
              // This is the tube shape
              circle(r=rr, $fn=circle_detail);
              translate([0,rtl,0])
                circle(r=rr, $fn=circle_detail);
              translate([0,rtl/2,0])
                square([rr*2,rtl], center=true);
            }

// Joints

// Joint radius
jr = ring_diameter/2+joint_padding/2;
// Joint width
jw = joint_width;

// Right joint
cr = ring_diameter/2+bottom_diam/2;  
translate([0, -cr, 0])
  rotate(90, v=[0,1,0])
    cylinder(h=jw*2, r=jr, center=true, $fn=joint_detail);
// Sphere tips
translate([-jw,-cr,0])
  sphere(r=ring_diameter/2+joint_padding/2, $fn=joint_detail);
translate([jw,-cr,0])
  sphere(r=ring_diameter/2+joint_padding/2, $fn=joint_detail);

// Left joint
cr1 = ring_diameter/2+bottom_diam/2;  
translate([0, cr1, 0])
  rotate(90, v=[0,1,0])
    cylinder(h=jw*2, r=jr, center=true, $fn=joint_detail);
// Sphere tips
translate([-jw,cr1,0])
  sphere(r=ring_diameter/2+joint_padding/2, $fn=joint_detail);
translate([jw,cr1,0])
  sphere(r=ring_diameter/2+joint_padding/2, $fn=joint_detail);

// Top joint
// Apply the same rotation as the left ring to find the right position
translate([0,-bottom_diam/2-ring_diameter/2,0])
  rotate(a=[left_angle, 0, 0])
    translate([0,r1*2,0])
      rotate(90, v=[0,1,0])
        cylinder(h=jw*2, r=jr, center=true, $fn=joint_detail);
// Sphere tips
translate([0,-bottom_diam/2-ring_diameter/2,0])
  rotate(a=[left_angle, 0, 0])
    translate([-jw,r1*2,0])
      rotate(90, v=[0,1,0])
        sphere(r=ring_diameter/2+joint_padding/2, $fn=joint_detail);
translate([0,-bottom_diam/2-ring_diameter/2,0])
  rotate(a=[left_angle, 0, 0])
    translate([jw,r1*2,0])
      rotate(90, v=[0,1,0])
        sphere(r=ring_diameter/2+joint_padding/2, $fn=joint_detail);


