///@arg value
///@arg invert

if(!argument1)
{
	if(argument0)
	{
		return true;
	}
	else
	{
		return false;
	}
}
else
{
	if(argument0)
	{
		return false;
	}
	else
	{
		return true;
	}
}