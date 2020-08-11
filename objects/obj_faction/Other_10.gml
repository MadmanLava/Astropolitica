/// @desc Daily Update

#region Size Check
systems = ds_list_size(systemList)
if(systems == 0)
{
	global.genFactionCount --;
	scr_addToQueue(name + " was destroyed!", color1)
	instance_destroy();
}

var i = 0;
planets = 0;
ds_list_clear(borderSystemList)
repeat(systems)
{
	target = ds_list_find_value(systemList, i);
	planets += target.planetCount;
	
	if(target.border)
	{
		ds_list_add(borderSystemList, target);
	}
	
	i++;
}
#endregion

#region Colonization

#region Calculate Colony Ship Cost
cCost = 0;
cCost += (value[? "energy"] * 10);
cCost += (value[? "metal"] * 30);
cCost += (value[? "rareElements"] * 10);
cCost += (value[? "gas"] * 5);
cCost += (value[? "radioactives"] * 5);
cCost += (value[? "food"] * 5);

cCost += (value[? "alloys"] * 10);
cCost += (value[? "advancedComponents"] * 1);

#endregion

#region Find best colony candidate
if(!ds_list_empty(borderSystemList) and targetSystem == pointer_null and !ds_priority_empty(colonistPriority) and navalBudget > cCost and !claimActive)
{
	var i = 0;
	var candidateCount = 0;
	var bestWeight = -10000;
	var bestCandidate = pointer_null;
	var bestCandidateHost = pointer_null;
	var tar = pointer_null;
	
	repeat(ds_list_size(borderSystemList))
	{
		tar = ds_list_find_value(borderSystemList, i)
		candidateCount = ds_list_size(tar.emptyNeighbors);
		if(!ds_list_empty(candidateCount))
		{
			var e = 0;
			repeat(candidateCount)
			{
				var p = ds_list_find_value(tar.emptyNeighbors, e);
				var dist = point_distance(p.x, p.y, averageCenterX, averageCenterY)
				var weight = p.planetCount + p.habitablePlanetCount + (p.maxPopulation/10) - (dist/10);
				
				if(weight > bestWeight and p.claim == pointer_null)
				{
					bestWeight = weight;
					bestCandidate = p;
					bestCandidateHost = tar;
				}
				
				e++
			}
		}
		i++;
	}
	if(bestCandidate != pointer_null)
	{
		targetSystem = bestCandidate;
		targetSystemHost = bestCandidateHost;
	}
}
#endregion
	
#region If candidate found
else if(targetSystem != pointer_null and navalBudget > cCost and targetSystem.claim == pointer_null and !claimActive)
{
		
	#region Check if sufficient willing colonists exist
	var tempQueue = ds_priority_create();
	ds_priority_copy(tempQueue, colonistPriority);
		
	var targetPop = targetSystem.maxPopulation/100;
	targetPlanetPopsNeeded = targetPop;
	
	var sourceList = ds_list_create();
	var popsFound = false;
		
	repeat(ds_priority_size(tempQueue))
	{
		var tarPlan = ds_priority_delete_max(tempQueue)
		if(tarPlan.colonists == 0)
		{
			continue;
		}
		else
		{
			targetPop -= tarPlan.colonists;
			ds_list_add(sourceList, tarPlan);
				
			if(targetPop <= 0)
			{
				popsFound = true;
				break;
			}
				
		}
	}
	//Cleanup
	ds_priority_destroy(tempQueue);
		
	#endregion
	
	#region Grab Pops
	if(popsFound)
	{
		targetPop = targetSystem.maxPopulation/10;
		var i = 0;
		repeat(ds_list_size(sourceList))
		{
			var source = ds_list_find_value(sourceList, i);
				
			if(targetPop < source.colonists)
			{
				source.colonists -= targetPop;
				source.population -= targetPop;
				targetPop = 0;
			}
			else
			{
				targetPop -= source.colonists;
				source.population -= source.colonists;
				source.colonists = 0;
			}
				
			i++
		}
	#endregion
		
		#region Send Ship
		var b = ds_list_find_index(targetSystemHost.emptyNeighbors, targetSystem);
		ds_list_delete(targetSystemHost.emptyNeighbors, b);
		
		//scr_spawnShip(id, capitolSystem.id, "Patrol");
		
		var target = targetSystem;
		
		target.claim = id;
		claimActive = true;
		
		budget -= cCost;
		navalBudget -= cCost;
		
		spent[? "energy"] += 10;
		spent[? "metal"] += 30;
		spent[? "rareElements"] += 10;
		spent[? "gas"] += 5;
		spent[? "radioactives"] += 5;
		spent[? "food"] += 5;
		
		spent[? "alloys"] += 10;
		spent[? "advancedComponents"] += 1;
		
		var ship = ds_map_create();
		ship[? "task"] = "Colony Ship";
		ship[? "time"] = 10;
		ship[? "colonyTarget"] = target;
		
		//Find nearest shipyard
		var a = 0;
		var nearestYard = pointer_null;
		var nearestDistance = 1000000;
		repeat(ds_list_size(shipyardLocations))
		{
			var yard = ds_list_find_value(shipyardLocations, a);
			var tempDist = point_distance(yard.x, yard.y, target.x, target.y)
			if(tempDist < nearestDistance)
			{
				nearestYard = yard;
				nearestDistance = tempDist;
			}
			a++
		}
			
		//targetSystem = pointer_null;
		//targetSystemHost = pointer_null;
			
		ds_map_copy(nearestYard.shipyardTask, ship);
		ds_map_destroy(ship);
		
		//scr_addToQueue("(" + global.currentDate + ") - " + name + " launched a colony ship!", color1)
		
	}
		#endregion
	
	//Cleanup
	ds_list_destroy(sourceList);
}
else if(targetSystem != pointer_null and targetSystem.claim != pointer_null and targetSystem.claim != id)
{
	targetSystem = pointer_null;
	targetSystemHost = pointer_null;
}
//else if(targetSystem != pointer_null and targetSystem.claim != pointer_null)
//{
//	targetSystem = pointer_null;
//	targetSystemHost = pointer_null;
//}

#endregion

#endregion

#region Precalculations
if(global.currentDay == 23)
{
	#region Reset Demographics
	population = 0;
	maxPopulation = 0;
	growthRate = 0;
	happiness = 0;
	crime = 0;
	colonists = 0;
	
	#endregion
	
	#region Demographics Pull
	var i = 0;
	repeat(systems)
	{
		target = ds_list_find_value(systemList, i)
		
		population += target.population;
		maxPopulation += target.maxPopulation;
		growthRate += target.growthRate;
		happiness += target.happiness;
		crime += target.crime;
		colonists += target.colonists;
	
		i++
	}
	growthRate = growthRate/systems;
	happiness = happiness/systems;
	crime = crime/systems;
	
	#endregion
}
else if(global.currentDay == 26)
{
	#region Reset Resources

	//Income
	var size = ds_map_size(income);
	var s = ds_map_find_first(income);
	for(e = 0; e < size; e++)
	{
		ds_map_set(income, s, 0);
		s = ds_map_find_next(income, s);
	}

	//Stockpile
	size = ds_map_size(stockpile);
	s = ds_map_find_first(stockpile);
	for(e = 0; e < size; e++)
	{
		ds_map_set(stockpile, s, 0);
		s = ds_map_find_next(stockpile, s);
	}

	//Upkeep
	size = ds_map_size(upkeep);
	s = ds_map_find_first(upkeep);
	for(e = 0; e < size; e++)
	{
		ds_map_set(upkeep, s, 0);
		s = ds_map_find_next(upkeep, s);
	}

	//tax
	taxesCollected = 0;

	#endregion
}
else if(global.currentDay == 27)
{
	#region Economic Pull
	
	var i = 0;
	repeat(systems)
	{
		target = ds_list_find_value(systemList, i)
		
		#region Income
		var tIncome = target.income;
	
		income[? "energy"] += tIncome[? "energy"];
		income[? "metal"] += tIncome[? "metal"];
		income[? "rareElements"] += tIncome[? "rareElements"];
		income[? "gas"] += tIncome[? "gas"];
		income[? "crystal"] += tIncome[? "crystal"];
		income[? "radioactives"] += tIncome[? "radioactives"];
		income[? "food"] += tIncome[? "food"];
		income[? "neutronium"] += tIncome[? "neutronium"];
		income[? "erronogen"] += tIncome[? "erronogen"];
	
		income[? "alloys"] += tIncome[? "alloys"];
		income[? "consumerGoods"] += tIncome[? "consumerGoods"];
		income[? "nanotech"] += tIncome[? "nanotech"];
		income[? "advancedComponents"] += tIncome[? "advancedComponents"];
	
		#endregion
	
		#region Stockpile
		var tStock = target.stockpile;
	
		stockpile[? "energy"] += tStock[? "energy"];
		stockpile[? "metal"] += tStock[? "metal"];
		stockpile[? "rareElements"] += tStock[? "rareElements"];
		stockpile[? "gas"] += tStock[? "gas"];
		stockpile[? "crystal"] += tStock[? "crystal"];
		stockpile[? "radioactives"] += tStock[? "radioactives"];
		stockpile[? "food"] += tStock[? "food"];
		stockpile[? "neutronium"] += tStock[? "neutronium"];
		stockpile[? "erronogen"] += tStock[? "erronogen"];
	
		stockpile[? "alloys"] += tStock[? "alloys"];
		stockpile[? "consumerGoods"] += tStock[? "consumerGoods"];
		stockpile[? "nanotech"] += tStock[? "nanotech"];
		stockpile[? "advancedComponents"] += tStock[? "advancedComponents"];
	
		#endregion
	
		#region Upkeep
		var tUpkeep = target.upkeep;
	
		upkeep[? "energy"] += tUpkeep[? "energy"];
		upkeep[? "metal"] += tUpkeep[? "metal"];
		upkeep[? "rareElements"] += tUpkeep[? "rareElements"];
		upkeep[? "gas"] += tUpkeep[? "gas"];
		upkeep[? "crystal"] += tUpkeep[? "crystal"];
		upkeep[? "radioactives"] += tUpkeep[? "radioactives"];
		upkeep[? "food"] += tUpkeep[? "food"];
		upkeep[? "neutronium"] += tUpkeep[? "neutronium"];
		upkeep[? "erronogen"] += tUpkeep[? "erronogen"];
	
		upkeep[? "alloys"] += tUpkeep[? "alloys"];
		upkeep[? "consumerGoods"] += tUpkeep[? "consumerGoods"];
		upkeep[? "nanotech"] += tUpkeep[? "nanotech"];
		upkeep[? "advancedComponents"] += tUpkeep[? "advancedComponents"];
	
		#endregion
	
		#region Taxes
		taxesCollected += target.taxesPaid;

		#endregion
		
	}
	
	#endregion
}
else if(global.currentDay == 29)
{
	
}

#endregion