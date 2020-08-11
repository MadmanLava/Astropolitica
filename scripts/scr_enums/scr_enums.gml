//Initialize enumerators and macros

#macro SCREEN_MINIMUM_W 1280
#macro SCREEN_MINIMUM_H 720

#macro CAM_MINIMUM_SCALE 3200
#macro CAM_BASE_WIDTH 16000

//Generation Stage
enum gen
{
	inactive,
	preStars,
	placeStars,
	calcLanes,
	pruneLanes,
	detailStars,
	detailPlanets,
	placeFactions,
	finalize,
	completed
}