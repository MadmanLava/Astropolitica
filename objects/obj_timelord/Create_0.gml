// Event Queue
eventQueue = ds_queue_create();

#region Underlying Values
global.gameSpeed = 5; // Tick delay between steps/days
global.stuck = false; // Indicates that the eventQueue is not empty, to allow all events to process correctly.
global.step = 1; // Sub-day ticks, iterated per frame
global.paused = true;
global.startTime = 0; // Declaration for the time at the start of a frame

#endregion

#region Date
global.currentDate = "1/1/1" // String for the current date.
global.currentDay = 1; // Current day.
global.currentMonth = 1; // Current month.
global.currentYear = 1; // Current year.

#endregion

#region Time Passed
global.daysPast = 0; // Actual # of days that have passed.
global.monthsPast = 0; // Actual # of months that have passed.

#endregion