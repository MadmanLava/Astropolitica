/// @desc Movement step

if(ds_list_size(pathList) > 0)
{
	target = ds_list_find_value(pathList, 0);
	
	location = target;
	
	x = target.x;
	y = target.y;
	
	ds_list_delete(pathList, 0);
	
	alarm[0] = room_speed/6;
}
else
{
	ds_list_clear(pathList);
	inTransit = false;
	target = pointer_null;
}