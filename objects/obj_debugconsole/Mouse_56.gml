///@desc Enter or exit typing.
var mousex = window_mouse_get_x();
var mousey = window_mouse_get_y();

if(point_in_rectangle(mousex, mousey, 0, 580, 400, 600))
{
	typing = true;
	keyboard_string = inputHolder;
}
else
{
	typing = false;
}