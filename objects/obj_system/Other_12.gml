///@desc Colonize child planets.

var i = 0;
var planet = pointer_null;

repeat(ds_list_size(planetList))
{
	planet = ds_list_find_value(planetList, i);
	
	if(owner != pointer_null)
	{
		planet.owner = owner;
		planet.ownerName = ownerName;
		planet.occupier = pointer_null;
		owner.planets += planetCount;
	
		ds_list_add(owner.planetList, planet);
	
		if(planet.capitol)
		{
			planet.population = planet.maxPopulation/2;
		}
		else
		{
			planet.population = planet.maxPopulation/10;
		}
	
	}
	
	if(planet.type == "Rocky")
	{
		if(planet.baseMaxPop >= 50)
		{
			ds_list_add(habitablePlanetList, planet);
			habitablePlanetCount++;
		}
	}
	else
	{
		population = 0;
	}
	
	maxPopulation += planet.maxPopulation;
	
	i++;
}
event_user(15);