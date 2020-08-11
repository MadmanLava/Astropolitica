instance_destroy();
x = 25000;
y = 25000;

image_xscale = 5;
image_yscale = 5;

startSys = pointer_null;
endSys = pointer_null;

target = pointer_null;
location = instance_find(obj_system, 0);

pathList = ds_list_create();
inTransit = false;

owner = instance_find(obj_faction, 0);