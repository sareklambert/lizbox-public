varying vec2 v_vTexcoord;
varying vec2 v_vMaskcoord;
varying vec4 v_vColour;

uniform sampler2D maskTex;
uniform sampler2D rampTex;
uniform float rampXMin;
uniform float rampXMax;
uniform float rampYMin;
uniform float time;
uniform float invert;
uniform float rimSize;
uniform float smoothness;
uniform float pulseRange;

void main() {
	// Factor rimSize into time
	float timeExt = time + time * rimSize;
	
	// Get texture samples
	vec4 baseCol = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	float maskVal = abs(invert - texture2D(maskTex, v_vMaskcoord).r);
	
	// Colored rim
	if (rimSize > 0.0) {
		// Get ramp color sample
		float rampPos = smoothstep(maskVal, maskVal + rimSize, timeExt);
		vec4 rampCol = texture2D(rampTex, vec2(rampXMin + rampXMax * rampPos, rampYMin));
		
		// Mix RGBA
		float blendWeight = smoothstep(maskVal + rimSize * 0.25, maskVal + rimSize, timeExt);
		baseCol.rgb = mix(rampCol.rgb, baseCol.rgb, blendWeight);
		float alphaWeight = smoothstep(rampPos, rampPos, 0.25);
		baseCol.a = mix(baseCol.a, rampCol.a * baseCol.a, alphaWeight);
	}
	
	// Apply edge smoothness
	baseCol.a *= smoothstep(maskVal, maskVal + smoothness, timeExt);
	
	// Pulse mode
	if (pulseRange > 0.0) {
		if (invert == 1.0) {
			baseCol.a *= smoothstep(time - pulseRange, time - pulseRange + smoothness, maskVal);
		} else {
			baseCol.a *= smoothstep(time, time + smoothness, maskVal + pulseRange);
		}
	}
	
	// Output
	gl_FragColor = baseCol;
}
