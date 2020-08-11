///@desc Draw a leaderboard.
///@function scr_leaderboard(queue, order, x, y, width, height, header, headerHeight, facMode, boxColor, hoverColor, numbers, suffix, round, blocked)
///@arg queue
///@arg order
///@arg x
///@arg y
///@arg width
///@arg height
///@arg header
///@arg headerHeight
///@arg facMode
///@arg boxColor
///@arg hoverColor
///@arg numbers
///@arg suffix
///@arg round
///@arg blocked

var mousex = window_mouse_get_x();
var mousey = window_mouse_get_y();

var queue = argument0;
var order = argument1;
var posX = argument2;
var posY = argument3;
var width = argument4;
var height = argument5;
var header = argument6
var headerHeight = argument7;
var facMode = argument8;
var boxColor = argument9;
var hoverColor = argument10;
var numbers = argument11;
var suffix = argument12;
var _round = argument13;
var blocked = argument14;

var drawColor = boxColor;
var returnVal = 0;

#region Set draws
if(draw_get_halign() != fa_left)
{
	draw_set_halign(fa_left);
}
if(draw_get_valign() != fa_middle)
{
	draw_set_valign(fa_middle);
}
if(draw_get_color() != c_white)
{
	draw_set_color(c_white);
}
if(draw_get_font() != fnt_defaultverysmall)
{
	draw_set_font(fnt_defaultverysmall);
}
#endregion

var textHeight = height/2;

#region Draw Header
if(header != "")
{
	scr_datumbox(posX, posY, width, headerHeight, true, c_white, header, 10000, 1, spr_basicBoxHeader_9slice);
	var boxPos = posY + headerHeight;
}
else
{
	var boxPos = posY;
}

#endregion

var i = 0;
if(order == "ascending")
{
	if(facMode)
	{
		repeat(ds_priority_size(queue))
		{
			var priority = ds_priority_find_priority(queue, ds_priority_find_max(queue));
			if(_round)
			{
				priority = floor(priority);
			}
			var target = ds_priority_delete_max(queue);
			
			#region Input
			if(point_in_rectangle(mousex, mousey, posX, boxPos+1, width, boxPos + height-1) and !blocked)
			{
				drawColor = hoverColor;
				if(mouse_check_button_released(mb_left))
				{
					returnVal = target;
				}
			}
			else
			{
				drawColor = boxColor;
			}
			#endregion
			
			#region Draw
			if(numbers)
			{
				scr_datumbox(posX, boxPos, width, height, true, drawColor, string(i+1) + ":", 10000, 1, spr_tintedBox_9slice);
				draw_text_color(posX + string_width(string(i+1) + ":   "), boxPos + textHeight, target.baseName, target.color1, target.color1, target.color2, target.color2, 1);
				draw_set_halign(fa_right);
				draw_text_color(posX + width-5, boxPos + textHeight, string(priority) + suffix, c_white, c_white, c_white, c_white, 1);
				draw_set_halign(fa_left);
			}
			else
			{
				scr_datumboxcolor(posX, boxPos, width, height, true, drawColor, target.baseName, target.color1, 10000, 1, spr_tintedBox_9slice, target.color2);
				draw_set_halign(fa_right);
				draw_text_color(posX + width-5, boxPos + textHeight, string(priority) + suffix, c_white, c_white, c_white, c_white, 1);
				draw_set_halign(fa_left);
			}
			
			#endregion
			
			boxPos += height;
			i++;
		}
	}
	else
	{
		repeat(ds_priority_size(queue))
		{
			var priority = ds_priority_find_priority(queue, ds_priority_find_max(queue));
			if(_round)
			{
				priority = floor(priority);
			}
			var target = ds_priority_delete_max(queue);
			
			#region Draw
			if(numbers)
			{
				scr_datumbox(posX, boxPos, width, height, true, drawColor, string(i+1) + ":", 10000, 1, spr_tintedBox_9slice);
				draw_text_color(posX + 10, boxPos + textHeight, target, c_white, c_white, c_white, c_white, 1);
				draw_set_halign(fa_right);
				draw_text(posX + width-5, boxPos + textHeight, string(priority) + suffix);
				draw_set_halign(fa_left);
			}
			else
			{
				scr_datumbox(posX, boxPos, width, height, true, drawColor, target, 10000, 1, spr_tintedBox_9slice);
				draw_set_halign(fa_right);
				draw_text(posX + width-5, boxPos + textHeight, string(priority) + suffix);
				draw_set_halign(fa_left);
			}
			
			#endregion
			
			boxPos += height;
			i++;
		}
	}
}
else
{
	if(facMode)
	{
		repeat(ds_priority_size(queue))
		{
			var priority = ds_priority_find_priority(queue, ds_priority_find_min(queue));
			if(_round)
			{
				priority = floor(priority);
			}
			var target = ds_priority_delete_min(queue);
			
			#region Input
			if(point_in_rectangle(mousex, mousey, posX, boxPos+1, width, boxPos + height-1) and !blocked)
			{
				drawColor = hoverColor;
				if(mouse_check_button_released(mb_left))
				{
					returnVal = target;
				}
			}
			else
			{
				drawColor = boxColor;
			}
			#endregion
			
			#region Draw
			if(numbers)
			{
				scr_datumbox(posX, boxPos, width, height, true, drawColor, string(i+1) + ":", 10000, 1, spr_tintedBox_9slice);
				draw_text_color(posX + 10, boxPos + textHeight, target.baseName, target.color1, target.color1, c_white, c_white, 1);
				draw_set_halign(fa_right);
				draw_text_color(posX + width-5, boxPos + textHeight, string(priority) + suffix, c_white, c_white, c_white, c_white, 1);
				draw_set_halign(fa_left);
			}
			else
			{
				scr_datumboxcolor(posX, boxPos, width, height, true, drawColor, target.baseName, target.color1, 10000, 1, spr_tintedBox_9slice, c_white);
				draw_set_halign(fa_right);
				draw_text_color(posX + width-5, boxPos + textHeight, string(priority) + suffix, c_white, c_white, c_white, c_white, 1);
				draw_set_halign(fa_left);
			}
			
			#endregion
			
			boxPos += height;
			i++;
		}
	}
	else
	{
		repeat(ds_priority_size(queue))
		{
			var priority = ds_priority_find_priority(queue, ds_priority_find_min(queue));
			if(_round)
			{
				priority = floor(priority);
			}
			var target = ds_priority_delete_min(queue);
			
			#region Draw
			if(numbers)
			{
				scr_datumbox(posX, boxPos, width, height, true, drawColor, string(i+1) + ":", 10000, 1, spr_tintedBox_9slice);
				draw_text_color(posX + 10, boxPos + textHeight, target, c_white, c_white, c_white, c_white, 1);
				draw_set_halign(fa_right);
				draw_text(posX + width-5, boxPos + textHeight, string(priority) + suffix);
				draw_set_halign(fa_left);
			}
			else
			{
				scr_datumbox(posX, boxPos, width, height, true, drawColor, target, 10000, 1, spr_tintedBox_9slice);
				draw_set_halign(fa_right);
				draw_text(posX + width-5, boxPos + textHeight, string(priority) + suffix);
				draw_set_halign(fa_left);
			}
			
			#endregion
			
			boxPos += height;
			i++;
		}
	}
}
//ds_queue_destroy(queue);
return(returnVal);