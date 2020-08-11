/// scr_propernoun(suffix, prefix);
/// Generates a proper noun.

#region Main noun

#region Init name lists
var prefList = global.namePrefixes;
var rootList = global.nameRoots;
var suffList = global.nameSuffixes;
var greatPrefList = global.nameGreaterPrefixes;

#endregion

var pref = ds_list_find_value(prefList, irandom_range(0, ds_list_size(prefList) - 1));
var root = ds_list_find_value(rootList, irandom_range(0, ds_list_size(rootList) - 1));

var baseName = pref + root;

#endregion

if(argument0) //suffix
{
	var suff = ds_list_find_value(suffList, irandom_range(0, ds_list_size(suffList) - 1));
	baseName += suff;
}

if(argument1) // prefix
{
	var greatPref = ds_list_find_value(greatPrefList, irandom_range(0, ds_list_size(greatPrefList) - 1));
	baseName = greatPref + baseName;
}

return baseName;