/* File: N64_plat.scad 
 * Platform for Nucleo 64pin size
 * Author: deh
 * Latest edit: 20200115
 */

 
 
 // Nucleo plate (top)
 sidew = 5;
 lenb  = 60;
 widb  = 60;
 thick1 = 3;
 nvecx = 50;
 nvecy = 70;
 nvecz = 21;

/* Board orientation--
 usb connector & stlink unit at top
 [0,0,0] = lower left corner (extended from rounding)
*/

N64_wid    = 70;	// Width
N64_len    = 57.8; // Length including stl slot
N64_len_tot= 82.5; // Length including stl module
N64_ht_blo =  9.2; // Height: bottom pcb to bottom hdr pins
N64_ht_abv = 10.7; // Height: bottom pcb to top hdr pins
 
// Nucleo mounting 'b' hole positions
 N64_hole1 = ([  28.0,  10.8,  0]);
 N64_hole4 = ([  29.1,  59.0,  0]);
 N64_hole5 = ([  79.3,  44.1,  0]);
// Offset of above points from edge of board
 N64_holeoffset = ([0,0,0]);

/* Make one post
 * a    = translate (ref: bottom, left, corner)
 * dia1 = post dia bottom
 * dia2 = post dia top
 * dia3 = drill hole
 * ht   = Post height
 * N64_post (a,dia1,dia2,dia3,ht);
 */
module N64_post (a,dia1,dia2,dia3,ht)
{
	translate(a)
	difference()
	{
		union()
		{
			cylinder(d1=dia1,d2=dia2,h=ht,center=false);
		}
		union()
		{
			cylinder(d=dia3,h=ht,center=false);
		}
	}
}
/* Drill through post and other stuff
 * a    = translate (ref: bottom, left, corner)
 * dia  = drill dia
 * N64_post_holes (a,dia);
 */
module N64_post_holes (a,dia)
{
	translate(a)
		cylinder(d=dia,h=50,center=true);
}/* Create all three posts
 * a    = translate (ref: bottom, left, corner)
 * module N64_posts (a);
 */
module N64_posts (a)
{
	translate(a)
	translate([0,0,0])
	{
		N64_post(N64_hole1,2.9,2.9,9);
		N64_post(N64_hole4,2.9,2.9,9);
		N64_post(N64_hole5,2.9,2.9,9);
	}
}

