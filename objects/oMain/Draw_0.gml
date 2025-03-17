/// @description Draw the animation
// Increase time
time += 1 / (game_get_speed(gamespeed_fps) * optionSeconds);
if (time > 1) time --;

// Calculate time curve
var frames = 1 / (optionFPS * optionSeconds);
var prog = Ease(optionTimeCurve, time);
var t = (prog / frames - frac(prog / frames) + 1) * frames;

// Draw the animation
AnimationMaskDraw(x, y, spr, mask, ramp, t, 4);
