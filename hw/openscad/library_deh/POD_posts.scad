/* File: POD_posts.scad
 * POD board mounting posts
 * Author: deh
 * Latest edit: 20180315
 */


//include <../library_deh/deh_shapes.scad>
//include <../library_deh/deh_shapes2.scad>
include <../library_deh/angled_posts.scad>
include <../library_deh/ridged_screw_hole.scad>
//include <../library_deh/Plano_frame.scad>

/* POD board dimensions */
pod_wid = 76.2 + 0.0;  // Overall width
pod_len = 88.6 + 0.0;  // Overall length
pod_thick = 1.6;	// Discovery board thickness

pod_brd_theta = 4.5;	// Slope of board
pod_brd_ht = 6.5; // Height of low end bottom of board from bottom of post

/* ***** angled_post_bottom ***********
 * Angled notch is upward pointing
 * wid = width (x direction)
 * len = length (y direction)
 * theta = angle: pcb
 * ht  = height of ledge at bottom corner of pcb
 * rdg = pcb board thickness
 * ldg = pcb ledge width
 * clht= clip height (overhang vertical height)
 * sigma = added angle of upper overhang
 * NOTE: theta+sigma must be > 40 degrees w/o support structures
 * NOTE: x,y (0,0) reference is lower end at inside ridge wall
 */
/* **** Bottom post common dimensions ****** */
pbot_wid = 4;
pbot_rdg = pod_thick;
pbot_ldg = 1.5;
pbot_rwdy = 2.0;
pbot_clen = 4;
pbot_sig = 45 - pod_brd_theta;

pbot_ofs_x = 8;	// Offset from centerline
pbot_len = 8;

/* **** bottom_post******************
 * len = length in x direction
 * xofs = x axis offset of right side of post 
 */
module bottom_post(len,xofs)
{
    translate([xofs,0,0])
	rotate([0,0,90])
//angled_post_bottom(      4,   8,       25,     5,      2,    2.5,       4,      20);  // Test
//                      (wid, len,    theta,    ht,    rdg,    ldg,    clht,  sigma)
  angled_post_bottom(pbot_wid, len,pod_brd_theta,pod_brd_ht,pbot_rdg,pbot_ldg,pbot_clen,pbot_sig);
}

/* ***** angled_post_side_right ***********
 * wid = width (x direction)
 * slen = slant length
 * theta = angle
 * ht1 = height at shortest end at ledge
 * rdg = ridge height
 * ldg = pcb ledge width
 * NOTE: x,y (0,0) reference is lower end at inside ridge wall
 */

/* Common dimensions of side posts */
psid1_wid = 6;
psid1_rdg = 3;
psid1_ldg = 3;

module side_post(len,yofs)
{
	psid_ht1 = pod_brd_ht + yofs * sin(pod_brd_theta);
	xofs = pod_wid/2;
	translate([-xofs,yofs,0])
angled_post_side_right(psid1_wid,len,pod_brd_theta,psid_ht1,psid1_rdg,psid1_ldg);
}

/* ***** angled_post_ridged_corner ***********
* xlen = x axis direction length
* ylen = y axis direction length
* zlen = z axis, height to ledge
* tpht = slant height of cocked top
* rht  = ridge thickness
* rwdx = ridge width, x directions
* rwdy = ridge width, y directions
* scd1 = screw diameter at top
* scd2 = screw diameter at bottom of screw
* sch  = screw hole height
* scofx = screw hole center offset from inside ridge corner, x
* scofy = screw hole center offset from inside ridge corner, y
 */

module top_corner_post()
{
	xofs = pod_wid/2;		// Position from bottom of board
	xlen = 6;	ylen = 14; 
	zlen = pod_brd_ht + pod_len * sin(pod_brd_theta);	// Height at top position
	tpht = 4;	rht = 1.7;	// Slant post height; ridge thickness
	rwdx = 2;	rwdy = 6;	// Ridge widths
	scd1 = 3.2;	scd2 = 2.2; sch = 8;	// Screw dimensions top dia, bot dia, depth
	scofx = 1.5; scofy = -3.3;	// Screw positioning from inside ridge corner

	tc_ofs_y = pod_len * cos(pod_brd_theta);
	translate([xofs,tc_ofs_y,0])
	rotate([0,0,180])
//                        xlen, ylen,   theta,zlen,tpht,rht,rwdx,rwdy,scd1,scd2,sch,scofx,scofy
//                          (6,  12,       15,   8, 3.5,1.5,   5,   4, 3.2, 2.2,  4, -1.5, -2.0); // Test
angled_post_ridged_corner(xlen,ylen,pod_brd_theta,zlen,tpht,rht,rwdx,rwdy,scd1,scd2,sch,scofx,scofy);
}

/* *** discovery_posts_angled ******
 * ht = height: bottom pcb edge to platform at low end
 * theta =	Angle (slope) of Discovery board
 * ysideofs = low end side pair: y offset
 * ysidelen = low end side pair: length
 * NOTE: x centered, y = 0 is bottom 
 */
/* Bottom pair of posts */
pbot_ofs_x1 = 2;	// Offset from centerline, left
pbot_ofs_x2 = 10;	// Offset from centerline, right
pbot_len = 8;

/* Side pair of posts */
psid_slen = 8;
psid_yofs = 3;

module POD_posts_angled()
{
	bottom_post(pbot_len,-pbot_ofs_x1);       	// Bottom left
	bottom_post(pbot_len, pbot_ofs_x2+pbot_len);  // Bottom right

	side_post(psid_slen,psid_yofs);		// Left side
	mirror([1,0,0])
		side_post(psid_slen,psid_yofs);	// Right side

	top_corner_post();
	mirror([1,0,0])
		top_corner_post();
}
module post_test()
{
		POD_posts_angled();	// Test
}
//post_test();
