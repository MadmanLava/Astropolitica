//Adds the system to both the global list of systems and the global list of empty systems.
ds_list_add(global.systemList, id);
ds_list_add(global.emptySystemList, id);

//Calculates the system's sequential ID for use in the drawing data surface.
seq_id = instance_number(obj_system)-1;
//Calculates the position the system should draw to on the data surface.
seq_x = seq_id div 100;
seq_y = seq_id mod 100;

//Increments the global count of generated stars.
global.genStarCount ++;

#region Sun Traits - Traits pertaining to the star within the system
type = ""; //The star type, based on the letter classification system
size = 0;
mass = 0;
luminosity = 0;
wind = 0;
supernovaRisk = 0; //Risk of the star going supernova.

#endregion

#region Astrography
name = ""; //Name of the system
age = 0; //Age in millions of years
planetCount = 0;
planetList = ds_list_create(); //List of child planets
habitablePlanetCount = 0;
habitablePlanetList = ds_list_create(); //List of habitable child planets
asteroidBelt = false; //Whether or not a natural asteroid belt is present
asteroidDensity = 0; //General density of asteroids and space debris in the system

rockyCount = 0; //# of rocky planets in the system

//Asteroid resources - these determine how effective spaceborne mining is
metal = 0;
rareElements = 0;
radioactives = 0;

hyperlaneCount = 0; //# of connections to other star systems
neighbors = ds_list_create(); //List of connected star systems
emptyNeighbors = ds_list_create(); //List of connected uninhabited star systems
border = false; //Whether or not this system is on the border of its parent country

#endregion

#region Ownership
owner = pointer_null; //ID of the owning country
ownerName = "Unsettled"; //Name of the owning country
ownerColor = c_white; //Color of the owning country
claim = pointer_null; //ID of the country claiming the system(if any)
occupier = pointer_null; //ID of the country militarily occupying the system(if any)
capitol = false; //Whether or not this system is the capitol of its owning country

daysSinceSettlement = 0; //# of days since the system was colonized

#endregion

#region Demographics
population = 0;
maxPopulation = 0; //Current theoretical maximum population
colonists = 0; //# of people in the population willing to settle a new system
growthRate = 0; //Average growth rate
livingStandards = 0; //Average living standards
happiness = 0; //Average happiness
crime = 0; //Average crime

#endregion

#region Government
criticismLevel = 0; //An average of how critical the system's population is of the gov'nt as a whole
leaderApproval = 0; //Average approval ratings of the current leadership
legiApproval = 0; //Average approval ratings of the current legislative body
corruption = 0; //Average government corruption in the system

#endregion

#region Infrastructure

infraDebug = ""; //Debug value for reading the AI's thought process on what it wants to build
infraLastAction = ""; //The last action the infrastructure code took
infraSavingFor = ""; //What, if anything, the system is saving up to build

#region Shipyard - Spaceborne structure that builds ships
shipyardLevel = 0;
shipyardTask = ds_map_create(); //data on the current task of the shipyard
shipyardStatus = "Idle"; //Current status of the shipyard
shipyardTimeElapsed = 0; //How long the shipyard has been working on its task
shipyardPaidFor = false; //Whether or not the shipyard has secured the resources it needs for its current task

//Monthly upkeep costs
shipyardEnergyUpkeep = 0;
shipyardMetalUpkeep = 0;
shipyardREUpkeep = 0;
shipyardGasUpkeep = 0;
shipyardFoodUpkeep = 0;
#endregion

#region Dyson Array - a swarm of satellites around the sun that collect its energy
dysonLevel = 0;

//Resources produced each month
dysonEnergy = 0;
dysonGas = 0;

//Resources consumed each month
dysonCrystalUpkeep = 0;
dysonFoodUpkeep = 0;

#endregion

#region Asteroid Mining - various outposts that mine local asteroids
miningLevel = 0;

//Resources produced each month
miningMetal = 0;
miningRE = 0;
miningRadio = 0;

//Resources consumed each month
miningEnergyUpkeep = 0;
miningGasUpkeep = 0;
miningFoodUpkeep = 0;

#endregion

#region Exotic Harvesting - Collects exotic resources
exoticLevel = 0;

exoticNeutron = 0;
exoticError = 0;

#endregion

#endregion

#region Economy
wealth = 0;

	#region Resources
	
	taxesPaid = 0;
	
	#region tax
	tax = ds_map_create();
	
	tax[? "energy"] = 0;
	tax[? "metal"] = 0;
	tax[? "rareElements"] = 0;
	tax[? "gas"] = 0;
	tax[? "crystal"] = 0;
	tax[? "radioactives"] = 0;
	tax[? "food"] = 0;

	tax[? "alloys"] = 0;
	tax[? "consumerGoods"] = 0;
	tax[? "nanotech"] = 0;
	tax[? "advancedComponents"] = 0;
	
	tax[? "neutronium"] = 0;
	tax[? "erronogen"] = 0;
	
	#endregion
	
	quotaDeficiency = false;

	#region Resource Values
	value = ds_map_create();
	
	value[? "energy"] = 1;
	value[? "metal"] = 1;
	value[? "rareElements"] = 2;
	value[? "gas"] = 2;
	value[? "crystal"] = 1.5;
	value[? "radioactives"] = 3;
	value[? "food"] = 1;
	value[? "neutronium"] = 10;
	value[? "erronogen"] = 100;
	
	value[? "alloys"] = 3;
	value[? "consumerGoods"] = 2;
	value[? "nanotech"] = 5;
	value[? "advancedComponents"] = 4;

	#endregion

	#region Desired Resources
	desired = ds_map_create();
	desiresResources = false;

	desired[? "energy"] = 0;
	desired[? "metal"] = 0;
	desired[? "rareElements"] = 0;
	desired[? "gas"] = 0;
	desired[? "crystal"] = 0;
	desired[? "radioactives"] = 0;
	desired[? "food"] = 0;

	desired[? "alloys"] = 0;
	desired[? "consumerGoods"] = 0;
	desired[? "nanotech"] = 0;
	desired[? "advancedComponents"] = 0;
	
	desired[? "neutronium"] = 0;
	desired[? "erronogen"] = 0;
	
	#endregion

	#region Income
	income = ds_map_create();

	income[? "energy"] = 0;
	income[? "metal"] = 0;
	income[? "rareElements"] = 0;
	income[? "gas"] = 0;
	income[? "crystal"] = 0;
	income[? "radioactives"] = 0;
	income[? "food"] = 0;

	income[? "alloys"] = 0;
	income[? "consumerGoods"] = 0;
	income[? "nanotech"] = 0;
	income[? "advancedComponents"] = 0;
	
	income[? "neutronium"] = 0;
	income[? "erronogen"] = 0;
	
	#endregion
	
	#region Income Quota
	incomeQuota = ds_map_create();

	incomeQuota[? "energy"] = 0;
	incomeQuota[? "metal"] = 0;
	incomeQuota[? "rareElements"] = 0;
	incomeQuota[? "gas"] = 0;
	incomeQuota[? "crystal"] = 0;
	incomeQuota[? "radioactives"] = 0;
	incomeQuota[? "food"] = 0;

	incomeQuota[? "alloys"] = 0;
	incomeQuota[? "consumerGoods"] = 0;
	incomeQuota[? "nanotech"] = 0;
	incomeQuota[? "advancedComponents"] = 0;
	
	incomeQuota[? "neutronium"] = 0;
	incomeQuota[? "erronogen"] = 0;
	
	#endregion

	#region Stockpile
	stockpile = ds_map_create();

	stockpile[? "energy"] = 0;
	stockpile[? "metal"] = 0;
	stockpile[? "rareElements"] = 0;
	stockpile[? "gas"] = 0;
	stockpile[? "crystal"] = 0;
	stockpile[? "radioactives"] = 0;
	stockpile[? "food"] = 0;

	stockpile[? "alloys"] = 0;
	stockpile[? "consumerGoods"] = 0;
	stockpile[? "nanotech"] = 0;
	stockpile[? "advancedComponents"] = 0;
	
	stockpile[? "neutronium"] = 0;
	stockpile[? "erronogen"] = 0;

	#endregion

	#region Stockpile Quota
	stockQuota = ds_map_create();

	stockQuota[? "energy"] = 0;
	stockQuota[? "metal"] = 0;
	stockQuota[? "rareElements"] = 0;
	stockQuota[? "gas"] = 0;
	stockQuota[? "crystal"] = 0;
	stockQuota[? "radioactives"] = 0;
	stockQuota[? "food"] = 0;

	stockQuota[? "alloys"] = 0;
	stockQuota[? "consumerGoods"] = 0;
	stockQuota[? "nanotech"] = 0;
	stockQuota[? "advancedComponents"] = 0;
	
	stockQuota[? "neutronium"] = 0;
	stockQuota[? "erronogen"] = 0;
	
	#endregion

	#region Upkeep
	upkeep = ds_map_create();
	
	upkeep[? "energy"] = 0;
	upkeep[? "metal"] = 0;
	upkeep[? "rareElements"] = 0;
	upkeep[? "gas"] = 0;
	upkeep[? "crystal"] = 0;
	upkeep[? "radioactives"] = 0;
	upkeep[? "food"] = 0;
	upkeep[? "neutronium"] = 0;
	upkeep[? "erronogen"] = 0;
	
	upkeep[? "alloys"] = 0;
	upkeep[? "consumerGoods"] = 0;
	upkeep[? "nanotech"] = 0;
	upkeep[? "advancedComponents"] = 0;
	
	#endregion
	
	#region Trade
	trade = ds_map_create();
	
	trade[? "energy"] = 0;
	trade[? "metal"] = 0;
	trade[? "rareElements"] = 0;
	trade[? "gas"] = 0;
	trade[? "crystal"] = 0;
	trade[? "radioactives"] = 0;
	trade[? "food"] = 0;
	trade[? "neutronium"] = 0;
	trade[? "erronogen"] = 0;
	
	trade[? "alloys"] = 0;
	trade[? "consumerGoods"] = 0;
	trade[? "nanotech"] = 0;
	trade[? "advancedComponents"] = 0;
	
	#endregion

	#endregion

#endregion

#region Other
//Camera
cam = view_get_camera(0);

#region Globals
starCount = global.starCount;
laneRadius = global.laneRadius;
starSpeed = global.starGenSpeed;
galaxyRadius = global.galaxyRadius;
pruneRadius = global.pruneRadius;
cap = global.starGenCap;
maxFailedTries = global.maxFailedTries;

if(instance_number(obj_densitynode) == 0)
{
	densityFactor = (global.densityFactor) * (point_distance(x, y, 25000, 25000) / galaxyRadius)
}
else
{
	var nearest = instance_nearest(x, y, obj_densitynode);
	
	densityFactor = (global.densityFactor) * (point_distance(x, y, nearest.x, nearest.y) / galaxyRadius)
}

#endregion

#region Generation Flags
hyperlanesFound = false;
sunDone = false;
genDone = false;
detailDone = false;
genNeighbors = 0;
failedTries = 0;

genLayer = layer_get_id("Systems");

#endregion

#region Pathfinding
pathParent = pointer_null;

fCost = 0;
gCost = 0;
hCost = 0;

#endregion

//Other
draw = false;
#endregion