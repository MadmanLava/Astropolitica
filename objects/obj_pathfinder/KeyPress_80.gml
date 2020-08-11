if(!inTransit and endSys != pointer_null)
{
	startSys = location;
	
	scr_astar(startSys, endSys, pathList, instance_find(obj_faction, 0));

	if(ds_list_size(pathList) > 0)
	{
		target = ds_list_find_value(pathList, 0);
		//alarm[0] = room_speed/6;
		inTransit = true;
	}
}