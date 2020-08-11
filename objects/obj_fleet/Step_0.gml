if(!inTransit)
{
	if(behavior = "Patrol" and owner.systems > 1)
	{
		target = ds_list_find_value(owner.systemList, irandom_range(0, ds_list_size(owner.systemList)-1))

		if(target.id != location.id)
		{
			scr_astar_interior(location, target, pathList, owner);
			inTransit = true;
		}
	}
}
else
{
	if(ds_list_size(pathList) > 0)
	{
		ptarget = ds_list_find_value(pathList, 0);

		if(!global.paused and !global.stuck)
		{
			var spd = (5/global.gameSpeed) * 15;
			
			//Make sure no skipping over
			if(point_distance(x, y, ptarget.x, ptarget.y) > spd)
			{
				move_towards_point(ptarget.x, ptarget.y, spd);
			}
			else
			{
				location = ptarget;

				ds_list_delete(pathList, 0);
			
				if(location == target)
				{
					ds_list_clear(pathList);
					ptarget = pointer_null;
					inTransit = false;
					exit;
				}
			
				if(ds_list_size(pathList) > 0)
				{
					ptarget = ds_list_find_value(pathList, 0);
				}
			}
			
			image_angle = point_direction(x, y, ptarget.x, ptarget.y);
		}
		else
		{
			speed = 0;
		}
		
	}
	else
	{
		ds_list_destroy(pathList);
		instance_destroy();
	}
}