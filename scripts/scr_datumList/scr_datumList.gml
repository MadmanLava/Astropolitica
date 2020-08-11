///@function scr_datumList(x, y, width, height, list)

///@arg1 x
///@arg1 y
///@arg1 width
///@arg1 height
///@arg1 list

var _x = argument0;
var _y = argument1;
var wid = argument2;
var hei = argument3;
var list = argument4;

var curHei = 0;

var i = 0;
repeat(ds_list_size(list))
{
	var e = ds_list_find_value(list, i);
	
	scr_datumbox(_x, _y + curHei, wid, hei, true, c_white, e, wid, 1, spr_basicBox_9slice);
	
	i ++
	curHei += hei-1;
}

return curHei;