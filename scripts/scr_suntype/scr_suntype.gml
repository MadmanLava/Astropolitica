///Rolls for the star type.

var roll = random_range(0, 100);
var type = "Class E";

//Class E(0.01%)
if(roll <= 0.001)
{
	type = "Class E";
}

//Class O(1.99%)
else if(roll <= 1.999)
{
	type = "Class O";
}

//Class B(4%)
else if(roll > 1.99 and roll < 5.99)
{
	type = "Class B";
}

//Class A(8%)
else if(roll > 5.99 and roll <= 13.99)
{
	type = "Class A";
}

//Class F(10%)
else if(roll > 13.99 and roll <= 23.99)
{
	type = "Class F";
}

//Class G(20%)
else if(roll > 23.99 and roll <= 43.99)
{
	type = "Class G";
}

//Class K(30%)
else if(roll > 43.99 and roll <= 73.99)
{
	type = "Class K";
}

//Class M(20%)
else if(roll > 73.99 and roll <= 93.99)
{
	type = "Class M";
}

//Class W(5%)
else if(roll > 93.99 and roll <= 98.99)
{
	type = "Class W";
}

//Class D(1%)
else if(roll > 98.99 and roll <= 99.99)
{
	type = "Class D";
}
//Error
else
{
	type = "Class E";
}

return type;