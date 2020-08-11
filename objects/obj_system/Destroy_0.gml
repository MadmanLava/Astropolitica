global.genStarCount = global.genStarCount - 1;
ds_list_delete(global.systemList, instance_id);

ds_list_destroy(planetList);
ds_list_destroy(habitablePlanetList);
ds_list_destroy(neighbors);
ds_list_destroy(emptyNeighbors);

ds_map_destroy(income);
ds_map_destroy(stockpile);
ds_map_destroy(tax);
ds_map_destroy(desired);
ds_map_destroy(value);
ds_map_destroy(incomeQuota);
ds_map_destroy(stockQuota);
ds_map_destroy(upkeep);
ds_map_destroy(trade);