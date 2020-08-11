/// @desc Generation

#region Generation Code(natural)
if(detailDone == false)
{	
	var posRatio = (pos/starPlanetCount);
	var n = scr_namegenerator("basic", "", "", false, false);
	name = n;
	
	#region Type
	if(starType == "Class W" or pos == 1)
	{
		type = "Rocky";
	}
	else
	{
		if(random_range(0, 1) > (posRatio * random_range(0, 1.5)))
		{
			type = "Rocky";
		}
		else
		{
			type = "Gas Giant";
		}
	}
	#endregion
	
	#region Rocky Planet Detail
	if(type == "Rocky")
	{
		//Remnant check
		if(starType != "Black Hole" and starType != "Neutron Star" and starType != "White Dwarf")
		{
			#region Natural Traits
			
			#region Size, Density and Day Length
			
				#region Size(Pos/Distance and Sun Size)
				var distFactor = floor(abs((pos * distance) - 25)/20);
				var sunFactor = floor(abs(starSize - 2));
				
				size = clamp(irandom_range(1, 10) - distFactor - sunFactor, 1, 10);
					
				#endregion
			
				#region Density(Solar Mass)
				var sunFactor = floor(abs(starMass-2));
				
				density = clamp(irandom_range(1, 10) - sunFactor, 1, 10);
				
				#endregion
			
				#region Day Length(Size and Pos/Distance)
				if(distFactor > 5)
				{
					dayLength = clamp(irandom_range(1, 10) + floor(size/10), 1, 10);
					
					//Tidal lock chance
					if(distFactor < 25 and irandom_range(0, 50) > distFactor)
					{
						dayLength = -1;
					}
				}
				else
				{
					dayLength = -1; //tidally locked
				}
				
				#endregion
			
			#endregion
			
			#region Tectonic Activity, magnetic field and volcanic activity
			//Check if the planet should be a molten hellhole
			if(sysAge > 100)
			{
				//tectonic activity(size, density, age of system)
				tectonicActivity = clamp((irandom_range(0, 10) * (1 + (size/10)) * (1 + (10/density))), 0, 10)
				
				//Magnetic field(tect. activity, density)
				magneticField = clamp(tectonicActivity * (1 + (10/density)), 1, 10)
			}
			else //the planet is literally just a ball of lava
			{
				tectonicActivity = 10;
				volcanicActivity = 20;
				magneticField = clamp(irandom_range(2, 8) * (1 + (density/10)), 0, 10)
			}
			
			#endregion
			
			#region Temperature, Atmospheric Density and Atmospheric Breathability
			//Temperature
			var lumiFactor = (starLumi - 5)/10 // target sunlike luminosity
			var volcFactor = volcanicActivity/10 // target low volcanic activity
			var tectFactor = tectonicActivity/10 // more tectonics = more heat
			
			///man not hot
			temperature = clamp(ceil(irandom_range(4, 6) * (1 + lumiFactor + volcFactor + tectFactor)), 1, 10)
			
			//Atmo Density
			var volcFactor = volcanicActivity/10 //fumes lmao
			var windFactor = 10/starWind;
			
			atmoDensity = clamp(ceil(irandom_range(1, 10) * (1 + volcFactor + windFactor)), 1, magneticField);
			
			//Breathability
			atmoBreathability = clamp(irandom_range(1, 10) - floor(volcanicActivity/2), 1, 10)
			
			#endregion
			
			#region Oceanic Coverage, Weather, Usable Water
			var tidalFactor = 0;
			if(dayLength == -1)
			{
				tidalFactor = 9;
			}
			
			//ocean(big v a t e r)
			oceanCoverage = clamp(irandom_range(0, 10) - tidalFactor, 0, atmoDensity);
			
			//Weather
			var tempFactor = 1 + ((temperature - 5)/10)
			
			weather = clamp(ceil((irandom_range(1, 10) + ceil(oceanCoverage/2)) * tempFactor), 1, atmoDensity);
			
			//usable water(smol v a t e r)
			var waterFactor = clamp(atmoDensity - round(temperature/2) + irandom_range(0, 5), 1, 10);
			useableWater = clamp(irandom_range(1, 10), 1, waterFactor);
			
			#endregion
			
			//Terrain roughness
			terrainRoughness = clamp(irandom_range(1, 5) + ceil(tectonicActivity/2) - ceil(oceanCoverage/4) - ceil(weather/4), 1, 10);
			
			#region H A B I T A B I L I T Y (and population)
			var baseHab = (starWind - magneticField) + (atmoBreathability) + (useableWater) + (tectonicActivity-2) - abs(oceanCoverage-5)*2
			- (volcanicActivity*3) - (terrainRoughness-2) + abs(atmoDensity-4)*3
			+ abs(temperature-4)*3 + abs(dayLength-3)*2 - abs(weather-3)*2;
			
			if(dayLength != -1 and atmoBreathability > 1 and useableWater > 1)
			{
				habitability = clamp(ceil(baseHab/5) + global.planetHabitabilityBonus, 0, 10);
			}
			else
			{
				habitability = 1;
			}
			
			growthRate = habitability/10;
			
			baseMaxPop = ((size * 100) * habitability) + size
			maxPopulation = baseMaxPop;
			
			#endregion
			
			#endregion
			
			#region Resources
			resources[? "energy"] = ceil(irandom_range(1, 10) * (1 + (weather + starLumi)/50));
			resources[? "metal"] = ceil(irandom_range(1, 10) * (1 + (density + size)/50));
			resources[? "rareElements"] = ceil(irandom_range(1, 10) * (1 + (density + size)/50));
			resources[? "gas"] = irandom_range(1, 10);
			resources[? "crystal"] = irandom_range(1, 10);
			resources[? "radioactives"] = ceil(irandom_range(1, 10) * (1 + (density + size)/50));
			resources[? "food"] = clamp(irandom_range(1, 10), 0, habitability);
			
			#endregion
		}
	}
	#endregion
	
	#region Gas Giant Detail
	else
	{
		size = irandom_range(1, 10);
		density = irandom_range(1, 10);
		dayLength = irandom_range(1, 10);
		magneticField = clamp(round(irandom_range(1, 10) + (size/4) + (density/4)), 1, 10);
		temperature = irandom_range(1, 10);
		weather = irandom_range(1, 5) + floor(temperature/2);
		
		resources[? "gas"] = irandom_range(5, 20);
	}
	#endregion
	
	detailDone = true;
	global.planetsDone++;
}
#endregion