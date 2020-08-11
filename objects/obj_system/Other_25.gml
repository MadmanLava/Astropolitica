/// @desc Colonization Listener

#region Check border status
if(owner != pointer_null and !ds_list_empty(neighbors))
{
	var i = 0;
	ds_list_clear(emptyNeighbors);
	repeat(ds_list_size(neighbors))
	{
		var neigh = ds_list_find_value(neighbors, i)
		if(neigh.owner == pointer_null and neigh.claim == pointer_null)
		{
			ds_list_add(emptyNeighbors, neigh);
		}
		
		i++
	}
	
	if(!ds_list_empty(emptyNeighbors))
	{
		border = true;
		
		//if(ds_list_find_index(owner.borderSystemList, id) == -1)
		//{
		//	ds_list_add(owner.borderSystemList, id);
		//	show_debug_message(name + " is now a border system!");
		//}
	}
	else
	{
		//show_debug_message(name + " is trying to remove itself!");
		border = false;
		
		//if(ds_list_find_index(owner.borderSystemList, id))
		//{
		//	ds_list_delete(owner.borderSystemList, ds_list_find_index(owner.borderSystemList, id));
		//	show_debug_message(name + " is no longer a border system!");
		//}
	}
}

#endregion