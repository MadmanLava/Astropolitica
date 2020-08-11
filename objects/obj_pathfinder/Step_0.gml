if(inTransit)
{
	move_towards_point(target.x, target.y, 20);
	image_angle = point_direction(x, y, target.x, target.y);
	
	var collide = collision_circle(x, y, 10, obj_system, false, true);
	if(collide and collide == target)
	{
		location = target;
		
		//scr_colonizeSystem(location, owner);
		
		ds_list_delete(pathList, 0);
	
		if(ds_list_size(pathList) > 0)
		{
			target = ds_list_find_value(pathList, 0);
			/*
			if(target.owner != pointer_null and target.owner != owner)
			{
				ds_list_clear(pathList);
				inTransit = false;
				target = pointer_null;
			}
			*/
		}
		else
		{
			ds_list_clear(pathList);
			inTransit = false;
			target = pointer_null;
		}
	}
}
else
{
	speed = 0;
}