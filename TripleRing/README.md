# Triple Ring

This is an OpenSCAD schematic that generates a Triple Ring toy model based on your own measurements. The design is inspired in [this kind of toy][1] (informative usage illustration, NSFW.)

## Usage

 1. Edit the values inside the OpenSCAD file and output an STL model. 
 2. Print a low-resolution and low-density prototype model to test if it fits.
 3. Adjust the values if necessary, and print your final piece.

When printing, you will want to use a support. It wastes some plastic, but if you do without it, the top join will be warped. This warping might be acceptable for a test piece (though you will need to sand or file it), but definitely use a support in your final print.

If you try this, let me know how it went.

## Bugs

 * Right now, the script appears to output objects with double the intended size. Just scale down by 50% in your printing program to fix it.
 * Measuring the ring holes in a printed sample, I found that the rings have 1mm less diameter than specified in the script. Sanding will probably lessen the difference. Maybe it's my specific printer, but you might want to compensate in case you find it happens to you. The ring diameter seems okay, though.

## Example measurements

These are merely informative in case you don't feel like measuring yourself down there and just want to go in and print something.

[This one][2] is 50 mm, 44 mm, 38 mm.

Have more examples? Please let me know by filing an issue or, even better, by editing this file and doing a pull request.

## Ideas for development

  * A printable set of rings to find your exact measure before doing a full final print.
  * Another version with a cylinder design like [this one][3]. 
  * Another version with strengthened joints using small rounded cylinders.
  * Find out how to soften the mesh (with Blender?), so that the join between rings is smoother and doesn't get hairs stuck in it (I've read this can happen, manufacturers use clear epoxy to fill the gap).

  [1]: http://image.dhgate.com/albu_251966915_00/1.0x0.jpg
  [2]: http://www.amazon.com/Best-Triad-Chamber-Cock-Ball/dp/B008Z3CW82
  [3]: http://cockringsonline.com/images/Super%20Tri-Ring%20Large.jpg
