/// scr_namegenerator(mode, authType, gov, prefixAllowed, custom)
/// @arg0 mode
/// @arg1 authType
/// @arg2 govType
/// @arg3 prefix
/// @arg4 custom

var mode = "basic"
var arg = argument0;
var authType = argument1;
var govType = argument2;
var prefixAllowed = argument3;
var custom = argument4;

if(arg == "faction")
{
	mode = "faction";
}

if(prefixAllowed)
{
	var baseName = scr_propernoun(scr_chance(30), scr_chance(10));
}
else
{
	var baseName = scr_propernoun(scr_chance(30), false);
}

if(mode = "faction")
{
	#region Normal
	if(!custom)
	{
		
		if(scr_chance(80)) // Non-generic
		{
			var fullName = "";
		
			if(govType != "Democratic Republic")
			{
				switch authType
				{
					case "Authoritarian":
					fullName = scr_randFromList(global.authNames);
					break;
				
					case "Oligarchic":
					fullName = scr_randFromList(global.oligNames);
					break;
				
					case "Democratic":
					fullName = scr_randFromList(global.demoNames);
					break;
				
					case "Theocratic":
					fullName = scr_randFromList(global.theoNames);
					break;
				}
			}
			else //republics
			{
				fullName = scr_randFromList(global.repubNames);
			}
		}
		else //generic
		{
			fullName = scr_randFromList(global.genNames)
		}
		
		return(baseName + "|" + baseName + " " + fullName);
	}
	
	#endregion

	#region Vanity names
	else
	{
		if(scr_chance(80)) // Non-generic
		{
			if(govType != "Democratic Republic")
			{
				switch authType
				{
					case "Authoritarian":
					var pos = irandom_range(0, ds_list_size(global.vanityAuthoritarian)-1);
					var holder = ds_list_find_value(global.vanityAuthoritarian, pos);
					ds_list_delete(global.vanityAuthoritarian, pos);
					
					if(is_undefined(holder)) //List Empty
					{
						var pos = irandom_range(0, ds_list_size(global.vanityGeneric)-1);
						var holder = ds_list_find_value(global.vanityGeneric, pos);
						ds_list_delete(global.vanityGeneric, pos);
			
						if(is_undefined(holder)) //List Empty(again)
						{
							var fullName = scr_randFromList(global.authNames);
							var holder = baseName + "|" + baseName + " " + fullName
						}
					}
					
					return(holder);
					break;
			
					case "Oligarchic":
					var pos = irandom_range(0, ds_list_size(global.vanityOligarchic)-1);
					var holder = ds_list_find_value(global.vanityOligarchic, pos);
					ds_list_delete(global.vanityOligarchic, pos);
					
					if(is_undefined(holder)) //List Empty
					{
						var pos = irandom_range(0, ds_list_size(global.vanityGeneric)-1);
						var holder = ds_list_find_value(global.vanityGeneric, pos);
						ds_list_delete(global.vanityGeneric, pos);
			
						if(is_undefined(holder)) //List Empty(again)
						{
							var fullName = scr_randFromList(global.oligNames);
							var holder = baseName + "|" + baseName + " " + fullName
						}
					}
					
					return(holder);
					break;
			
					case "Democratic":
					var pos = irandom_range(0, ds_list_size(global.vanityDemocratic)-1);
					var holder = ds_list_find_value(global.vanityDemocratic, pos);
					ds_list_delete(global.vanityDemocratic, pos);
					
					if(is_undefined(holder)) //List Empty
					{
						var pos = irandom_range(0, ds_list_size(global.vanityGeneric)-1);
						var holder = ds_list_find_value(global.vanityGeneric, pos);
						ds_list_delete(global.vanityGeneric, pos);
			
						if(is_undefined(holder)) //List Empty(again)
						{
							var fullName = scr_randFromList(global.demoNames);
							var holder = baseName + "|" + baseName + " " + fullName
						}
					}
					
					return(holder);
					break;
			
					case "Theocratic":
					var pos = irandom_range(0, ds_list_size(global.vanityTheocratic)-1);
					var holder = ds_list_find_value(global.vanityTheocratic, pos);
					ds_list_delete(global.vanityTheocratic, pos);
					
					if(is_undefined(holder)) //List Empty
					{
						var pos = irandom_range(0, ds_list_size(global.vanityGeneric)-1);
						var holder = ds_list_find_value(global.vanityGeneric, pos);
						ds_list_delete(global.vanityGeneric, pos);
			
						if(is_undefined(holder)) //List Empty(again)
						{
							var fullName = scr_randFromList(global.theoNames);
							var holder = baseName + "|" + baseName + " " + fullName
						}
					}
					
					return(holder);
					break;
				}
			}
			else //Republics
			{
				var pos = irandom_range(0, ds_list_size(global.vanityRepublic)-1);
				var holder = ds_list_find_value(global.vanityRepublic, pos);
				ds_list_delete(global.vanityRepublic, pos);
					
				if(is_undefined(holder)) //List Empty
				{
					var pos = irandom_range(0, ds_list_size(global.vanityGeneric)-1);
					var holder = ds_list_find_value(global.vanityGeneric, pos);
					ds_list_delete(global.vanityGeneric, pos);
			
					if(is_undefined(holder)) //List Empty(again)
					{
						var fullName = scr_randFromList(global.repubNames);
						var holder = baseName + "|" + baseName + " " + fullName
					}
				}
					
				return(holder);
			}
		}
		else //Generic
		{
			var pos = irandom_range(0, ds_list_size(global.vanityGeneric)-1);
			var holder = ds_list_find_value(global.vanityGeneric, pos);
			ds_list_delete(global.vanityGeneric, pos);

			if(is_undefined(holder)) //List Empty(again)
			{
				var fullName = scr_randFromList(global.genNames);
				var holder = baseName + "|" + baseName + " " + fullName
			}
					
			return(holder);
		}
	}

	#endregion

}
else
{
	
	return(baseName);
}