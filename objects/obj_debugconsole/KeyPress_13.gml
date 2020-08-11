if(consoleOpen and typing and inputHolder != "")
{
	//typing = false;
	
	ds_list_add(priorInputs, inputHolder);
	priorPos = ds_list_size(priorInputs);
	
	result = scr_debugmanager(inputHolder);
	keyboard_string = "";
	ds_list_add(displayList, result);
	if(ds_list_size(displayList) > 20)
	{
		ds_list_delete(displayList, 0)
	}
}