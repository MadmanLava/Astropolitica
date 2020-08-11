///@arg text
///@arg color

var queue = obj_newuimanager.evQueue;
var height = ds_grid_height(queue);

ds_grid_resize(queue, 2, height+1)

queue[# 0, height] = argument0;
queue[# 1, height] = argument1;

/*
with(obj_newuimanager)
{
	event_user(0);
}
*/