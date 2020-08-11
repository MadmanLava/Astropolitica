///@desc Open an inspector window, and optionally move the camera to the relevant entity.
///@function scr_openInspector(object, type, focus)
///@arg object
///@arg type
///@arg focus

var object = argument0;
var type = argument1;
var focus = argument2;

var camera = view_camera[0];
var camWid = camera_get_view_width(camera);
var camHei = camera_get_view_height(camera);

if(type == "system")
{
	obj_newuimanager.menuRight = 0;
	obj_newuimanager.selectedPlanet = pointer_null;
	obj_newuimanager.selectedFaction = pointer_null;
	obj_newuimanager.selected = object;
	if(focus)
	{
		camera_set_view_pos(camera, object.x - camWid/2, object.y - camHei/2);
	}
}
else if(type == "planet")
{
	obj_newuimanager.menuRight = 1;
	obj_newuimanager.selected = pointer_null;
	obj_newuimanager.selectedFaction = pointer_null;
	obj_newuimanager.selectedPlanet = object;
	if(focus)
	{
		camera_set_view_pos(camera, object.system.x - camWid/2, object.system.y - camHei/2);
	}
}
else if(type == "faction")
{
	obj_newuimanager.menuRight = 2;
	obj_newuimanager.selected = pointer_null;
	obj_newuimanager.selectedPlanet = pointer_null;
	obj_newuimanager.selectedFaction = object;
	if(focus)
	{
		camera_set_view_pos(camera, object.averageCenterX - camWid/2, object.averageCenterY - camHei/2);
	}
}

with(obj_newuimanager)
{
	uiSurfRightScroll = 0;
	freezeInput = true;
	event_user(1);
}