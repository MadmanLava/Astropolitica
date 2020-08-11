///@desc Draws text with support for color and icon tags.
///@func scr_text(x, y, text, linebreak, scale)
///@arg x
///@arg y
///@arg text
///@arg linebreak
///@arg height

var posX = argument0;
var posY = argument1;
var text = argument2;
var lb = argument3;
var textScale = argument4;
var textHeight = string_height("M");

if(string_pos("[", text) != 0)
{

	#region Split text by tag

	var totalWidth = 0;
	var textGrid = ds_grid_create(2, 0);

	repeat(string_count("[", text))
	{
		//Append Grid
		ds_grid_resize(textGrid, 2, ds_grid_height(textGrid) + 2)
	
		//Locate tags
		var startPos = string_pos("[", text)
		var endPos = string_pos("]", text) + 1
	
		//Cut out tagged section
		var text2 = string_copy(text, startPos, endPos - startPos);
	
		#region Add each to grid
		var height = ds_grid_height(textGrid);
	
		textGrid[# 0, height-2] = string_copy(text, 1, startPos-1)
	
		#region Tag implementation
		//Color
		if(string_pos("[#", text2) != 0)
		{
			#region Color
			var colorString = string_copy(text2, 3, 9);
			var red = int64(string_copy(colorString, 1, 3));
			var green = int64(string_copy(colorString, 4, 3));
			var blue = int64(string_copy(colorString, 7, 3));
		
			var color = make_color_rgb(red, green, blue);
		
			#endregion
		
			//Remove tag syntax
			text2 = string_replace(text2, "[#" + colorString + " ", "");
			text2 = string_replace(text2, "]", "")
		}
		//Image tags
		else if(string_pos("[$", text2) != 0)
		{
			var color = -1;
		
			#region Select icon
			if(string_pos("[$energy]", text2) != 0)
			{
				text2 = spr_energy;
			}
			else if(string_pos("[$metal]", text2) != 0)
			{
				text2 = spr_metal;
			}
			else if(string_pos("[$rare]", text2) != 0)
			{
				text2 = spr_rareElements;
			}
			else if(string_pos("[$gas]", text2) != 0)
			{
				text2 = spr_gas;
			}
			else if(string_pos("[$crystal]", text2) != 0)
			{
				text2 = spr_crystal;
			}
			else if(string_pos("[$radio]", text2) != 0)
			{
				text2 = spr_radioactives;
			}
			else if(string_pos("[$food]", text2) != 0)
			{
				text2 = spr_food;
			}
			else if(string_pos("[$alloys]", text2) != 0)
			{
				text2 = spr_alloys;
			}
			else if(string_pos("[$consumer]", text2) != 0)
			{
				text2 = spr_consumerGoods;
			}
			else if(string_pos("[$nanotech]", text2) != 0)
			{
				text2 = spr_nanotech;
			}
			else if(string_pos("[$advanced]", text2) != 0)
			{
				text2 = spr_advancedComponents;
			}
			else if(string_pos("[$neutron]", text2) != 0)
			{
				text2 = spr_neutronium;
			}
			else if(string_pos("[$errono", text2) != 0)
			{
				text2 = spr_erronogen;
			}
		
			#endregion
		
		}
		else
		{
			var color = 0;
		}
	
		textGrid[# 0, height-1] = text2;
		textGrid[# 1, height-1] = color;
		#endregion
	
		text = string_copy(text, endPos, string_length(text)-startPos+1);
	
		#endregion
	}
	//Add any remaining text
	ds_grid_resize(textGrid, 2, ds_grid_height(textGrid) + 1);
	var height = ds_grid_height(textGrid);

	textGrid[# 0, height-1] = text;

	#endregion

	#region Draw text
	//Not centered
	if(draw_get_halign() != fa_center or height == 1)
	{
		var height = ds_grid_height(textGrid);
	
		var e = 0;
		repeat(height)
		{
			if(textGrid[# 1, e] == -1)
			{
				totalWidth += textHeight;
			}
			else
			{
				var tempText = textGrid[# 0, e];
				totalWidth += string_width(tempText);
			}
			e++
		}

		var tempY = posY;
		var tempX = posX;
		var tempWidth = 0;
	
		var i = 0;
		repeat(ds_grid_height(textGrid))
		{
		
			//Image check
			if(textGrid[# 1, i] == -1)
			{
				var tempText = textGrid[# 0, i];
				var scale = textHeight * textScale;
				
				draw_sprite_stretched(tempText, -1, tempX, tempY - scale/2, scale, scale);
			
				tempX += scale;
				tempWidth += scale;
			}
			else
			{
				var tempText = textGrid[# 0, i];
				tempWidth += string_width(tempText) * textScale;
				
				if(tempWidth > lb)
				{
					tempX = posX;
					tempWidth = 0;
					tempY += textHeight;
				}
				
				if(textGrid[# 1, i] == 0)
				{
					draw_text(tempX, tempY, tempText);
				}
				else
				{
					var color = textGrid[# 1, i];
					draw_text_transformed_color(tempX, tempY, tempText, textScale, textScale, 0, color, color, color, color, 1);
				}
				
				tempX += string_width(tempText) * textScale;
			}
		
			i++
		}
	}

	//Centered
	else
	{
		var height = ds_grid_height(textGrid);
	
		var e = 0;
		repeat(height)
		{
			if(textGrid[# 1, e] == -1)
			{
				totalWidth += textHeight;
			}
			else
			{
				var tempText = textGrid[# 0, e];
				totalWidth += string_width(tempText);
			}
			e++
		}
	
		var tempX = posX - totalWidth/2;
		var tempY = posY;
		var tempWidth = 0;
	
		var i = 0;
		repeat(height)
		{
			//if(tempWidth > lb/2)
			//{
			//	tempY += textHeight;
			//	tempX = posX;
			//}
		
			//Image check
			if(textGrid[# 1, i] == -1)
			{
				var tempText = textGrid[# 0, i];
				var scale = textHeight;
				tempWidth += scale;
				
				draw_sprite_stretched(tempText, -1, tempX, tempY - scale/2, scale, scale);
			
				tempX += scale;
			}
			else
			{
				var tempText = textGrid[# 0, i]
	
				if(textGrid[# 1, i] == 0)
				{
					draw_text_ext(tempX + tempWidth/2, tempY, tempText, -1, lb-tempWidth);
				}
				else
				{
					var color = textGrid[# 1, i];
					draw_text_ext_transformed_color(tempX + tempWidth/2, tempY, tempText, -1, lb-tempWidth, textScale, textScale, 0, color, color, color, color, 1);
				}

					tempX += tempWidth;
					tempWidth += string_width(tempText) * textScale;
			}
			i++
		}
	}

	#endregion

}
else
{
	draw_text_ext(posX, posY, text, -1, lb);
}