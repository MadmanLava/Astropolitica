var list = ds_list_create();
ds_list_add(list,
"[AD] This could be your advert.",
"[AD] Need to escape your existence as a meaningless statistic? Visit the Omaak Club today.",
"[AD] Bored with your cushy life on an established planet? Sign up to colonize a hellish rock today.",
"[AD] Aetherweb Industries presents the 800T model defense android, for all your security needs.",
"[NEWS] Voronacirus labeled " + instance_find(obj_faction, irandom_range(0, instance_number(obj_faction)-1)).baseName + " hoax",
"[NEWS] " + instance_find(obj_faction, irandom_range(0, instance_number(obj_faction)-1)).baseName + choose(" man ", " woman ") + 
choose("dead after attempt to mine Neutronium with screwdriver", "attempts to fuel starship with narcotics", "arrested for bungee jumping off space elevator", "attempts to mine moon for cheese",
"attempts reentry hiding behind a slab of alloy", "arrested for grafting cloned limbs to self as Halloween costume", "dead after opening helmet to smell space", "arrested for launching sink at warship",
"presumed dead after attempting to land on black hole", "attempts to rob system stockpile with spoon", "arrested for using holograms to claim supernatural power", "arrested for attempting to sell drugs to nonsapient aliens",
"arrested for selling sections of black hole event horizon as an infinite storage unit", "vaporized after attempting to land on star", "arrested after attempting to create clone army in their bedroom",
"missing, last seen making deal with sapient alien", "attempts to bombard planet with trash", "attempts communication with alien natives through dance, found dead", "arrested for selling weapons of mass destruction at auction",
"dead after opening spaceship viewport to get fresh air", "arrested for attempting to use sparsely populated planet to host battle royale", "claims to be \"God-Emperor of Mankind\""
),
"[NEWS] Top scientists continue to laugh off \"Not-Flat Galaxy Theory\"",
"[NEWS] Staff of black hole observatory missing",
"[NEWS] Robot uprising occurs after factory accidentally sets mode to \"Dont Obey\"",
"[NEWS] Correlation between increase in space travelers and towel sales discovered",
"[NEWS] Horse paralyzed with awe after realizing secrets of the universe",
"[NEWS] Inhabitant of cylindrical space habitat claims habitat to actually be flat",
"[NEWS] Aging cruiser claims to have discovered ringworld, all contact lost thereafter",
"[NEWS] Alien parasite released on space station, crew labels it \"No big deal\"",
"[NEWS] Planetary governor of planet orbiting Class W Star denies radiation problem",
"[NEWS] Engineer claims self-designed thruster works by moving the entire rest of the universe",
"[NEWS] Famous commando discharged after refusing to speak in anything but catchy one-liners",
"[NEWS] Plans to build new hyperlane delayed after planet discovered in the way",
"[NEWS] Experimental temporal warship destroyed after colliding with its future self",
"[NEWS] Ancient bunkers unearthed and opened, inhabitants disappointed by outside world's survival",
"[NEWS] Local official continues to deny allegations of being a shapeshifter"
);

var ans = scr_randFromList(list);
return ans