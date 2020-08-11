#region Prune redundant lanes

if(global.genStage == gen.pruneLanes and !global.lanesPruned)
{
	var i = 0;
	repeat(ds_grid_height(lanePairs))
	{
		#region lagcheck
		if(current_time - global.startTime > 8)
		{
			continue;
		}
		#endregion
		
		var firstPair = ds_grid_get(lanePairs, 0, i);
		var firstPartner = ds_grid_get(lanePairs, 1, i);
		
		if(firstPair == firstPartner)
		{
			ds_grid_set_region(lanePairs, firstPair, i, firstPartner, i, 0);
		}
		
		if(firstPair != 0 and firstPair.id != obj_camera.id)
		{
			var ib = 0;
			repeat(ds_grid_height(lanePairs))
			{
				#region lagcheck
				if(current_time - global.startTime > 8)
				{
					continue;
				}
				#endregion
				
				var secondPair = ds_grid_get(lanePairs, 1, ib);
				var secondPartner = ds_grid_get(lanePairs, 0, ib);
				
				if(secondPair != 0 and secondPair.id != obj_camera.id)
				{
					if(secondPair == firstPair and secondPartner == firstPartner)
					{
						ds_grid_set_region(lanePairs, secondPartner, ib, secondPair, ib, 0);
						//show_debug_message("Yeeted a lane!");
						global.genHyperlaneCount -= 1;
					}
					else if(firstPair == secondPartner and secondPair == firstPartner)
					{
						ds_grid_set_region(lanePairs, secondPartner, ib, secondPair, ib, 0);
					}
				}
				ib++
			}
		}
		
		i++
	}
	
	var camX = global.camX;
	var camY = global.camY;
	var camWid = global.camWid;
	var camHei = global.camHei;
	
	//Vertex testing
	vertex_begin(v_buff, lane_format)
	
	var lanestep = 0;
	
		repeat(ds_grid_height(lanePairs))
		{
			var neigh1 = ds_grid_get(lanePairs, 0, lanestep);
			var neigh2 = ds_grid_get(lanePairs, 1, lanestep);
			if(neigh1 != 0)
			{
				//Broken, culling should not occur when generating
				//if(point_in_rectangle(neigh1.x, neigh1.y, camX, camY, camX + camWid, camY + camHei))
				//{
					vertex_position(v_buff, neigh1.x, neigh1.y);
					vertex_color(v_buff, c_gray, 1);
	
					vertex_position(v_buff, neigh2.x, neigh2.y);
					vertex_color(v_buff, c_gray, 1);
				//}
			}
			lanestep++;
		}
	
	vertex_end(v_buff);
	global.lanesPruned = true;
	
	//Determine galactic radius
	var temp = instance_furthest(25000, 25000, obj_system);
	global.genRadius = point_distance(25000, 25000, temp.x, temp.y) + 10;
	global.furthestSystem = temp;
}
#endregion