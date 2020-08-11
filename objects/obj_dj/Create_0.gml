paused = false;
delay = false;

musicList = ds_list_create();
ds_list_add(musicList, mus_reverie, mus_somethingwicked, mus_fall, mus_interstellar);

currentlyPlaying = pointer_null;

//Start playing
audio_play_sound(mus_reverie, 0, false);
currentlyPlaying = mus_reverie;