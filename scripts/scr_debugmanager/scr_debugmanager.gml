//Arg 0: Entered string from the debug console

//NOTE: Do not return until desired operations are complete.

var arg = argument0;

if(arg == "help")
{
	return("help: Shows this menu. have a buncha text so that it spills over the edge k thx\nblarg: blarg.");
}
else if(arg == "blarg")
{
	return("blarg.");
}
else if(arg == "crash")
{
	game_end();
}
else if(arg == "objectCount")
{
	return(string(instance_count) + " objects");
}
else if(arg == "reinvigorateStarGen")
{
	with(obj_system)
	{
		failedTries = 0;
	}
	return("Stars reinvigorated!");
}
else if(arg == "starInfo")
{
	var a = "Desired Star Count: " + string(global.starCount) + "\n";
	a = a + "Actual Star Count: " + string(global.genStarCount) + "\n";
	a = a + "Rare Star Count: " + string(global.rareStarCount) + "\n";
	a = a + "Class E Star Count: " + string(global.eStarCount) + "\n";
	a = a + "Class O Star Count: " + string(global.classOCount) + "\n";
	a = a + "Class B Star Count: " + string(global.classBCount) + "\n";
	a = a + "Class A Star Count: " + string(global.classACount) + "\n";
	a = a + "Class F Star Count: " + string(global.classFCount) + "\n";
	a = a + "Class G Star Count: " + string(global.classGCount) + "\n";
	a = a + "Class K Star Count: " + string(global.classKCount) + "\n";
	a = a + "Class M Star Count: " + string(global.classMCount) + "\n";
	a = a + "Class W Star Count: " + string(global.classWCount) + "\n";
	a = a + "Class D Star Count: " + string(global.classDCount) + "\n";
	a = a + "Neutron Star Count: " + string(global.neutronCount) + "\n";
	a = a + "Black Hole Count: " + string(global.blackholeCount) + "\n";
	return(a);
}
else if(arg == "laneInfo")
{
	var a = "Hyperlane Count: " + string(global.genHyperlaneCount);
	return(a);
}
else if(arg == "factionInfo")
{
	var a = "Initial Faction Count: " + string(global.factionCount) + "\n";
	a = a + "Current Faction Count: " + string(global.genFactionCount) + "\n";
	return(a);
}
else if(arg == "spawnNewFaction")
{
	instance_create_depth(0, 0, 0, obj_faction);
	global.genFactionCount ++;
	return("Spawned a new faction!")
}
else
{
	var a = "'" + arg + "'" + " is not a command.";
	return(a);
}