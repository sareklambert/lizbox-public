/// @description Initialize the main object
// Initialize the time variable
time = 0;

// Set sprite names
spr = sBase;
mask = sMask;
ramp = sRamp;

// Set options
optionFPS = 60;
optionSeconds = 2;
optionTimeCurve = ANIM_CURVE.LINEAR;
optionInvert = 0;
optionColorRimSize = 0.22;
optionEdgeSmoothness = 0;
optionPulseRange = 0;

// Initialize the mask animation
AnimationMaskInit();
