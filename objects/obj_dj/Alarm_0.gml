//Switch tracks
var tempList = ds_list_create();
ds_list_copy(tempList, musicList);
var oldPos = ds_list_find_index(musicList, currentlyPlaying);
ds_list_delete(tempList, oldPos);

currentlyPlaying = ds_list_find_value(tempList, irandom_range(0, ds_list_size(tempList)-1));
ds_list_destroy(tempList);

delay = false;