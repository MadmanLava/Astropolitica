var facList = ds_list_create();

if(directory_exists(working_directory + "/customfactions"))
{
	
	var fileName = file_find_first(working_directory + "/customfactions/*", 0)
		
	while(fileName != "")
	{
		ds_list_add(facList, fileName);
		fileName = file_find_next();
		show_debug_message(fileName);
	}
		
	var facListSize = ds_list_size(facList);
		
	if(facListSize > 0)
	{
		show_debug_message("Found at least one file!");
		show_debug_message(ds_list_find_value(facList, 0))
	}
		
	file_find_close();
}

global.customFacList = facList;
ds_list_destroy(facList);