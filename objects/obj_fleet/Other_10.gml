/// @desc Daily step
exit;

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

if(inTransit)
{
	if(ptarget = pointer_null and ds_list_size(pathList) > 0)
	{
		ptarget = ds_list_find_value(pathList, 0);
		timeToDestination = 1//point_distance(ptarget.x, ptarget.y, x, y);
		progressToDestination = 0;
	}

	progressToDestination += baseSpeed;
	//image_angle = point_direction(x, y, ptarget.x, ptarget.y);
		
	//If destination reached
	if(progressToDestination >= timeToDestination)
	{
		location = ptarget;
		x = ptarget.x;
		y = ptarget.y;
		
		ds_list_delete(pathList, 0);
			
		if(location == target)
		{
			ds_list_clear(pathList);
			inTransit = false;
			ptarget = pointer_null;
			timeToDestination = 0;
			progressToDestination = 0;
		}
		else
		{
			ptarget = ds_list_find_value(pathList, 0);
			//image_angle = point_direction(x, y, ptarget.x, ptarget.y);
		}
	}
}