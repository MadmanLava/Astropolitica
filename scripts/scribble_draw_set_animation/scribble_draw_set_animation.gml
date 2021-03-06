/// Sets the various properties of Scribble's dynamic rendering
/// 
/// @param animProperty  Integer index for the target animation property (see enum SCRIBBLE_ANIM)
/// @param value         Value to set the property to
/// 
/// [ 0]   waveSize         Maximum pixel offset of the [wave] effect                                                                                
/// [ 1]   waveFrequency    Frequency of the [wave] effect. Larger values will create more horizontally frequent "humps" in the text                 
/// [ 2]   waveSpeed        Speed of the [wave] effect                                                                           
/// [ 3]   shakeSize        Maximum pixel offset of the [shake] effect                                                                               
/// [ 4]   shakeSpeed       Speed of the [shake] effect. Larger numbers cause text to shake faster                                                   
/// [ 5]   rainbowWeight    Blend weight of the [rainbow] effect. A value of 0 will not apply the effect, a value of 1 will blend with 100% weighting
/// [ 6]   rainbowSpeed     Cycling speed of the [rainbow] effect. Increase to make colour scrolling faster                                            
/// [ 7]   wobbleAngle      Maximum angular offset of the [wobble] effect                                                   
/// [ 8]   wobbleFrequency  Speed of the [wobble] effect. Larger numbers cause text to oscillate faster                                              
/// [ 9]   pulseScale       Maximum scale of the [pulse] effect                                                                      
/// [10]   pulseSpeed       Speed of the [pulse] effect. Larger values will cause text to shrink and grow faster   
/// [11]   wheelSize        Maximum pixel offset of the [wheel] effect                                                                                
/// [12]   wheelFrequency   Frequency of the [wheel] effect. Larger values will create more chaotic motion            
/// [13]   wheelSpeed       Speed of the [wheel] effect                                      
/// 
/// Find out more about what animation effects are available on the wiki: https://github.com/JujuAdams/scribble/wiki/(5.5.0)-Text-Formatting
/// 
/// This script "sets state". All text drawn with scribble_draw() will use these settings until they're overwritten,
/// either by calling this script again or by calling scribble_draw_reset() / scribble_draw_set_state().

enum SCRIBBLE_ANIM
{
    WAVE_SIZE,      // 0
    WAVE_FREQ,      // 1
    WAVE_SPEED,     // 2
    SHAKE_SIZE,     // 3
    SHAKE_SPEED,    // 4
    RAINBOW_WEIGHT, // 5
    RAINBOW_SPEED,  // 6
    WOBBLE_ANGLE,   // 7
    WOBBLE_FREQ,    // 8
    PULSE_SCALE,    // 9
    PULSE_SPEED,    //10
    WHEEL_SIZE,     //11
    WHEEL_FREQ,     //12
    WHEEL_SPEED,    //13
    __SIZE,         //14
}

global.scribble_state_anim_array[@ argument0] = argument1;