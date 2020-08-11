if(file_exists("namelist.json"))
{
	//Parse json as string
	var holder = "";
	var handle = file_text_open_read("namelist.json");
	while(!file_text_eof(handle))
	{
		holder += file_text_readln(handle);
	}
	file_text_close(handle);
	
	//Map Functions
	var nameMap = json_decode(holder);
	show_debug_message("namelist.json was found!");
	
	//Basic
	global.namePrefixes = nameMap[? "prefixes"];
	global.nameRoots = nameMap[? "roots"];
	global.nameSuffixes = nameMap[? "suffixes"];
	global.nameGreaterPrefixes = nameMap[? "greaterPrefixes"];
	
	//Faction Titles
	global.genNames = nameMap[? "genericNames"];
	global.authNames = nameMap[? "authNames"];
	global.demoNames = nameMap[? "demoNames"];
	global.oligNames = nameMap[? "oligNames"];
	global.theoNames = nameMap[? "theoNames"];
	global.repubNames = nameMap[? "republicNames"];
	
	//Vanity
	global.vanityRoots = nameMap[? "vanityRoots"]
	global.vanityGeneric = nameMap[? "vanityNamesGeneric"];
	global.vanityAuthoritarian = nameMap[? "vanityNamesAuthoritarian"];
	global.vanityOligarchic = nameMap[? "vanityNamesOligarchic"];
	global.vanityDemocratic = nameMap[? "vanityNamesDemocratic"];
	global.vanityRepublic = nameMap[? "vanityNamesRepublic"];
	global.vanityTheocratic = nameMap[? "vanityNamesTheocratic"];
	global.vanitySilly = nameMap[? "vanityNamesSilly"];
	
	//var nameMap = 0;
}
else
{
	show_debug_message("namelist.json was not found!");
	return("Error!");
}