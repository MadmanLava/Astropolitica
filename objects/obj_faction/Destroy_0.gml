ds_list_destroy(systemList);
ds_list_destroy(planetList);
ds_list_destroy(borderSystemList);
ds_list_destroy(shipyardLocations);
ds_list_destroy(refugeesAllowed);
ds_list_destroy(closedBorders);
ds_list_destroy(naps);
ds_list_destroy(alliances);
ds_list_destroy(atWar);
ds_list_destroy(failedList);

ds_priority_destroy(colonistPriority);

ds_priority_destroy(energyRanking);
ds_priority_destroy(metalRanking);
ds_priority_destroy(RERanking);
ds_priority_destroy(gasRanking);
ds_priority_destroy(radioRanking);
ds_priority_destroy(crystalRanking);
ds_priority_destroy(foodRanking);
ds_priority_destroy(alloysRanking);
ds_priority_destroy(nanoRanking);
ds_priority_destroy(consumerRanking);
ds_priority_destroy(advancedRanking);

ds_map_destroy(opinion);
ds_map_destroy(stockpile);
ds_map_destroy(income);
ds_map_destroy(upkeep);
ds_map_destroy(spent);

ds_map_destroy(demoPlan);
ds_map_destroy(ecoPlanIncome);
ds_map_destroy(ecoPlanStockpile);

ds_map_destroy(milestones);