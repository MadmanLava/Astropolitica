image_speed = 0;

#region Faction Data
owner = pointer_null;
ownerName = pointer_null;
ownerColor = c_white;

#endregion

#region Motion
behavior = "Patrol";
baseSpeed = 1;

ptarget = pointer_null;
timeToDestination = 0;
progressToDestination = 0;

location = pointer_null;

target = pointer_null;

pathList = ds_list_create();

inTransit = false;

#endregion

#region Fleet Data
size = 0;

#endregion