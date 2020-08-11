/// lines_intersect(x1, y1, x2, y2, x3, y3, x4, y4, segment)
//If segment is true, confine the test to the line segments.
{
	var ua, ub, ud, ux, uy, vx, vy, wx, wy;
	ua = 0;
	ux = argument2 - argument0;
	uy = argument3 - argument1;
	vx = argument6 - argument4;
	vy = argument7 - argument5;
	wx = argument0 - argument4;
	wy = argument1 - argument5;
	ud = vy * ux - vx * uy;
	if(ud != 0)
	{
		ua = (vx * wy - vy * wx) / ud;
		if (argument8)
		{
			ub = (ux * wy - uy * wx) / ud;
			if(ua < 0 || ua > 1 || ub < 0 || ub > 1) ua = 0;
		}
	}
	return ua;
}