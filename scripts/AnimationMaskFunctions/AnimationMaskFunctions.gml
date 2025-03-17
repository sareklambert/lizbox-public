/// @function		AnimationMaskInit();
/// @description	Sets the variables for the mask shader's uniforms and samplers.
function AnimationMaskInit() {
	uMaskTex = shader_get_sampler_index(shdMask, "maskTex");
	uRampTex = shader_get_sampler_index(shdMask, "rampTex");
	uRampXMin = shader_get_uniform(shdMask, "rampXMin");
	uRampXMax = shader_get_uniform(shdMask, "rampXMax");
	uRampYMin = shader_get_uniform(shdMask, "rampYMin");
	uTime = shader_get_uniform(shdMask, "time");
	uInvert = shader_get_uniform(shdMask, "invert");
	uRimSize = shader_get_uniform(shdMask, "rimSize");
	uSmoothness = shader_get_uniform(shdMask, "smoothness");
	uPulseRange = shader_get_uniform(shdMask, "pulseRange");
	uMaskTransform = shader_get_uniform(shdMask, "maskTransform");	
};

/// @function				AnimationMaskDraw(xx, yy, spr, mask, ramp, time, scale);
/// @param {Real} xx			The animations x position.
/// @param {Real} yy			The animations y position.
/// @param {Asset.GMSprite} spr		The base sprite.
/// @param {Asset.GMSprite} mask	The mask sprite.
/// @param {Asset.GMSprite} ramp	The ramp sprite.
/// @param {Real} time			The time.
/// @param {Real} scale			The animations scale.
/// @description			Draws the mask animation.
function AnimationMaskDraw(xx, yy, spr, mask, ramp, time, scale) {
	// Get textures and UVs
	var maskTex = sprite_get_texture(mask, 0);
	var rampTex = sprite_get_texture(ramp, 0);
	var vec = AnimationMaskGetTransformVector(spr, mask);
	var uvs = texture_get_uvs(rampTex);
	
	// Set shader and texfilter
	gpu_set_tex_filter_ext(uRampTex, true);
	shader_set(shdMask);
	
	// Pass samplers and uniforms
	texture_set_stage(uMaskTex, maskTex);
	texture_set_stage(uRampTex, rampTex);
	shader_set_uniform_f(uRampXMin, uvs[0]);
	shader_set_uniform_f(uRampXMax, uvs[2] - uvs[0]);
	shader_set_uniform_f(uRampYMin, uvs[1]);
	shader_set_uniform_f(uTime, time);
	shader_set_uniform_f(uInvert, optionInvert);
	shader_set_uniform_f(uRimSize, optionColorRimSize);
	shader_set_uniform_f(uSmoothness, optionEdgeSmoothness);
	shader_set_uniform_f(uPulseRange, optionPulseRange);
	shader_set_uniform_f_array(uMaskTransform, vec);
	
	// Draw the animation
	draw_sprite_ext(spr, 0, xx, yy, scale, scale, 0, c_white, 1);
	
	// Reset shader and texfilter
	shader_reset();
	gpu_set_tex_filter(false);
};

/// @function				getMaskTransformVector(spr, mask);
/// @param {Asset.GMSprite} spr		The base sprite to use.
/// @param {Asset.GMSprite} mask	The mask sprite to use.
/// @description			Calculates the mask transformation vector.
function AnimationMaskGetTransformVector(spr, mask) {
	var sprUVS = sprite_get_uvs(spr, 0);
	var sprW = sprUVS[2] - sprUVS[0];
	var sprH = sprUVS[3] - sprUVS[1];
	
	var maskUVS = sprite_get_uvs(mask, 0);
	var maskW = maskUVS[2] - maskUVS[0];
	var maskH = maskUVS[3] - maskUVS[1];
	
	var scaleX = maskW / sprW;
	var scaleY = maskH / sprH;
	var shiftX = maskUVS[0] - sprUVS[0] * scaleX;
	var shiftY = maskUVS[1] - sprUVS[1] * scaleY;
	
	return [scaleX, scaleY, shiftX, shiftY];
};
