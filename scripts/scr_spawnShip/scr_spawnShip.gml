/// scr_spawnShip()
/// @arg owner
/// @arg location
/// @arg behavior

var own = argument0;
var loc = argument1;

var ship = instance_create_depth(loc.x, loc.y, -1, obj_fleet);

ship.owner = own.id;
ship.ownerName = own.name;
ship.ownerColor = own.color1;
ship.location = loc.id;
ship.behavior = argument2;