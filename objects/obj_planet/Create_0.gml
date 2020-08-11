global.genPlanetCount++;

#region Parent
system = pointer_null;
sysAge = 0;

starType = pointer_null;
starLumi = pointer_null;
starWind = pointer_null;
starSize = pointer_null;
starMass = pointer_null;
starPlanetCount = pointer_null;

#endregion

#region Planetary Traits
name = "blarg";
type = "Error";

pos = 0;
distance = 0;

axialTilt = 0;
dayLength = 0;

size = 0;
density = 0;
terrainRoughness = 0;

tectonicActivity = 0;
volcanicActivity = 0;
magneticField = 0;

temperature = 0;
atmoDensity = 0; 
atmoBreathability = 0;

oceanCoverage = 0;
useableWater = 0;
weather = 0;

habitability = 0;
biosphere = 0;
natives = 0;

#endregion

#region Ownership
owner = pointer_null;
ownerName = "Unsettled";
ownerColor = pointer_null;
occupier = pointer_null;
capitol = false;

#endregion

#region Demographics
population = 0; 
baseMaxPop = 0;
maxPopulation = 0;
popRatio = 0;
growthRate = 0.15;
happiness = 0.5; 
crime = 0;

colonists = 0;

#endregion

#region Government
criticismLevel = 0;
leaderApproval = 0;
legiApproval = 0;
corruption = 0;

#endregion

#region Infrastructure
infraLevel = 1;

urbanLevel = 1;

powerLevel = 1;

miningLevel = 1;

agriLevel = 1;

//Industry
alloyLevel = 0;

cgLevel = 0;

nanoLevel = 0;

acLevel = 0;

#endregion

#region Economy

#region Productivity
baseProductivity = 0.5;

productivity = ds_map_create();

productivity[? "energy"] = 0.5;
productivity[? "metal"] = 0.5;
productivity[? "rareElements"] = 0.5;
productivity[? "gas"] = 0.5;
productivity[? "crystal"] = 0.5;
productivity[? "radioactives"] = 0.5;
productivity[? "food"] = 0.5;

productivity[? "alloys"] = 0.5;
productivity[? "consumerGoods"] = 0.5;
productivity[? "nanotech"] = 0.5;
productivity[? "advancedComponents"] = 0.5;


#endregion

#region Resources
resources = ds_map_create();

resources[? "energy"] = 0;
resources[? "metal"] = 0;
resources[? "rareElements"] = 0;
resources[? "gas"] = 0;
resources[? "crystal"] = 0;
resources[? "radioactives"] = 0;
resources[? "food"] = 0;

resources[? "alloys"] = 0;
resources[? "consumerGoods"] = 0;
resources[? "nanotech"] = 0;
resources[? "advancedComponents"] = 0;

#endregion

#region Upkeep
upkeep = ds_map_create();

popFoodUpkeep = 0;
popCGUpkeep = 0;

popFoodUpkeepPenalty = 1;
popCGUpkeepPenalty = 1;

upkeep[? "energy"] = 0;
upkeep[? "metal"] = 0;
upkeep[? "rareElements"] = 0;
upkeep[? "gas"] = 0;
upkeep[? "crystal"] = 0;
upkeep[? "radioactives"] = 0;
upkeep[? "food"] = 0;
	
upkeep[? "alloys"] = 0;
upkeep[? "consumerGoods"] = 0;
upkeep[? "nanotech"] = 0;
upkeep[? "advancedComponents"] = 0;
	
#endregion

#endregion

#region Other
daysSinceSettlement = 0;

//Generation Data
detailDone = false;

#endregion