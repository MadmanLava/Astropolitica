// dont bother if time shouldnt be passing at all
if(global.paused or room != simroom or global.genStage != gen.completed)
{
	exit;
}

#region Variable declarations

#endregion

#region Step - Iterate the sub-day ticks per unpaused frame
if(ds_queue_empty(eventQueue)) // If there is no backlog of events to fire
{
	global.stuck = false;
	
	if(global.step < global.gameSpeed) // If the number of sub-day ticks has not maximized
	{
		global.step ++; // Iterate the step tick
	}
	
	#region If the sub-day tick limit has been reached(All normal date/event functionality)...
	else
	{
		global.step = 0;
		
		global.daysPast ++; // Iterate the number of total days that have passed
		
		ds_queue_enqueue(eventQueue, "planet", "system", "faction", "fleet"); // Queue the per-day events to be fired
		
		if(global.currentDay == 30) // If the end of the month has been reached...
		{
			global.monthsPast ++; // iterate the month
			global.currentMonth ++;
			global.currentDay = 1; // Reset the day
			
			ds_queue_enqueue(eventQueue, "month"); // Queue the per-month events to be fired
			
			if(global.currentMonth == 13) // If the end of the year has been reached...
			{
				global.currentMonth = 1;
				global.currentYear ++;
				
				scr_addToQueue("Happy New Year " + string(global.currentYear), c_white); // New year's message
			}
		}
		else // Iterate the day
		{
			global.currentDay ++;
		}
		
		// Update the date string(DD/MM/Y)
		global.currentDate = string(global.currentDay) + "/" + string(global.currentMonth) + "/" + string(global.currentYear);
		
		#region Attempt to fire events
		repeat(ds_queue_size(eventQueue)) // Iterate through the event queue
		{
			var event = ds_queue_dequeue(eventQueue); //Dequeue the top of the queue
			
			if(current_time - global.startTime < 24) //Check if event processing should break in order to preserve FPS
			{
				switch event // Determine which event is being called
				{
					#region Daily events
				
					case "planet": // Fire planetary day event
				
					with(obj_planetParent)
					{
						event_user(0);
					}
				
					break;
				
					case "system":
				
					with(obj_systemParent)
					{
						event_user(0);
					}
				
					break;
				
					case "faction":
				
					with(obj_faction)
					{
						event_user(0);
					}
				
					break;
			
					case "fleet":
				
					with(obj_fleet)
					{
						event_user(0);
					}
				
					break;
				
					#endregion
					
					#region Monthly events
					case "month": // Month case
				
					event_user(1); // Fire all month events
				
					break;
					
					#endregion
				}
			}
			else
			{
				global.stuck = true; // Flag the game as being stuck in processing logic
				break; // Break out of the repeat loop
			}
		}
		#endregion
		
	}
	#endregion
}

#region If there is a lingering backlog of events that need firing
else if(global.step < global.gameSpeed)
{
	global.stuck = false;
	global.step ++;
	
	repeat(ds_queue_size(eventQueue)) // Iterate through the event queue
	{
		var event = ds_queue_dequeue(eventQueue); // Dequeue the top of the queue
			
		if(current_time - global.startTime < 24)
		{
			switch event // Determine which event is being called
			{
				#region Daily events
				
				case "planet": // Fire planetary day event
				
				with(obj_planetParent)
				{
					event_user(0);
				}
				
				break;
				
				case "system":
				
				with(obj_systemParent)
				{
					event_user(0);
				}
				
				break;
				
				case "faction":
				
				with(obj_faction)
				{
					event_user(0);
				}
				
				break;
			
				case "fleet":
				
				with(obj_fleet)
				{
					event_user(0);
				}
				
				break;
				
				#endregion
					
				#region Monthly events
				case "month": // Month case
				
				event_user(1); // Fire all month events
				
				break;
					
				#endregion
			}
		}
		else
		{
			global.stuck = true; // Re-flag the game as being stuck in processing logic
			break; // Break out of the repeat loop
		}
	}
}
else
{
	global.stuck = false; // Pre-emptively clear the "stuck" flag, said flag will be reinstated if processing is still undergoing
	
	repeat(ds_queue_size(eventQueue)) // Iterate through the event queue
	{
		var event = ds_queue_dequeue(eventQueue); // Dequeue the top of the queue
			
		if(current_time - global.startTime < 24)
		{
			switch event // Determine which event is being called
			{
				#region Daily events
				
				case "planet": // Fire planetary day event
				
				with(obj_planetParent)
				{
					event_user(0);
				}
				
				break;
				
				case "system":
				
				with(obj_systemParent)
				{
					event_user(0);
				}
				
				break;
				
				case "faction":
				
				with(obj_faction)
				{
					event_user(0);
				}
				
				break;
			
				case "fleet":
				
				with(obj_fleet)
				{
					event_user(0);
				}
				
				break;
				
				#endregion
					
				#region Monthly events
				case "month": // Month case
				
				event_user(1); // Fire all month events
				
				break;
					
				#endregion
			}
		}
		else
		{
			global.stuck = true; // Re-flag the game as being stuck in processing logic
			break; // Break out of the repeat loop
		}
	}
}

#endregion

#endregion