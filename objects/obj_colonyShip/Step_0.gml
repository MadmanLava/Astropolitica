//if(target != pointer_null and global.paused == false)
//{
//	move_towards_point(target.x, target.y, 20);
//	image_angle = point_direction(x, y, target.x, target.y);
//	var collide = collision_circle(x, y, 4, obj_system, false, true);
//	if(collide and collide == target)
//	{
//		scr_colonizeSystem(target, owner);
//		instance_destroy();
//	}
//}
//else
//{
//	speed = 0;
//}

if(!inTransit)
{
	inTransit = true;
	scr_astar_interior(location, target, pathList, owner);
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
					owner.claimActive = false;
					scr_colonizeSystem(target, owner);
					ds_list_destroy(pathList);
					instance_destroy();
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