#region Faction Placement
if(global.genStage == gen.placeFactions and placed == false)
{
	var holder = instance_number(obj_system) - 1;
	var target = instance_find(obj_system, irandom_range(1, holder));
	
	if(!ds_list_find_index(failedList, target.id) and target.owner == pointer_null and target.planetCount > 0 and target.type != "Class W" and target.type != "Class O")
	{
		target.owner = id;
		target.ownerName = name;
		target.capitol = true;
		target.ownerColor = color1;
		target.border = true;
		target.shipyardLevel = 1;
		target.dysonLevel = 2;
		target.miningLevel = 1;
		
		target.stockpile[? "energy"] = 100;
		target.stockpile[? "metal"] = 100;
		target.stockpile[? "rareElements"] = 100;
		target.stockpile[? "gas"] = 100;
		target.stockpile[? "crystal"] = 100;
		target.stockpile[? "radioactives"] = 100;
		target.stockpile[? "food"] = 100;

		stockpile[? "alloys"] = 100;
		stockpile[? "consumerGoods"] = 100;
		stockpile[? "nanotech"] = 100;
		stockpile[? "advancedComponents"] = 100;
		
		ds_list_add(systemList, target.id);
		ds_list_add(shipyardLocations, target.id);
		
		var listPos = ds_list_find_index(global.emptySystemList, target.id);
		ds_list_delete(global.emptySystemList, listPos);
		systems = ds_list_size(systemList);
		capitolSystem = target;
		averageCenterX = target.x;
		averageCenterY = target.y;
		furthestSystem = target.id;
		
		//Settle all planets in system
		var i = 0;
		repeat(target.planetCount)
		{
			var targetPlanet = ds_list_find_value(target.planetList, i)
			
			if(targetPlanet.type == "Rocky")
			{
				targetPlanet.population = targetPlanet.maxPopulation / irandom_range(5,10);
			}
		}
		
		//Generate Habitable homeworld
		var homePos = irandom_range(0, target.planetCount-1)
		
		var targetPlanet = ds_list_find_value(target.planetList, homePos);
		capitolPlanet = targetPlanet;
			
		with(targetPlanet)
		{
			event_user(14);
		}
		
		placed = true;
		global.factionsPlaced++;
		//show_debug_message("I got placed!")
		
		//scr_addToQueue((name + " has been founded!"));
		
		//alarm[0] = room_speed;
		
		//debug fleet
		scr_spawnShip(id, capitolSystem.id, "Patrol");
	}
	else
	{
		ds_list_add(failedList, target.id);
		if(ds_list_size(failedList) >= global.genStarCount)
		{
			obj_generationmanager.factionOverride = true;
			global.genFactionCount --;
			show_debug_message("yeetus deletus");
			instance_destroy();
		}
	}
}
#endregion