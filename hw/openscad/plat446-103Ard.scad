/* File: plat446-103Ard.scad 
 * Platform for Nucleo F446 w f103Ard board
 * Author: deh
 * Latest edit: 20200114
 */
//include <N64_plat.scad>
include <library_deh/deh_shapes.scad>
include <library_deh/deh_shapes2.scad>
 $fn = 20;
 
 // f103Ard mounting plate (bottom)
 thick = 4;
 bwid  = 62;
 
 bleng = 140.0;
 bpbase = [bleng, bwid, thick]; // BP Motherboard base
 fleng  = 46.5; // Length of pillar
 fbase  = [bwid, fleng, thick]; // fethe subboard base
 
 // BP Motherboard (f103Ard) 'a' hole locations
 delx = (1.006);   // X calibration adjustment
 dely = (1.000);   // Y calibration adjustment
 holea1 = [  3.8*delx , 42.0,  0];  
 holea2 = [ 99.9*delx,   6.5,  0];
 holea3 = [ 99.5*delx,  58.0,  0];
 holea4 = [135.6*delx,   3.0,  0];
 holea5 = [134.5*delx,  33.6,  0];
 
 // Pillar dimensions 
 spy = 5;
 spz = 20;
 spoy = 6;
 spyy = spy+spoy;
 
 // Nucleo plate (top)
 sidew = 5;
 lenb  = 60+2*(11);
 widb  = 60;
 thick1 = 3;
 nvecx = 50;
 nvecy = 70;
 nvecz = 21;
 
 // Nucleo mounting 'b' hole positions
 holebn1 = ([  28.0,  10.8,  0]);
 holebn4 = ([  29.1,  59.0,  0]);
 holebn5 = ([  79.3,  44.1,  0]);
 
 // Bottom f103Ard post to left top Nucleo post
 f103_nucleo = 50;
 
 boff = [50,73,20.5];
 
 /* ***** double rounded_bar *****
 * rectangular bar with rounded end
bar with one end rounded
rounded_bar(d, l, h)
d = diameter of rounded end, and width of bar
l = length of bar from center of rounded end to end
h = thickness (height) of bar
reference is center of rounded end, bottom
*/
module dbl_rounded_bar(d, l, h)
{
    // Rounded ends
    cylinder(d = d, h = h, center = false);
    translate([l,0,0])
      cylinder(d = d, h = h, center = false);
    // Bar
    translate([0, -d/2, 0])
       cube([l, d, h],false);
}
 module pillarhole(a)
 {
     translate(a)
     {
        translate([0,0,0])
          cylinder(d=2.8,h = 50,center = false);
     }
 }
  
 // Side supports for fethe on top
 // a  = translation vector
 // aa = rotation
 // x  =  translation, x dimension
 module sidepillars(a)
 { 
 sl = 12; // Length
     translate(a)
     {
        sidepillar([ 47,bwid,0],[0,0,  0],12);
        sidepillar([117,bwid,0],[0,0,  0],12);
        sidepillar([ 89,02,0],[0,0,180],12);
     }
 }
 module sidepillar(a,aa,xx)
 {
     b = [xx,spy,spz];
     translate(a)
     rotate(aa)
     translate([-xx/2,0,0])
     {
         difference()
         {
             union()
             {
                 translate([0,spoy,0])
                   cube(b,center=false);
              
                 cube([xx,spoy,thick],center=false);
                 
             }
             union()
             {
                 pillarhole([xx/2,spoy+spy/2,0]);
             }
         }
     }  
 }
 
 // Posts to match holes in Nucleo board
 module holebn(a)
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
              cylinder(d1=2.9,d2=2.9,h=50,center=true);
            }
        }
    }     
 }
 module bbase_hole(a)
{
    translate(a)
      cylinder(d=3.5,h=15,center=false);
}
ndia = 3.8;
module basebntab(b)
{
    translate(b)
    {
     difference()
     {
         union()
         {
             translate([0,-11,thick])
             rotate([0,90,0])
             wedge(thick,11,23);
             
             translate([0,bwid+11,0])
             rotate([180,0,0])
             rotate([0,90,0])
             wedge(thick,13,23);
         }
         union()
         {
             translate([2.5,-2.9,0])
               cylinder(d=ndia,h=50,center=true);
             translate([2.5,67.1,0])
               cylinder(d=ndia,h=50,center=true);
         }      
     }   
    }
}
// Nucleo mounting base (sits on pillars)  
 module basebn(a)
 {
 poff = ([-10,-4,0]); // Position Nucleo posts
     translate(a)
     {
        rotate([0,0,-90])
        {
         difference()
         {
            union()
            {
                // Base plate
                translate([0,0,0])
                    cube([lenb,widb,thick],false);
 
                // Posts for Nucleo board
                translate(poff)
                {
                    holebn(holebn1);
                    holebn(holebn4);
                    holebn(holebn5);
                }
                basebntab([0,0,0]);


                
            }
            union()
            {
            // Base mounting holes
                translate([0,1,0])
                {
//                    bbase_hole( [     4,     4, 0]);
//                    bbase_hole( [     4,widb-4, 0]);
   //                 bbase_hole( [     4,    79, 0]);
//                    bbase_hole( [lenb-4,     4, 0]);
//                    bbase_hole( [lenb-4,    79, 0]);
//                    bbase_hole( [lenb-4,widb-4, 0]);
                }  
                
                // Punch post holes through base
                translate(poff)
                {
                    translate(holebn1)
                      cylinder(d1=2.9,d2=2.9,h=50,center=true);
                    translate(holebn4)
                      cylinder(d1=2.9,d2=2.9,h=50,center=true);
                    translate(holebn5)
                      cylinder(d1=2.9,d2=2.9,h=50,center=true);
                }
                
                // Trim outline with angled edges
                translate([70,-13,0])
                  rotate([0,0,30])
                    cube([70,70,10],center=true);
                translate([65,85,0])
                  rotate([0,0,-14])
                    cube([70,70,10],center=true);
                
                // Cutout center
                translate([26,12,-20]) rotate([0,0,30])
                    dbl_rounded_bar(4,41.5,40);
                translate([26,12,-20]) rotate([0,0,90])
                    dbl_rounded_bar(4,36,40);
                translate([26,49,-20]) rotate([0,0,9-23])
                    dbl_rounded_bar(4,37,40);
                translate([62,33,-20]) rotate([0,0,90])
                    dbl_rounded_bar(4,6,40);
                translate([29,15,-20]) rotate([0,0,28])
                    triangle(42,34,40,50);
                translate([29,20,-20]) cube([10,10,50],center=true);
                translate([49,40,-20]) rotate([0,0,-15])
                    cube([25,10,50],center=true);
                    
            /* ***** rounded_rectangle_hull ********************
 * wid  = width, x direction 
 * slen = length, y direction
 * ht   = height (or thickness if you prefer)
 * cut  = x & y direction of chamfer
 * rad  = z axis, radius of corner rounding
*/
                translate([9,8,-.01])
                    rounded_rectangle_hull(12,49,50,0,3);
                    

            } // union
        } // difference
       } // rotate
    } // translate
 }
 
// Bottom board holds f103Ard with pillars for Nucleo board
 module base()
 {
     difference()
     {
        union()
        {
            // Base plate with f103Ard mounting posts
            cube(bpbase,false);
            
            translate([0,-10,0])
              cube([97,spyy,thick],center=false);
            
            translate([0,bwid,0])
              cube([115,spyy,thick],center=false);
            
            // Posts 
            post(holea1);
            post(holea2);
            post(holea3);
            post(holea4);
            post(holea5);

            // Side pillars for Nucleo mount on top
        sl = fleng;
//            sidepillars([83,bwid,0],[0,0,  0],sl);
//            sidepillars([bleng-sl/2,   0,0],[0,0,180],sl);
            sidepillars([0,0,0]);
            
            // Mounting tabs on base plate
 /*
            translate([6,-4,0])
             rotate([0,0,90])
              btab([0,0,0]);
            translate([6,bwid+4,0])
             rotate([0,0,-90])
              btab([0,0,0]);
            translate([bleng+3,bwid/2,0])
             rotate([0,0,180])
              btab([0,0,0]);
*/
        }
        union()
        {
            // Cutouts        
            translate([87,12,-1])
              rounded_rectangle_hull(82,40,50,0,12);
            translate([52,-2,-1])
              rounded_rectangle_hull(83,67,50,0,12);
            
            // Holes for pcb mounting screws
            
            fposth(holea1,2.9);
            fposth(holea2,2.9);
            fposth(holea3,2.9);
            fposth(holea4,2.9);
            fposth(holea5,2.9);
            
        }
     }
 }
module holetop(a)
 {
     translate(a)
        cylinder (d=3.5,h=50,center=true);
 }
 
 //
 module post(a)
 {
     translate(a)
     {
         difference()
        {
            cylinder(d1=8.0, d2=5.5,h=(4+thick),center=false);      
            translate([0,0,(4+thick)-3.5])
              cylinder(d=1,h=10,center=false);
        }
     }   
 }
 module fposth(a,dd)
 {
     translate(a)
        cylinder(d=dd,h=10,center=false);
 }
 
 
 module total()
 {
     difference()
     {
         union()
         {
             base();
         }
         union()
         {
         }
     }
 }
total();
    
// Main base
basebn(boff);
