/// @desc Full Monthly Step

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

#region Data Pull

#region Size Check
systems = ds_list_size(systemList)
if(systems == 0)
{
	global.genFactionCount --;
	instance_destroy();
}
#endregion

#endregion

#region Administrative Costs
adminCosts = (systems * 5) + (planets * 2) + (population/1000);

#endregion

#region Trade

#region Find list
i = 0;
var desireList = ds_list_create();
var target = pointer_null;
repeat(systems)
{
	target = ds_list_find_value(systemList, i)
	if(target.desiresResources)
	{
		ds_list_add(desireList, target);
	}
	
	i++
}
budget += taxesCollected;

#endregion

if(ds_list_size(desireList) > 0)
{
	var i = 0;
	repeat(ds_list_size(desireList))
	{
		var target = ds_list_find_value(desireList, i);
		var want = target.desired;
		
		#region Energy
		if(ds_map_exists(want, "energy"))
		{
			if(!ds_priority_empty(energyRanking))
			{
				var subTarget = ds_priority_find_max(energyRanking);
				var temp = ds_priority_find_priority(energyRanking, subTarget);
			
				if(subTarget.id != target.id and temp > 0 and temp > want[? "energy"] and subTarget.infraSavingFor == "")
				{
					target.stockpile[? "energy"] += want[? "energy"]
					subTarget.stockpile[? "energy"] -= want[? "energy"];
					ds_priority_change_priority(energyRanking, subTarget, subTarget.stockpile[? "energy"] - subTarget.stockQuota[? "energy"]);

				}
			}
		}
		#endregion
		
		#region Metal
		if(ds_map_exists(want, "metal"))
		{
			if(!ds_priority_empty(metalRanking))
			{
				var subTarget = ds_priority_find_max(metalRanking);
				var temp = ds_priority_find_priority(metalRanking, subTarget);
			
				if(subTarget.id != target.id and temp > 0 and temp > want[? "metal"] and subTarget.infraSavingFor == "")
				{
					target.stockpile[? "metal"] += want[? "metal"]
					subTarget.stockpile[? "metal"] -= want[? "metal"];
					ds_priority_change_priority(metalRanking, subTarget, subTarget.stockpile[? "metal"]);

				}
			}
		}
		#endregion
		
		#region Rare Elements
		if(ds_map_exists(want, "rareElements"))
		{
			if(!ds_priority_empty(RERanking))
			{
				var subTarget = ds_priority_find_max(RERanking);
				var temp = subTarget.stockpile[? "rareElements"] - subTarget.stockQuota[? "rareElements"];
			
				if(subTarget != target and temp > 0 and temp > want[? "rareElements"] and subTarget.infraSavingFor == "")
				{
					target.stockpile[? "rareElements"] += want[? "rareElements"]
					subTarget.stockpile[? "rareElements"] -= want[? "rareElements"];
					ds_priority_change_priority(RERanking, subTarget, subTarget.stockpile[? "rareElements"]);

				}
			}
		}
		#endregion
		
		#region Gas
		if(ds_map_exists(want, "gas"))
		{
			if(!ds_priority_empty(gasRanking))
			{
				var subTarget = ds_priority_find_max(gasRanking);
				var temp = ds_priority_find_priority(gasRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "gas"] and subTarget.infraSavingFor != "mining")
				{
					target.stockpile[? "gas"] += want[? "gas"]
					subTarget.stockpile[? "gas"] -= want[? "gas"];
					ds_priority_change_priority(gasRanking, subTarget, subTarget.stockpile[? "gas"]);

				}
			}
		}
		#endregion
		
		#region Crystal
		if(ds_map_exists(want, "crystal"))
		{
			if(!ds_priority_empty(crystalRanking))
			{
				var subTarget = ds_priority_find_max(crystalRanking);
				var temp = ds_priority_find_priority(crystalRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "crystal"])
				{
					target.stockpile[? "crystal"] += want[? "crystal"]
					subTarget.stockpile[? "crystal"] -= want[? "crystal"];
					ds_priority_change_priority(crystalRanking, subTarget, subTarget.stockpile[? "crystal"] and subTarget.infraSavingFor != "dyson");

				}
			}
		}
		#endregion
		
		#region Food
		if(ds_map_exists(want, "food"))
		{
			if(!ds_priority_empty(foodRanking))
			{
				var subTarget = ds_priority_find_max(foodRanking);
				var temp = ds_priority_find_priority(foodRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "food"])
				{
					target.stockpile[? "food"] += want[? "food"]
					subTarget.stockpile[? "food"] -= want[? "food"];
					ds_priority_change_priority(foodRanking, subTarget, subTarget.stockpile[? "food"]);

				}
			}
		}
		#endregion
		
		#region Alloys
		if(ds_map_exists(want, "alloys"))
		{
			if(!ds_priority_empty(alloysRanking))
			{
				var subTarget = ds_priority_find_max(alloysRanking);
				var temp = ds_priority_find_priority(alloysRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "alloys"])
				{
					target.stockpile[? "alloys"] += want[? "alloys"]
					subTarget.stockpile[? "alloys"] -= want[? "alloys"];
					ds_priority_change_priority(alloysRanking, subTarget, subTarget.stockpile[? "alloys"]);

				}
			}
		}
		#endregion
		
		#region Consumer Goods
		if(ds_map_exists(want, "consumerGoods"))
		{
			if(!ds_priority_empty(consumerRanking))
			{
				var subTarget = ds_priority_find_max(consumerRanking);
				var temp = ds_priority_find_priority(consumerRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "consumerGoods"])
				{
					target.stockpile[? "consumerGoods"] += want[? "consumerGoods"]
					subTarget.stockpile[? "consumerGoods"] -= want[? "consumerGoods"];
					ds_priority_change_priority(consumerRanking, subTarget, subTarget.stockpile[? "consumerGoods"]);

				}
			}
		}
		#endregion
		
		#region Nanotech
		if(ds_map_exists(want, "nanotech"))
		{
			if(!ds_priority_empty(nanoRanking))
			{
				var subTarget = ds_priority_find_max(nanoRanking);
				var temp = ds_priority_find_priority(nanoRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "nanotech"])
				{
					target.stockpile[? "nanotech"] += want[? "nanotech"]
					subTarget.stockpile[? "nanotech"] -= want[? "nanotech"];
					ds_priority_change_priority(nanoRanking, subTarget, subTarget.stockpile[? "nanotech"]);

				}
			}
		}
		#endregion
		
		#region Advanced Components
		if(ds_map_exists(want, "advancedComponents"))
		{
			if(!ds_priority_empty(advancedRanking))
			{
				var subTarget = ds_priority_find_max(advancedRanking);
				var temp = ds_priority_find_priority(advancedRanking, subTarget);
			
				if(subTarget != target and temp > 0 and temp > want[? "advancedComponents"])
				{
					target.stockpile[? "advancedComponents"] += want[? "advancedComponents"]
					subTarget.stockpile[? "advancedComponents"] -= want[? "advancedComponents"];
					ds_priority_change_priority(advancedRanking, subTarget, subTarget.stockpile[? "advancedComponents"]);

				}
			}
		}
		#endregion
		
		i++
	}
}
ds_list_destroy(desireList);

#endregion

#region Calculate new resource values
value = scr_resourceValue(id);

#endregion