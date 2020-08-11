/// @desc Run monthly update
// All checks must run in an bottom-up order of hierarchy to correctly maintain the order of events!

with(obj_planetParent)
{
	event_user(1);
}
with(obj_systemParent)
{
	event_user(1);
}
with(obj_faction)
{
	event_user(1);
}
with(obj_newuimanager)
{
	event_user(1);
}