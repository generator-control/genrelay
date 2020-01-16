/* File: plat446.scad 
 * Platform for Nucleo F446 w two isocan subboards
 * Author: deh
 * Latest edit: 20190921
 */

 $fn = 20;
 
 sidew = 5;
 lenb  = 100;
 widb  = 145;
 thick = 3;
 
 // Mounting hole positions
 holeb1 = ([  28.0,  10.8,  0]);
 holeb4 = ([  29.1,  59.0,  0]);
 holeb5 = ([  79.3,  44.1,  0]);
 
 // Post to match holes in Nucleo board
 module holeb(a)
 {
pht = thick + 9;     
     translate(a)
     {
         difference()
         {
            union()
            {
              cylinder(d1=7.5,d2=4.5,h=pht,center=false);
            }
            union()
            {
              cylinder(d1=2.8,d2=2.9,h=pht,center=false);
            }
        }
    }     
 }
  
 module bbase_hole(a)
{
    translate(a)
      cylinder(d=3.5,h=15,center=true);
}
 module baseb(a)
 {
     translate(a)
     {
         difference()
         {
            union()
            {
                translate([0,0,0])
                    cube([lenb,widb,thick],false);
 
                // Posts for Nucleo board
                translate([10,6.5,0])
                {
                    holeb(holeb1);
                    holeb(holeb4);
                    holeb(holeb5);
                }
            }
            union()
            {
            // Base mounting holes
                translate([0,1,0])
                {
                    bbase_hole( [     4,     4, 0]);
                    bbase_hole( [     4,    79, 0]);
                    bbase_hole( [lenb-4,     4, 0]);
                    bbase_hole( [lenb-4,    79, 0]);
                    bbase_hole( [     4,widb-4, 0]);
                    bbase_hole( [lenb-4,widb-4, 0]);
                }  
             // Bulk cutouts to save plastic   
             translate([160,55,0])
                rounded_rectangle_hull(40,44,10,0,3);
                
             translate([55,55,0])
                rounded_rectangle_hull(38,50,10,0,3);
                
             translate([109,24,0])
                rounded_rectangle_hull(48,35,10,0,3);              
            }
        }
    }
 }
 /* ***** rounded_rectangle_hull ********************
 * wid  = width, x direction 
 * slen = length, y direction
 * ht   = height (or thickness if you prefer)
 * cut  = x & y direction of chamfer
 * rad  = z axis, radius of corner rounding
*/
module rounded_rectangle_hull(wid,slen,ht,cut,rad)
{
 hull()
 {    
    translate([-wid/2+rad,rad,0])
        cylinder(r=rad,h=ht,center=false);

   translate([ wid/2-rad,rad,0])
        cylinder(r=rad,h=ht,center=false);

    translate([-wid/2+rad,slen-rad,0])
        cylinder(r=rad,h=ht,center=false);
    
    translate([ wid/2-rad,slen-rad,0])
        cylinder(r=rad,h=ht,center=false);
 }
}
// isocan board mount
include <plat_isocan.scad>

 // This mounts on top of base unit
 module isocan_stack(a)
 {
   translate(a)
   {   
      union()
      { 
        base_punched_rot([0,0,0]);
        translate([49.3,0,0]) 
            base_punched_rot([0,0,0]);
      }
   }     
 }
 
 module total()
 {

     // Main base
     baseb([0,0,0]);

    // Upper deck with two isocan modules
     isocan_stack([50,84,0]);
 }
 total();
