///@desc Clean up obj_timelord as part of a game reset.

#region Reset Underylying Timekeeping
global.gameSpeed = 5; //Tick delay between steps/days
global.stuck = false;
global.step = 1;
global.paused = true;
global.startTime = 0;

#endregion

#region Reset Date
global.currentDate = "1/1/1"
global.currentDay = 1;
global.currentMonth = 1;
global.currentYear = 1;

#endregion

#region Reset the time passed
global.daysPast = 0;
global.monthsPast = 0;

#endregion

#region Reset the eventQueue
if(ds_exists(eventQueue, ds_type_queue)) // Ensure the eventQueue exists
{
	ds_queue_clear(eventQueue) // Clear the event quque
}
else // Create the event queue
{
	eventQueue = ds_queue_create();
}

#endregion