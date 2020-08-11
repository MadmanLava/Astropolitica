//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform sampler2D dataSurf;

void main()
{
	float pos1 = float(v_vColour.r);
	float pos2 = float(v_vColour.g);
	
    //gl_FragColor =
	vec4 finalCol = texture2D( dataSurf, vec2(pos1, pos2) );
	gl_FragColor = finalCol * texture2D( gm_BaseTexture, v_vTexcoord );
}
