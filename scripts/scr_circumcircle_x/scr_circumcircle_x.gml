/// @description scr_circumcircle_x( x1, y1, x2, y2, x3, y3 )
/// @param  x1
/// @param  y1
/// @param  x2
/// @param  y2
/// @param  x3
/// @param  y3 

var _x1 = argument0;
var _y1 = argument1;
var _x2 = argument2;
var _y2 = argument3;
var _x3 = argument4;
var _y3 = argument5;

var _a = _x1*_x1 + _y1*_y1;
var _b = _x2*_x2 + _y2*_y2;
var _c = _x3*_x3 + _y3*_y3;

var _cx = _a*( _y3 - _y2 ) + _b*( _y1 - _y3 ) + _c*( _y2 - _y1 );
_cx /= _x1*( _y3 - _y2 ) + _x2*( _y1 - _y3 ) + _x3*( _y2 - _y1 );
_cx *= 0.5;

return _cx;