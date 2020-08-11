///@function scr_slider(x, y, mousex, mousey, width, sprite, scale, value, min, max, button, buttonPos, default)
///@arg x
///@arg y
///@arg mousex
///@arg mousey
///@arg width
///@arg sprite
///@arg scale
///@arg value
///@arg min
///@arg max
///@arg button
///@arg buttonPos
///@arg default

var posX = argument0;
var posY = argument1;
var mouseX = argument2;
var mouseY = argument3;
var width = argument4;
var sprite = argument5;
var scale = argument6;
var value = argument7;
var valMin = argument8;
var valMax = argument9;
var doButton = argument10;
var buttonX = argument11;
var valDefault = argument12;

value = clamp(value, valMin, valMax);

var relPosX = posX + (((value - valMin)/(valMax-valMin)) * width);
var relPosY = posY + 2.5;
var spriteWidth = (sprite_get_width(sprite)/2)*scale;

//Draw line
scr_nine_slice(spr_basicBox_9slice, posX, posY, width, 5, true, c_white);

//button
if(doButton)
{
	draw_sprite(spr_menuButton, 4, buttonX, relPosY);
	
	if(mouse_check_button(mb_left) and point_in_rectangle(mouseX, mouseY, buttonX - 8, relPosY - 8, buttonX + 8, relPosY + 8))
	{
		value = valDefault;
		draw_sprite_ext(sprite, 0, relPosX, relPosY, scale, scale, 0, c_white, 1);
		return(value);
	}
}

if(mouse_check_button(mb_left) and point_in_rectangle(mouseX, mouseY, posX-spriteWidth, relPosY-(spriteWidth), posX + width + spriteWidth, relPosY+(spriteWidth)))
{
	var value = ((mouseX-posX)/width) * (valMax-valMin);
	
	
	if(value > valMax-valMin)
	{
		value = valMax-valMin;
	}
	else if(value < 0)
	{
		value = 0;
	}
	
	
	relPosX = posX + (((value)/(valMax-valMin)) * width);
	clamp(relPosX, 0, posX + width);
	draw_sprite_ext(sprite, 1, relPosX, relPosY, scale, scale, 0, c_white, 1);
	
	return(value + valMin);
}
else
{
	draw_sprite_ext(sprite, 0, relPosX, relPosY, scale, scale, 0, c_white, 1);
	
	return(value);
}