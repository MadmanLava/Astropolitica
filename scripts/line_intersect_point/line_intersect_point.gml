///line_intersect_point(x1, y1, x2, y2, x3, y3, x4, y4)
var _t = lines_intersect(argument[0],
						argument[1],
						argument[2],
						argument[3],
						argument[4],
						argument[5],
						argument[6],
						argument[7],
						true);
						
if(_t > 0 && _t <= 1)
{
	var _point;
	_point[0] = argument[0] + _t * (argument[2] - argument[0]);
	_point[1] = argument[1] + _t * (argument[3] - argument[1]);
	
	return _point;
}
else
{
	return noone;
}