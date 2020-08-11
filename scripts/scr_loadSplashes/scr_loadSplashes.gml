if(file_exists("splashes.json"))
{
	//Parse json as string
	var holder = "";
	var handle = file_text_open_read("splashes.json");
	while(!file_text_eof(handle))
	{
		holder += file_text_readln(handle);
	}
	file_text_close(handle);
	
	//Map Functions
	var splashMap = json_decode(holder);
	show_debug_message("splashes.json was found!");
	
	var splashList = splashMap[? "splashes"];
	
	global.currentSplash = ds_list_find_value(splashList, irandom_range(0, ds_list_size(splashList)-1));
	ds_list_destroy(splashList);
}
else
{
	show_debug_message("splashes.json was not found!");
}

//guide
if(file_exists("guide.txt"))
{
	//Parse string
	var holder = "";
	var handle = file_text_open_read("guide.txt");
	while(!file_text_eof(handle))
	{
		holder += file_text_readln(handle);
	}
	file_text_close(handle);
	
	//Map Functions
	show_debug_message("guide.txt was found!");
	
	global.guideText = holder;
}
else
{
	show_debug_message("guide.txt was not found!");
}