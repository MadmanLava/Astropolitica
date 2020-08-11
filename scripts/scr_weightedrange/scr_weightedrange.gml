/// Arg0: Lower Bound
/// Arg1: Upper Bound
/// Arg2: Weight
/// Arg3: Negative?

var weight = irandom_range(0, argument2);
if(argument3)
{
	weight = -(weight);
}

var value = irandom_range(argument0, argument1) + weight;

value = clamp(value, argument0, argument1);

return value;