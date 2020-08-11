/// @desc Monthly Step

if(owner == pointer_null)
{
	exit;
}

#region Economy

#region Desired Resources
desiresResources = false;
var z = 0;

var asize = ds_map_size(stockpile);
var s = ds_map_find_first(stockpile);
var e = ds_map_find_first(stockQuota);
var d = ds_map_find_first(desired);

for(z = 0; z < asize; z++)
{
	if(ds_map_find_value(stockpile, s) < ds_map_find_value(stockQuota, e))
	{
		desired[? d] += (ds_map_find_value(stockQuota, e) - ds_map_find_value(stockpile, s));
		desiresResources = true;
		
	}
	else
	{
		desired[? d] = 0;
	}
	
	s = ds_map_find_next(stockpile, s);
	e = ds_map_find_next(stockQuota, e);
	d = ds_map_find_next(desired, d);
}
	
#endregion

#region Resource Ranking

#region Energy

var temp = stockpile[? "energy"] - stockQuota[? "energy"];

if(is_undefined(ds_priority_find_priority(owner.energyRanking, id)))
{
	if(temp > 0)
	{
		ds_priority_add(owner.energyRanking, id, temp);
	}
}
else
{
	if(temp > 0)
	{
		ds_priority_change_priority(owner.energyRanking, id, temp);
	}
}
#endregion

#region Metal
if(is_undefined(ds_priority_find_priority(owner.metalRanking, id)))
{
	ds_priority_add(owner.metalRanking, id, stockpile[? "metal"] - stockQuota[? "energy"]);
}
else
{
	ds_priority_change_priority(owner.metalRanking, id, stockpile[? "metal"] - stockQuota[? "energy"]);
}
#endregion

#region Rare Elements
if(is_undefined(ds_priority_find_priority(owner.RERanking, id)))
{
	ds_priority_add(owner.RERanking, id, stockpile[? "rareElements"] - stockQuota[? "rareElements"]);
}
else
{
	ds_priority_change_priority(owner.RERanking, id, stockpile[? "rareElements"] - stockQuota[? "rareElements"]);
}
#endregion

#region Gas
if(is_undefined(ds_priority_find_priority(owner.gasRanking, id)))
{
	ds_priority_add(owner.gasRanking, id, stockpile[? "gas"] - stockQuota[? "gas"]);
}
else
{
	ds_priority_change_priority(owner.gasRanking, id, stockpile[? "gas"] - stockQuota[? "gas"]);
}
#endregion

#region Crystal
if(is_undefined(ds_priority_find_priority(owner.crystalRanking, id)))
{
	ds_priority_add(owner.crystalRanking, id, stockpile[? "crystal"] - stockQuota[? "crystal"]);
}
else
{
	ds_priority_change_priority(owner.crystalRanking, id, stockpile[? "crystal"] - stockQuota[? "crystal"]);
}
#endregion

#region Radioactives
if(is_undefined(ds_priority_find_priority(owner.radioRanking, id)))
{
	ds_priority_add(owner.radioRanking, id, stockpile[? "radioactives"] - stockQuota[? "radioactives"]);
}
else
{
	ds_priority_change_priority(owner.radioRanking, id, stockpile[? "radioactives"] - stockQuota[? "radioactives"]);
}
#endregion

#region Food
if(is_undefined(ds_priority_find_priority(owner.foodRanking, id)))
{
	ds_priority_add(owner.foodRanking, id, stockpile[? "food"] - stockQuota[? "food"]);
}
else
{
	ds_priority_change_priority(owner.foodRanking, id, stockpile[? "food"] - stockQuota[? "food"]);
}
#endregion

#region Alloys
if(is_undefined(ds_priority_find_priority(owner.alloysRanking, id)))
{
	ds_priority_add(owner.alloysRanking, id, stockpile[? "alloys"] - stockQuota[? "alloys"]);
}
else
{
	ds_priority_change_priority(owner.alloysRanking, id, stockpile[? "alloys"] - stockQuota[? "alloys"]);
}
#endregion

#region Nanotech
if(is_undefined(ds_priority_find_priority(owner.nanoRanking, id)))
{
	ds_priority_add(owner.nanoRanking, id, stockpile[? "nanotech"] - stockQuota[? "nanotech"]);
}
else
{
	ds_priority_change_priority(owner.nanoRanking, id, stockpile[? "nanotech"] - stockQuota[? "nanotech"]);
}
#endregion

#region Consumer Goods
if(is_undefined(ds_priority_find_priority(owner.consumerRanking, id)))
{
	ds_priority_add(owner.consumerRanking, id, stockpile[? "consumerGoods"] - stockQuota[? "consumerGoods"]);
}
else
{
	ds_priority_change_priority(owner.consumerRanking, id, stockpile[? "consumerGoods"] - stockQuota[? "consumerGoods"]);
}
#endregion

#region Advanced Components
if(is_undefined(ds_priority_find_priority(owner.advancedRanking, id)))
{
	ds_priority_add(owner.advancedRanking, id, stockpile[? "advancedComponents"] - stockQuota[? "advancedComponents"]);
}
else
{
	ds_priority_change_priority(owner.advancedRanking, id, stockpile[? "advancedComponents"] - stockQuota[? "advancedComponents"]);
}
#endregion

#endregion

#endregion