/// @desc toggle UI

if(global.genStage == gen.completed)
{
	switch showUI
	{
		case true:
		showUI = false;
		break;
	
		case false:
		showUI = true;
		break;
	}
}