///@arg list

var list = argument0;
var listSize = ds_list_size(list);

if(listSize > 0)
{
	var result = ds_list_find_value(list, irandom_range(0, listSize-1));
	return result;
}
else
{
	show_debug_message("This list is empty!");
	return undefined;
}