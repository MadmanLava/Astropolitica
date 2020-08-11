/// @desc Forcibly Habitable Generation

detailDone = true;
global.planetsDone++;
capitol = true;
type = "Rocky";

axialTilt = 0;
dayLength = 5;

size = irandom_range(5, 10);
density = irandom_range(5, 10);
terrainRoughness = irandom_range(1, 4);

tectonicActivity = irandom_range(3, 7);
volcanicActivity = irandom_range(0, 1);
magneticField = 10;

temperature = irandom_range(4, 6);
atmoDensity = irandom_range(4, 6);
atmoBreathability = 10;

oceanCoverage = irandom_range(4, 6);
useableWater = 0;
weather = irandom_range(4, 6);

//biosphere = 0;
//natives = 0;

//Resources
resources[? "energy"] = 10;
resources[? "metal"] = 10;
resources[? "rareElements"] = 10;
resources[? "gas"] = 10;
resources[? "crystal"] = 10;
resources[? "radioactives"] = 10;
resources[? "food"] = 15;

//Habitability Score
var baseHab = 10 + (magneticField/2) + (atmoBreathability*2) + (useableWater*2) + (tectonicActivity-2)
- (starWind/2) - (volcanicActivity) - (terrainRoughness-1) + abs(atmoDensity-4)*2
+ abs(temperature-4)*2 + abs(dayLength-3)*2 - abs(weather-3)*2;
			
habitability = clamp(ceil(baseHab/5) + global.planetHabitabilityBonus, 0, 10);
growthRate = 0.1;
			
baseMaxPop = ((size * 100) * habitability) + size
maxPopulation = baseMaxPop;

infraLevel = 3;
urbanLevel = 3;
powerLevel = 2;
miningLevel = 2;
agriLevel = 10;

alloyLevel = 2;
cgLevel = floor(population/50) + 1;
if(cgLevel > 10)
{
	cgLevel = 10;
}
nanoLevel = 1;
acLevel = 1;

population = baseMaxPop/2;
