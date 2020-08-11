click = collision_circle(mouse_x, mouse_y, 9, obj_system, false, true);
if(click and global.allGenDone)
{
	owner = instance_find(obj_faction, 0);
	endSys = click;
	if(!inTransit)
	{
		startSys = location;
	
		scr_astar(startSys, endSys, pathList, owner);

		if(ds_list_size(pathList) > 0)
		{
			target = ds_list_find_value(pathList, 0);
			
			//alarm[0] = room_speed/6;
			inTransit = true;
		}
	}
}
else
{
	endSys = pointer_null;
}