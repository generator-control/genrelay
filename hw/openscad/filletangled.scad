/* File: fillet_tri.scad 
 * rr = rotation angle (vector)
 * dd = dia of round
 * ll = length of sides
 * aa = angle (degs)
 */
module fillet_tri(ll,zz,aa)
{
	a1x = 0;  a1y = 0;
   a2x = ll; a2y = 0;
   a3x = ll * cos(aa);
   a3y = ll * sin(aa);

//	difference()
	{
		union()
		{
	   	linear_extrude(height = zz,center=false,convexity=10)
   		{
     			polygon(points=[[a1x,a1y],[a2x,a2y],[a3x,a3y]]);
   		}
		}
		union()
		{
		}
	}
}
module fillet_cir(ll,zz,aa,r,m)
{
    t2 = ll - cos(aa/2);
    t3 = t2 - m;
    mx = t3*cos(aa/2);
    my = t3*sin(aa/2);
    t4 = (t3+r);
    rx = t4*cos(aa/2);
    ry = t4*sin(aa/2);
    
	difference()
	{
		union()
		{
            fillet_tri(ll,zz,aa);
		}
		union()
		{
            translate([rx,ry,-0.05])
            cylinder(d = 2*r,h=zz+.05,center=false,$fn=100);
		}
	}
    
}

//fillet_cir(25,4,120,70,16);

