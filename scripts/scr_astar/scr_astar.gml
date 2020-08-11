///scr_astar(start, end, list to return a path to, faction calling)

var startNode = argument0;
var endNode = argument1;

var pathList = argument2;

var faction = argument3;

var openList = ds_list_create(); //Nodes being considered
var closedList = ds_list_create(); //Nodes no longer being considered

//Add the start node
ds_list_add(openList, startNode);
startNode.gCost = 0;
startNode.hCost = point_distance(startNode.x, startNode.y, endNode.x, endNode.y) / 2;
startNode.fCost = 0;

//Close invalid nodes

//Loop(while the open list is not empty
while(ds_list_size(openList) != 0)
{
	//Get the node with the lowest f cost from all nodes in the open set
	var currentNode = ds_list_find_value(openList,0);
    var index = 0;
    for (var i=0;i<ds_list_size(openList);++i)
    {
        var tmpNode = ds_list_find_value(openList,i);
        if (tmpNode.fCost < currentNode.fCost)
        {
            currentNode = tmpNode;
            index = i;
        }
    }
    ds_list_delete(openList,index);
    ds_list_add(closedList,currentNode);
	
	//Check if the goal has been reached
	if(currentNode == endNode)
	{
		ds_list_destroy(openList);
        ds_list_destroy(closedList);
		
		var currentNode = endNode;
		
		while(currentNode != startNode)
		{
			ds_list_insert(pathList, 0, currentNode);
			currentNode = currentNode.pathParent;
		}
		
		ds_list_insert(pathList, 0, startNode);
		//show_debug_message("Pathfinding success!");
		return true;
	}
	
	///For each neighbor
	for (var i=0;i<ds_list_size(currentNode.neighbors);++i)
    {
		//Grab childNode handle
		var childNode = ds_list_find_value(currentNode.neighbors, i);
		
		//Check if on the closed list
		if(ds_list_find_index(closedList, childNode))
		{
			//Return to beginning of for loop
			continue;
		}
		//Check if belonging to another faction
		/*
		if(childNode.owner != faction and childNode.owner != pointer_null)
		{
			continue;
		}
		*/
		
		//Calculate new movement cost
		var newMovementCost = currentNode.gCost + point_distance(currentNode.x, currentNode.y, childNode.x, childNode.y);
		
		//Check if child is already in the openlist
		if(ds_list_find_index(openList, childNode))
		{
			var inOpenList = true;
		}
		else
		{
			var inOpenList = false;
		}
		
		//If the new calculated node cost is less than the child cost, or the child node is not in the open set...
		if(newMovementCost < childNode.gCost or !inOpenList)
		{
			//Compute the f, g, and h values
			childNode.gCost = currentNode.gCost + 1;
			childNode.hCost = point_distance(childNode.x, childNode.y, endNode.x, endNode.y);
			childNode.fCost = childNode.gCost + childNode.hCost;
			
			//Set parent for retracing
			childNode.pathParent = currentNode;
			
			//Add to open set if not already
			if(!inOpenList)
			{
				ds_list_add(openList, childNode);
			}
		}
	}
}

//Cleanup
ds_list_destroy(openList);
ds_list_destroy(closedList);

//If while loop did not return a path, return with a failure
return false;