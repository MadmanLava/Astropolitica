///@desc Draw an interactive button(s)
///@function scr_button(x, y, width, height, sprite, stretched, buttonmode, hold, value, mousex, mousey, rate, min, max)

///@arg x
///@arg y
///@arg width
///@arg height
///@arg sprite
///@arg stretched
///@arg mode
///@arg hold
///@arg value
///@arg mousex
///@arg mousey
///@arg rate
///@arg min
///@arg max

var posX = argument0;
var posY = argument1;
var width = argument2;
var height = argument3;
var sprite = argument4;
var stretched = argument5;
var buttonmode = argument6;
var hold = argument7;
var val = argument8;
var mousex = argument9;
var mousey = argument10;
var rate = argument11;
var _min = argument12;
var _max = argument13;

if(buttonmode == "toggle")
{
	//Color
	if(val)
	{
		draw_sprite(spr_menuButton, 2, posX + width/2, posY + width/2)
	}
	else
	{
		draw_sprite(spr_menuButton, 3, posX + width/2, posY + width/2)
	}
	
	//Input
	if(point_in_rectangle(mousex, mousey, posX, posY, posX + width, posY + height) and mouse_check_button_released(mb_left))
	{
		audio_play_sound(sfx_select, -1, false);
		
		if(val)
		{
			val = false;
		}
		else
		{
			val = true;
		}
	}
}
else if(buttonmode == "value")
{
	//Draw Button
	draw_sprite(spr_menuButton, 0, posX + width/2, posY + width/2)
	draw_sprite(spr_menuButton, 1, posX + width*1.5, posY + width/2)
	
	//Input
	if(hold)
	{
		if(mouse_check_button(mb_left))
		{
			if(point_in_rectangle(mousex, mousey, posX, posY, posX + width, posY + height))
			{
				val += rate;
			}
			else if(point_in_rectangle(mousex, mousey, posX + width, posY, posX + width*2, posY + height))
			{
				val -= rate;
			}
		}
	}
	else
	{
		if(mouse_check_button_released(mb_left))
		{
			
			if(point_in_rectangle(mousex, mousey, posX, posY, posX + width, posY + height))
			{
				val += rate;
				
				audio_play_sound(sfx_select, -1, false);
			}
			else if(point_in_rectangle(mousex, mousey, posX + width, posY, posX + width*2, posY + height))
			{
				val -= rate;
				
				audio_play_sound(sfx_select, -1, false);
			}
		}
	}
	if(val < _min)
	{
		val = _min;
	}
	else if(val > _max)
	{
		val = _max;
	}
}
return val;