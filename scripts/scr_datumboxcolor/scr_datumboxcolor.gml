///@desc Draw a box with text.
///@function scr_datumboxcolor(x, y, width, height, stretched, color, text, textcolor, linebreak, scale, sprite, contrast)
///@arg x
///@arg y
///@arg width
///@arg height
///@arg stretched
///@arg color
///@arg text
///@arg textcolor
///@arg linebreak
///@arg scale
///@arg sprite
///@arg contrast

var posX = argument0;
var posY = argument1;
var width = argument2;
var height = argument3;
var stretched = argument4;
var color = argument5;
var text = argument6;
var textcolor = argument7;
var lineBreak = argument8;
var scale = argument9;
var sprite = argument10;
var contrast = argument11;

//Draw box
scr_nine_slice(sprite, posX, posY, width, height, stretched, color);

//Draw text
draw_text_ext_transformed_color(posX + 5, posY + (height/2), text, -1, lineBreak, scale, scale, 0, textcolor, textcolor, contrast, contrast, 1);