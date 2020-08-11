if(global.genStage != gen.completed)
{
	switch global.genStage
	{
		#region Pre-stargen Actions
		case gen.preStars:
		{
			//set the seed
			random_set_seed(global.seed);
			invigCount = 0;
			
			//Place first star
			instance_create_layer(25000, 25000, genLayer, obj_system);
		
			//Center density node
			if(global.centerRadNode)
			{
				instance_create_layer(25000, 25000, genLayer, obj_densitynode);
			}
			
			//Random density nodes
			repeat(global.densityNodes)
			{
				instance_create_layer(irandom_range(-(global.densityRadius + 25000), global.densityRadius + 25000), irandom_range(-(global.densityRadius + 25000), global.densityRadius + 25000), genLayer, obj_densitynode);
			}
			
			//Reload the name list
			scr_loadNames();
			
			//Move to the next stage
			global.genStage = gen.placeStars;
			
			break;
		}
		#endregion
		
		#region Run star generation
		case gen.placeStars:
		{
			//Move to the next stage
			if(global.genStarCount >= global.starCount)
			{
				global.genStage = gen.calcLanes;
			}
			else
			{
				//Run generation event
				with(obj_system)
				{
					if(current_time - global.startTime < global.starGenSpeed)
					{
						event_user(14);
					}
				}
			}
			
			break;
		}
		#endregion
		
		#region Calculate Hyperlanes
		case gen.calcLanes:
		{
			if(global.lanesDone == global.genStarCount)
			{
				global.genStage = gen.pruneLanes
			}
			else
			{
				with(obj_system)
				{
					if(current_time - global.startTime < 30)
					{
						event_user(14);
					}
				}
			}
			
			break;
		}
		#endregion
		
		#region Prune Hyperlanes
		case gen.pruneLanes:
		{
			if(global.lanesPruned)
			{
				global.genStage = gen.detailStars;	
			}
			
			break;
		}
		#endregion
		
		#region Star Detail
		case gen.detailStars:
		{
			if(global.starsDone == global.genStarCount)
			{
				global.genStage = gen.detailPlanets;
			}
			else
			{
				with(obj_system)
				{
					if(current_time - global.startTime < 30)
					{
						event_user(14);
					}
				}
			}
			
			break;
		}
		#endregion
		
		#region Planet Detail
		case gen.detailPlanets:
		{
			if(global.planetsDone == global.genPlanetCount)
			{
				with(obj_system)
				{
					//Settle child planets
					event_user(2);
				}
				global.avgPlanetCount = global.avgPlanetCount/global.genStarCount;
				global.genStage = gen.placeFactions;
			}
			else
			{
				with(obj_planet)
				{
					if(current_time - global.startTime < 30)
					{
						event_user(15);
					}
				}
			}
			
			break;
		}
		#endregion
		
		#region Place Factions
		case gen.placeFactions:
		{
			if(global.genFactionCount < global.factionCount)
			{
				instance_create_layer(-1000, -1000, genLayer, obj_faction);
				show_debug_message("e")
				global.genFactionCount ++;
			}
			else if(global.factionsPlaced == global.genFactionCount)
			{
				global.genStage = gen.finalize;
			}
			
			break;
		}
		#endregion
		
		#region Finalize
		case gen.finalize:
		{
			//Name the galaxy
			global.galaxyName = scr_namegenerator("basic", "", "", false, false);
			
			//System Setup
			with(obj_system)
			{
				//Settle child planets
				event_user(2);
				
				//Update color
				event_user(13);
				
				//Update border status
				event_user(15);
			}
			#region Initial update tick
			//Update Planets
			with(obj_planet)
			{
				event_user(3);
			}
			//Update Systems
			with(obj_system)
			{
				event_user(3);
			}
			//Update Factions
			with(obj_faction)
			{
				event_user(3);
			}
			#endregion
			
			//Build the vertex buffer for drawing stars
			with(obj_systemManager)
			{
				event_user(0);
			}
			
			ds_list_copy(obj_systemManager.list, global.systemList);
			obj_systemManager.starCount = global.genStarCount;
			obj_systemManager.genDone = true;
			
			global.drawStars = true;
			global.drawLanes = true;
			global.drawShips = true;
			global.drawCountryNames = true;
			global.drawPolarGrid = true;
			global.generationTime = current_time - global.generationTime;
			global.avgLaneCount = global.genHyperlaneCount/global.starCount;
			
			//Build faction color tags
			with(obj_faction)
			{
				scribble_add_color(string(id), color1, true);
			}
			
			with(obj_newuimanager)
			{
				showUI = true;
				event_user(1);
			}
			
			scr_addToQueue("Welcome to the Galaxy!", c_white)
			
			global.genStage = gen.completed;
			break;
		}
		#endregion
	}
}