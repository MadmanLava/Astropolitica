///@desc Create a selectable dropdown list
///@function scr_dropdown(x, y, width, height, sprite1, sprite2, sprColor1, sprColor2, hoverColor, queue, font, textColor, textScale, selected, open)
///@arg x
///@arg y
///@arg width
///@arg height
///@arg sprite1
///@arg sprite2
///@arg sprColor1
///@arg sprColor2
///@arg hoverColor
///@arg queue
///@arg font
///@arg textColor
///@arg textScale
///@arg selected
///@arg open

var xPos = argument0;
var yPos = argument1;
var width = argument2;
var height = argument3;
var sprite1 = argument4;
var sprite2 = argument5;
var sprColor1 = argument6;
var sprColor2 = argument7;
var hoverColor = argument8
var queue = argument9;
var font = argument10;
var textColor = argument11;
var textScale = argument12;
var selected = argument13;
var open = argument14;

var mousex = window_mouse_get_x();
var mousey = window_mouse_get_y();
var listSize = ds_queue_size(queue);

#region Draw sets
if(draw_get_halign() != fa_left)
{
	draw_set_halign(fa_left);
}
if(draw_get_valign() != fa_middle)
{
	draw_set_valign(fa_middle);
}
if(draw_get_font() != font)
{
	draw_set_font(font);
}

var listHeight = string_height("M")
var textHeight = listHeight/2;
var relY = yPos + height;
#endregion

#region Top Box
#region Input
if(point_in_rectangle(mousex, mousey, xPos, yPos, xPos + width, yPos + height))
{
	var drawColor = hoverColor;
	if(mouse_check_button_released(mb_left))
	{
		if(open)
		{
			open = false;
			ds_queue_destroy(queue);
			return(false);
		}
		else
		{
			open = true;
			ds_queue_destroy(queue);
			return(true);
		}
		
	}
}
else
{
	var drawColor = sprColor1;
}
#endregion

scr_nine_slice(sprite1, xPos, yPos, width, height, true, drawColor);
draw_text_transformed_color(xPos + 5, yPos + height/2, selected, textScale, textScale, 0, textColor, textColor, textColor, textColor, 1);

#endregion

#region Opened list
if(open)
{
	var i = 0;
	drawColor = sprColor2;
	repeat(listSize)
	{
		//Retrieve entry
		var entry = ds_queue_dequeue(queue);
		
		#region Input
		if(point_in_rectangle(mousex, mousey, xPos, relY, xPos + width, relY + listHeight))
		{
			drawColor = hoverColor;
			
			if(mouse_check_button_released(mb_left))
			{
				ds_queue_destroy(queue);
				return(entry);
			}
		}
		else
		{
			drawColor = sprColor2;
		}
		
		#endregion
		
		//Draw entry and text
		scr_nine_slice(sprite2, xPos, relY, width, listHeight, true, drawColor)
		draw_text_transformed_color(xPos+5, relY + textHeight, entry, textScale, textScale, 0, textColor, textColor, textColor, textColor, 1);
		relY += listHeight;
		i++;
	}
	ds_queue_destroy(queue);
	return(true);
}

#endregion