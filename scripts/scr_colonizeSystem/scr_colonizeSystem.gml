///Arg0: Target System
///Arg1: Faction

var target = argument0;
var faction = argument1;

if(target.owner != pointer_null)
{
	var oldPos = ds_list_find_index(target.owner.systemList, target);
	ds_list_delete(target.owner.systemList, oldPos);
}

target.owner = faction;
target.ownerName = faction.name;
target.ownerColor = faction.color1;

ds_list_add(faction.systemList, target.id);
faction.systems ++;

if(faction.systems == 2)
{
	faction.milestones[? "colony1"] = true;
	scr_addToQueue("(" + global.currentDate + ") - " + faction.name + " settled its first system!", faction.color1)
}
else if(faction.systems == 10)
{
	faction.milestones[? "colony2"] = true;
	scr_addToQueue("(" + global.currentDate + ") - " + faction.name + " settled its 10th system!", faction.color1)
}
else if(faction.systems == 100)
{
	faction.milestones[? "colony3"] = true;
	scr_addToQueue("(" + global.currentDate + ") - " + faction.name + " settled its 100th system!", faction.color1)
}

var listPos = ds_list_find_index(global.emptySystemList, target)
ds_list_delete(global.emptySystemList, listPos);

if(ds_list_empty(global.emptySystemList))
{
	scr_addToQueue("(" + global.currentDate + ") - All systems are colonized!", c_white)
}

target.claim = pointer_null;
faction.claimActive = false;
faction.targetSystem = pointer_null;
faction.targetSystemHost = pointer_null;
faction.planets += target.planetCount;

with(faction)
{
	var xHolder = 0;
	var yHolder = 0;
	var i = 0;
	var tar = pointer_null;
	
	with(obj_system)
	{
		event_user(15);
	}
	
	ds_list_clear(borderSystemList);
	repeat(systems)
	{
		tar = ds_list_find_value(systemList, i).id;
		xHolder = xHolder + tar.x;
		yHolder = yHolder + tar.y;
		
		if(tar.border)
		{
			ds_list_add(borderSystemList, tar);
		}
		
		i++
	}
	averageCenterX = xHolder / systems;
	averageCenterY = yHolder / systems;
	
}

var dist = point_distance(faction.averageCenterX, faction.averageCenterY, target.x, target.y)
if(dist > faction.averageRadius)
{
	faction.furthestSystem = target.id;
	faction.averageRadius = point_distance(faction.averageCenterX, faction.averageCenterY, target.x, target.y);		
}

with(target)
{
	event_user(2);
	event_user(13);
}