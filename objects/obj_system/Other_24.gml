/// @desc Generation Step

if(global.genStage == gen.placeStars)
{
	#region Branching Generation

	if(!genDone and genNeighbors < cap and failedTries < maxFailedTries and global.genStarCount < starCount)
	{
		repeat(starSpeed)
		{
			var childx = x + irandom_range(-(laneRadius + densityFactor), laneRadius + densityFactor);
			var childy = y + irandom_range(-(laneRadius + densityFactor), laneRadius + densityFactor);
			if(/*point_in_circle(childx, childy, 25000, 25000, galaxyRadius) and*/ point_in_circle(childx, childy, x, y, laneRadius-10 + densityFactor))
			{
				if(!point_in_circle(childx, childy, x, y, pruneRadius + densityFactor) and place_free(childx, childy) and !collision_circle(childx, childy, pruneRadius + densityFactor, obj_system, true, true))
				{
					var child = instance_create_layer(childx, childy, genLayer, obj_system);
					if(global.genMode == 1)
					{
						ds_list_add(neighbors, child.id);
					}
					genNeighbors++;
				}
				else
				{
					failedTries++;
				}
			}
			else
			{
				failedTries++;
			}
		}
	}

	#endregion
}
else if(global.genStage == gen.calcLanes)
{
	
	#region Hyperlane Generation
	
	if(!hyperlanesFound)
	{
		if(global.genMode != 1)
		{
			collision_circle_list(x, y, laneRadius + densityFactor, obj_system, true, true, neighbors, true);
		}
	
		//Dont count yourself
		if(ds_list_find_index(neighbors, id))
		{
			ds_list_delete(neighbors, ds_list_find_index(neighbors, id));
		}

		hyperlaneCount = ds_list_size(neighbors);

		//Save coordinates to hyperlane drawer
		var i = 0;
		var manager = obj_drawmanager;
		repeat(hyperlaneCount)
		{
			var neighbor = ds_list_find_value(neighbors, i);
			var managerPos = ds_grid_height(manager.lanePairs);
		
			//Expand the grid
			ds_grid_resize(manager.lanePairs, 2, managerPos + 1)
		
			//Add coordinates
			ds_grid_add(manager.lanePairs, 0, managerPos, id);
			ds_grid_add(manager.lanePairs, 1, managerPos, neighbor);
		
			//show_debug_message("Lane added!");
		
			i++;
		}

		global.genHyperlaneCount += (ds_list_size(neighbors));
		global.lanesDone ++;
		hyperlanesFound = true;
	
	}

	#endregion
}
else if(global.genStage == gen.detailStars)
{
	if(!detailDone)
	{
		#region Sun Generation
		if(!sunDone)
		{
			name = scr_namegenerator("system", "", "", false, false);
			name = name + " System";
		
			//Check for being the center
			if(x = 25000 and y = 25000)
			{
				type = "Supermassive Black Hole";
				age = 10000
				starColor = c_black;
				size = 10;
				mass = 50;
				wind = 0;
				luminosity = 10;
				asteroidDensity = 0;
			
				metal = irandom_range(1, 5);
				rareElements = irandom_range(1, 5);
				radioactives = irandom_range(1, 10);
			
				planetCount = 0;
				global.blackholeCount++;
			}
			else
			{
				///Is it a stellar remnant?
				if(scr_chance(global.remnantChance) == false)
				{
					//Determine Class
					var holder = scr_suntype();
					type = holder;
			
					#region Generate Detail
					if(type == "Class E")
					{
						starColor = c_white;
						age = irandom_range(10, 10000);
						size = 0;
						mass = 5;
						wind = 0;
						luminosity = 10;
						asteroidDensity = irandom_range(1, 5);
						planetCount = irandom_range(1, 10);
				
						global.eStarCount ++;
						global.rareStarCount ++;
						show_debug_message("A Class E star formed!");
					}
					else if(type == "Class O")
					{
						starColor = make_color_rgb(194, 246, 255);
						age = irandom_range(5, 12);
						size = irandom_range(8, 10);
						mass = irandom_range(9, 10);
						wind = irandom_range(6, 8);
						luminosity = irandom_range(9, 10);
						asteroidDensity = irandom_range(1, 3);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(0, 2);
						global.classOCount ++;
					}
					else if(type == "Class B")
					{
						starColor = make_color_rgb(163, 231, 255);
						age = irandom_range(10, 150);
						size = irandom_range(6, 8);
						mass = irandom_range(6, 7);
						wind = irandom_range(5, 7);
						luminosity = irandom_range(7, 9);
						asteroidDensity = irandom_range(1, 5);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(0, 3);
						global.classBCount ++;
					}
					else if(type == "Class A")
					{
						starColor = make_color_rgb(237, 250, 255);
						age = irandom_range(15, 1750);
						size = irandom_range(5, 6);
						mass = irandom_range(5, 6);
						wind = irandom_range(3, 5);
						luminosity = irandom_range(6, 7);
						asteroidDensity = irandom_range(1, 5);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(1, 5);
						global.classACount ++;
					}
					else if(type == "Class F")
					{
						starColor = make_color_rgb(255, 253, 143);
						age = irandom_range(10, 9000);
						size = irandom_range(5, 6);
						mass = irandom_range(4, 6);
						wind = irandom_range(4, 6);
						luminosity = irandom_range(6, 8);
						asteroidDensity = irandom_range(1, 7);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(1, 7);
						global.classFCount ++;
					}
					else if(type == "Class G")
					{
						starColor = c_yellow;
						age = irandom_range(10, 10000);
						size = irandom_range(4, 6);
						mass = irandom_range(4, 5);
						wind = irandom_range(4, 5);
						luminosity = irandom_range(4, 5);
						asteroidDensity = irandom_range(1, 8);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(1, 9);
						global.classGCount ++;
					}
					else if(type == "Class K")
					{
						age = irandom_range(20, 10000);
						starColor = c_orange;
						size = irandom_range(3, 4);
						mass = irandom_range(3, 4);
						wind = irandom_range(1, 4);
						luminosity = irandom_range(3, 5);
						asteroidDensity = irandom_range(1, 7);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(1, 8);
						global.classKCount ++;
					}
					else if(type == "Class M")
					{
						starColor = c_red;
						age = irandom_range(30, 10000);
						size = irandom_range(2, 3);
						mass = irandom_range(2, 3);
						wind = irandom_range(1, 6);
						luminosity = irandom_range(2, 5);
						asteroidDensity = irandom_range(1, 5);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(1, 10);
						global.classMCount ++;
					}
					else if(type == "Class W")
					{
						starColor = c_white;
						age = irandom_range(0.1, 0.5);
						size = irandom_range(3, 7);
						mass = irandom_range(3, 7);
						wind = 10;
						luminosity = irandom_range(9, 10);
						asteroidDensity = irandom_range(0, 2);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(0, 1);
						global.classWCount ++;
					}
					else if(type == "Class D")
					{
						starColor = c_white;
						age = irandom_range(50, 9000);
						size = 1;
						mass = irandom_range(4, 5);
						wind = irandom_range(1, 4);
						luminosity = irandom_range(3, 4);
						asteroidDensity = irandom_range(1, 3);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = 0;
						global.classDCount ++;
					}
					else
					{
						type = "Class E";
						age = irandom_range(10, 10000);
						starColor = c_white;
						size = 0;
						mass = 5;
						wind = 0;
						luminosity = 10;
						asteroidDensity = irandom_range(1, 5);
					
						metal = irandom_range(1, 5);
						rareElements = irandom_range(1, 5);
						radioactives = irandom_range(1, 5);
					
						planetCount = irandom_range(1, 10);
				
						global.rareStarCount ++;
						global.eStarCount ++;
						show_debug_message("A star failed to generate properly!")
					}
			
					#endregion
				}

				#region Special Stars
				else
				{
					type = choose("Neutron Star", "Black Hole")
					if(type == "Neutron Star")
					{
						age = irandom_range(50, 9500);
						starColor = c_aqua;
						size = 1;
						mass = irandom_range(7, 8);
						wind = 8;
						luminosity = irandom_range(5, 8);
						asteroidDensity = irandom_range(0, 1);
					
						metal = irandom_range(1, 3);
						rareElements = irandom_range(1, 3);
						radioactives = irandom_range(1, 8);
					
						planetCount = 0;
						global.neutronCount++;
					}
					else
					{
						age = irandom_range(50, 95000);
						starColor = c_black;
						size = 0;
						mass = irandom_range(7, 10);
						wind = 0;
						luminosity = 0;
						asteroidDensity = irandom_range(0, 1);
					
						metal = irandom_range(1, 3);
						rareElements = irandom_range(1, 3);
						radioactives = irandom_range(1, 10);
					
						planetCount = 0;
						global.blackholeCount++;
					}
					global.rareStarCount ++;
				}
				#endregion
			
				planetCount += global.forcedExtraPlanets;
			
				global.avgPlanetCount += planetCount;
				sunDone = true;
			}
		}
		
#endregion
	
		#region Planet Generation
	
		if(planetCount != 0)
		{
			var i = 1;
			repeat(planetCount)
			{
				var planet = instance_create_layer(x, y, genLayer, obj_planet);
				ds_list_add(planetList, planet);
			
				planet.system = id;
				planet.sysAge = age;
				planet.starType = type;
				planet.starLumi = luminosity;
				planet.starWind = wind;
				planet.starSize = size;
				planet.starMass = mass;
				planet.starPlanetCount = planetCount;
				planet.pos = i;
				planet.distance = irandom_range(1, 10);
				i ++
				
				//with(planet)
				//{
				//	event_user(15);
				//}
			}
		}
	
		#endregion
	
		detailDone = true;
		global.starsDone ++;
	}
}