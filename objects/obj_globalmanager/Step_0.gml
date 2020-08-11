if(room == mainmenu)
{
	global.pruneRadius = global.laneRadius - 50;
}
//global.avgLaneCount = global.genHyperlaneCount/global.starCount;

global.camX = camera_get_view_x(cam);
global.camY = camera_get_view_y(cam);
global.camWid = camera_get_view_width(cam);
global.camHei = camera_get_view_height(cam);