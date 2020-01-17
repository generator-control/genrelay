/* File: f103Ard_plat.scad 
 * Platform for f103Ard board
 * Author: deh
 * Latest edit: 20200116
 */

include <library_deh/deh_shapes.scad>
include <library_deh/deh_shapes2.scad>
 $fn = 20;
 
 // f103Ard mounting plate (bottom)
 thick2 = 4;
 bwid  = 62;
 
 bleng = 140.0;
 bpbase = [bleng, bwid, thick2]; // BP Motherboard base
 fleng  = 46.5; // Length of pillar
 fbase  = [bwid, fleng, thick2]; // fethe subboard base
 
 // BP Motherboard (f103Ard) 'a' hole locations
 delx = (1.006);   // X calibration adjustment
 dely = (1.000);   // Y calibration adjustment
f103A_offx = 3.8;  // Position posts on grid
f103A_offy = 42.0;
 f103A_holea1 = [(  3.8-f103A_offx)*delx , 42.0-f103A_offy,  0];  
 f103A_holea2 = [( 99.9-f103A_offx)*delx,   6.5-f103A_offy,  0];
 f103A_holea3 = [( 99.5-f103A_offx)*delx,  58.0-f103A_offy,  0];
 f103A_holea4 = [(135.6-f103A_offx)*delx,   3.0-f103A_offy,  0];
 f103A_holea5 = [(134.5-f103A_offx)*delx,  33.6-f103A_offy,  0];

 module f103A_post(a)
 {
     translate(a)
     {
         difference()
        {
            // Cone shaped post
            cylinder(d1=8.0, d2=5.5,h=(4+thick2),center=false);      
            
            // Small hole
            translate([0,0,(4+thick2)-3.5])
              cylinder(d=1,h=10,center=false);
        }
     }   
 }
 
// Locate mounting posts on frame
 module f103A_posts(a)
 {
     translate(a)
     {
         f103A_post(f103A_holea1);
         f103A_post(f103A_holea2);
         f103A_post(f103A_holea3);
         f103A_post(f103A_holea4);
         f103A_post(f103A_holea5);
     }
 }
 // Post holes that go through base
 module f103A_postholes(a,dd)
 {
     translate(a)
     {
       translate(f103A_holea1) cylinder(d=dd,h=50,center=true);         
       translate(f103A_holea2) cylinder(d=dd,h=50,center=true);         
       translate(f103A_holea3) cylinder(d=dd,h=50,center=true);         
       translate(f103A_holea4) cylinder(d=dd,h=50,center=true);         
       translate(f103A_holea5) cylinder(d=dd,h=50,center=true);         
     }
 }
module f103A_hull(thk)
{
dc = 8;
    linear_extrude(height = thk, center = false, convexity = 10)
    {
        hull()
        {
            translate(f103A_holea1) circle(d=dc);
            translate(f103A_holea2) circle(d=dc);
            translate(f103A_holea3) circle(d=dc);
//            translate(f103A_holea4) circle(d=dc);
//            translate(f103A_holea5) circle(d=dc);
        }
    }
}
module f103A_hull2(thk)
{
dc = 8;
    linear_extrude(height = thk, center = false, convexity = 10)
    {
        hull()
        {
//            translate(f103A_holea1) circle(d=dc);
            translate(f103A_holea2) circle(d=dc);
            translate(f103A_holea3) circle(d=dc);
            translate(f103A_holea4) circle(d=dc);
            translate(f103A_holea5) circle(d=dc);
        }
    }
}

module f103A_frame(a)
{
  translate(a)
    difference()
    {
        union()
        {
            f103A_hull(thick2);
            f103A_hull2(thick2);
            f103A_posts([0,0,0]);
        }
        union()
        {
            translate([17,-2,-.01])
              scale([0.75,0.75,1.0]) 
                f103A_hull(thick2+1);

            translate([29,-3,-.01])
              scale([0.73,0.73,1.0]) 
                f103A_hull2(thick2+1);


            f103A_postholes([0,0,-0.1-thick2],3.0);            
        }
    }
}
//f103A_frame([0,0,0]);

