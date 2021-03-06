///@desc Draw a box with text.
///@function scr_datumbox(x, y, width, height, stretched, color, text, linebreak, scale, sprite)
///@arg x
///@arg y
///@arg width
///@arg height
///@arg stretched
///@arg color
///@arg text
///@arg linebreak
///@arg scale
///@arg sprite

var posX = argument0;
var posY = argument1;
var width = argument2;
var height = argument3;
var stretched = argument4;
var color = argument5;
var text = argument6;
var lineBreak = argument7;
var scale = argument8;
var sprite = argument9;

//Draw box
//var lineCount = floor(string_width(text)/lineBreak) + 1;
//if(string_width(text) > lineBreak)
//{
//	height = height * (lineCount-1);
//}
scr_nine_slice(sprite, posX, posY, width, height, stretched, color);

//Draw text
//scr_text(posX + 5, posY + (height/lineCount), text, lineBreak, scale)
draw_text_ext_transformed(posX + 5, posY + (height/2), text, -1, lineBreak, scale, scale, 0);
//scribble_draw(posX + 5, posY + (height/2), text);

//return(height);