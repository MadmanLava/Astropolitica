/// @param textElement   Text element to target. This element must have been created previously by scribble_draw()
/// @param method        Typewriter method to use to fade in, either per-character or per-line. See below
/// @param speed         Amount of text to reveal per tick (1 tick is usually 1 frame). This is character or lines depending on the method defined above
/// @param smoothness    How much text fades in. Higher numbers will allow more text to be visible as it fades in
/// 
/// The method argument allows you to choose between two behaviours to fade in text. Most retro-styled games will likely want to use
/// SCRIBBLE_AUTOTYPE_PER_CHARACTER:  this method will draw characters one by one like a typewriter. Modern text-heavy narrative games
/// may want to use SCRIBBLE_AUTOTYPE_PER_LINE instead.
/// 
/// How the text is revealed can be customised further by modifying the smoothness argument. A high value will cause text to be smoothly
/// faded in whereas a smoothness of 0 will cause text to instantly pop onto the screen. For advanced users, custom shader code can be easily
/// combined with the smoothness value to animate text as it fades in.
/// 
/// Events (in-line scripts) will be executed as text fades in. This is a powerful tool and can be used to achieve many things, including
/// triggering sound effects, changing character portraits, starting movement of instances, starting weather effects, giving the player items,
/// and so on.

var _scribble_array = argument0;
var _method         = argument1;
var _speed          = argument2;
var _smoothness     = argument3;

//Check if this array is a relevant text element
if (!is_array(_scribble_array)
|| (array_length_1d(_scribble_array) != SCRIBBLE.__SIZE)
|| (_scribble_array[SCRIBBLE.VERSION] != __SCRIBBLE_VERSION))
{
    if (SCRIBBLE_VERBOSE) show_debug_message("Scribble: Array passed to scribble_autotype_fade_in() is not a valid Scribble text element.");
    exit;
}

if (_scribble_array[SCRIBBLE.FREED]) exit;

if ((_method != SCRIBBLE_AUTOTYPE_NONE)
&&  (_method != SCRIBBLE_AUTOTYPE_PER_CHARACTER)
&&  (_method != SCRIBBLE_AUTOTYPE_PER_LINE)
&&  (_method != undefined))
{
    show_error("Scribble:\nMethod not recognised.\nPlease use SCRIBBLE_AUTOTYPE_NONE, SCRIBBLE_AUTOTYPE_PER_CHARACTER, or SCRIBBLE_AUTOTYPE_PER_LINE.\n ", false);
    _method = SCRIBBLE_AUTOTYPE_NONE;
}

//Update the remaining autotype state values
_scribble_array[@ SCRIBBLE.AUTOTYPE_TAIL_POSITION] = -_smoothness;
_scribble_array[@ SCRIBBLE.AUTOTYPE_HEAD_POSITION] = 0;
if (_method != undefined) _scribble_array[@ SCRIBBLE.AUTOTYPE_METHOD] = _method;
_scribble_array[@ SCRIBBLE.AUTOTYPE_SPEED     ] = _speed;
_scribble_array[@ SCRIBBLE.AUTOTYPE_SMOOTHNESS] = _smoothness;
_scribble_array[@ SCRIBBLE.AUTOTYPE_FADE_IN   ] = true;
_scribble_array[@ SCRIBBLE.AUTOTYPE_SKIP      ] = false;

//Reset this page's previous event position too
var _pages_array = _scribble_array[@ SCRIBBLE.PAGES_ARRAY];
var _page_array = _pages_array[_scribble_array[SCRIBBLE.AUTOTYPE_PAGE]];

_page_array[@ __SCRIBBLE_PAGE.EVENT_PREVIOUS     ] = -1;
_page_array[@ __SCRIBBLE_PAGE.EVENT_CHAR_PREVIOUS] = -1;

//Clear out our event visited array
var _event_visited_array = _page_array[__SCRIBBLE_PAGE.EVENT_VISITED_ARRAY];
_page_array[@ __SCRIBBLE_PAGE.EVENT_VISITED_ARRAY] = array_create(array_length_1d(_event_visited_array), false);