/* File: plat_isocan.scad
 * isocan mount
 * Date: 08/30/2019
 * Author: deh
 */
//$fn=30;
 
 // CAN sub-board module
 sub_wid      = 33.75;  // Overall width
 sub_len      = 62.9;   // Overall lengh
 sub_mtg_wid  = 26.6;   // Between mounting holes, width
 sub_mtg_len  = 57.0;   // Between mounting holes, length 

 // Switcher module
 sw_wid =   20.3;   // Overall width
 sw_len =   41.2;   // Overall length
 sw_mtg_off_out_y   = 5.56; // Offset from edge "out" mounting hole 
 sw_mtg_off_out_x   = 2.7;  // Offset from edge "out" mounting hole 
 sw_mtg_off_in_y    = 3.1;  // Offset from edge "in" mounting hole
 sw_mtg_off_in_x    = 6.0;  // Offset from edge "in" mounting hole
 

 iso_len   = 50.3;	// Length: two RJ 45 jacks parallel
 iso_wid   = 46.3;      // Width
 iso_thick = 1.6;	// PC board thickness
 iso_slop  = 0.1;	// Allowance for board variation
 iso_lip   = 1.2;	// Ledge width for board seating
 iso_ridge_ht = 1.55;	// Ridge ht for seat
 iso_ridge_wid= 1.5;	// Ridge width for seat
 iso_post_ht = 6.0;	// Height of lip above base

 iso_osd_y = iso_wid + iso_slop; // Board y
 iso_osd_x = iso_len + iso_slop; // Board x
 iso_side  = iso_lip + iso_ridge_wid;
 
 pod_post_s  = 2.9;
 pod_post_sd = 5;



// Post with screw hole
module iso_post_s(l,w,isph,hole_dia,hole_depth)
{
     difference()
     {
         union()
         {  // Post block
            cube([l,w,isph],false);
         }
         union()
         {
            // Self tapping screw hole
            translate([l/2,w/2,.01])
                cylinder(h = isph,
                   d1 = 2.8, d2 = hole_dia, 
                   center = false);
         }
     }        
}

// iso mount for CAN w switcher PC board
module iso_post()
{

   // base of seat
   difference()
   { 
      // Outside dimensioned block
      cube([iso_osd_x + 2*iso_ridge_wid,
            iso_osd_y + 2*iso_ridge_wid,
            iso_post_ht + iso_ridge_ht],
            false);
      union()
      {
         // Center punched all-the-way
         translate ([(iso_lip + iso_ridge_wid),
                     (iso_lip + iso_ridge_wid),
                      -.01])
            cube([iso_osd_x - 2*iso_lip,
                  iso_osd_y - 2*iso_lip,
                  iso_post_ht + iso_ridge_ht + .02],
                  false);
         // Ridge/seat recessed
         translate ([iso_ridge_wid,
                     iso_ridge_wid,
                      iso_post_ht])
            cube([(iso_osd_x),
                  (iso_osd_y),
                   iso_ridge_ht],
                   false);
      }
   }
}

// Base plate with holes punched in it
module base_punched(a)
{
   difference()
   {
      union()
      {
         // Eye-ball in the translations of the following
translate([0,-5,0])
{
         translate(a)
         {
           // Some local positioning
           iso_ytop = 46;  iso_xtop = 5;
           iso_xbot = iso_osd_x + 2.5;
           iso_y = (iso_osd_y + 2*iso_ridge_wid)/2;
           iso_blkl = 5;   iso_blkw = 5; iso_blkh = 6.5;

           translate([0,5,0]) /* Tweak position */
           iso_post();

	   translate([-iso_xtop,iso_y, 0])
             iso_post_s(iso_blkl+.1,
                 iso_blkw+.1,
                 iso_blkh + iso_ridge_ht - .75,
                 pod_post_s,pod_post_sd);

	   translate([iso_xbot,iso_y,0])
             iso_post_s(iso_blkl+.1,
                 iso_blkw+.1,
                 iso_blkh + iso_ridge_ht - .75,
                 pod_post_s, pod_post_sd);
         }
}
      }
      union()
      {
      }
   }
}

module base_punched_rot(a,b)
{
    translate(a)
      rotate([0,0,90])
        base_punched(a);
    
}
//base_punched([-25,5,0]);

