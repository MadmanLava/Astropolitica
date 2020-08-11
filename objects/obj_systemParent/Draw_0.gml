//test borders
exit;

if(global.drawCountryNames and ownerName != "Unsettled")
{
	var i = 0;
	repeat(ds_list_size(neighbors))
	{
		var target = ds_list_find_value(neighbors, i);
		
		if(target.ownerName != ownerName and target.ownerName != "Unsettled")
		{
			var angle = point_direction(x, y, target.x, target.y);
		
			if(x < target.x)
			{
				var sX = (target.x - x) / 2 + x
			
				if(y < target.y)
				{
					var sY = (target.y - y) / 2 + y;
				}
				else
				{
					var sY = (y - target.y) / 2 + target.y;
				}
			}
			else
			{
				var sX = (x - target.x) / 2 + target.x
			
				if(y < target.y)
				{
					var sY = (target.y - y) / 2 + y;
				}
				else
				{
					var sY = (y - target.y) / 2 + target.y;
				}
			}
		
			draw_sprite_ext(spr_border, 0, sX, sY, 0.5, 2, angle, c_white, 1);
		
		}
		
		i++;
	}
}