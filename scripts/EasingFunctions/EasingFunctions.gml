enum ANIM_CURVE {
	LINEAR,
	IN_QUAD,
	OUT_QUAD,
	IN_OUT_QUAD,
	IN_CUBIC,
	OUT_CUBIC,
	IN_OUT_CUBIC,
	IN_QUART,
	OUT_QUART,
	IN_OUT_QUART,
	IN_QUINT,
	OUT_QUINT,
	IN_OUT_QUINT,
	IN_SINE,
	OUT_SINE,
	IN_OUT_SINE,
	IN_CIRC,
	OUT_CIRC,
	IN_OUT_CIRC,
	IN_EXPO,
	OUT_EXPO,
	IN_OUT_EXPO,
	IN_ELASTIC,
	OUT_ELASTIC,
	IN_OUT_ELASTIC,
	IN_BACK,
	OUT_BACK,
	IN_OUT_BACK,
	IN_BOUNCE,
	OUT_BOUNCE,
	IN_OUT_BOUNCE,
};

/// @function		Ease(type, time);
/// @param {Real} type	The ease function name.
/// @param {Real} time	The time.
/// @description	Calculates easing animations based on the curve.
function Ease(type, time) {
	// Clamp time to range
	time = clamp(time, 0, 1);
	
	// Select curve
	var p, s;
	switch (type) {
		case ANIM_CURVE.LINEAR:
			return time;
		case ANIM_CURVE.IN_QUAD:
			return sqr(time);
		case ANIM_CURVE.OUT_QUAD:
			return -time * (time - 2);
		case ANIM_CURVE.IN_OUT_QUAD:
			time *= 2;
			
			if (time < 1) {
				return 0.5 * sqr(time);
			} else {
				return -0.5 * (--time * (time - 2) - 1);
			}
		case ANIM_CURVE.IN_CUBIC:
			return power(time, 3);
		case ANIM_CURVE.OUT_CUBIC:
			return power(time - 1, 3) + 1;
		case ANIM_CURVE.IN_OUT_CUBIC:
			time *= 2;
			
			if (time < 1) {
				return 0.5 * power(time, 3);
			} else {
				return 0.5 * (power(time - 2, 3) + 2);
			}
		case ANIM_CURVE.IN_QUART:
			return power(time, 4);
		case ANIM_CURVE.OUT_QUART:
			return -(power(time - 1, 4) - 1);
		case ANIM_CURVE.IN_OUT_QUART:
			time *= 2;
			
			if (time < 1) {
				return 0.5 * power(time, 4);
			} else {
				return 0.5 * -(power(time - 2, 4) - 2);
			}
		case ANIM_CURVE.IN_QUINT:
			return power(time, 5);
		case ANIM_CURVE.OUT_QUINT:
			return power(time - 1, 5) + 1;
		case ANIM_CURVE.IN_OUT_QUINT:
			time *= 2;
			
			if (time < 1) {
				return 0.5 * power(time, 5);
			} else {
				return 0.5 * (power(time - 2, 5) + 2);
			}
		case ANIM_CURVE.IN_SINE:
			return (1 - cos(time * (pi / 2)));
		case ANIM_CURVE.OUT_SINE:
			return sin(time * (pi / 2));
		case ANIM_CURVE.IN_OUT_SINE:
			return 0.5 * (1 - cos(pi * time));
		case ANIM_CURVE.IN_CIRC:
			return 1 - sqrt(1 - sqr(time));
		case ANIM_CURVE.OUT_CIRC:
			time --;
			return sqrt(1 - sqr(time));
		case ANIM_CURVE.IN_OUT_CIRC:
			time *= 2;
			
			if (time < 1) {
				return 0.5 * (1 - sqrt(1 - sqr(time)));
			} else {	
				time -= 2;
				return 0.5 * (sqrt(abs(1 - sqr(time))) + 1);
			}
		case ANIM_CURVE.IN_EXPO:
			return power(2, 10 * (time - 1));
		case ANIM_CURVE.OUT_EXPO:
			return (-power(2, -10 * time) + 1);
		case ANIM_CURVE.IN_OUT_EXPO:
			time *= 2;
			
			if (time < 1) {
				return 0.5 * power(2, 10 * --time);
			} else {
				return 0.5 * (-power(2, -10 * --time) + 2);
			}
		case ANIM_CURVE.IN_ELASTIC:
			p = 0.3;
			s = p / (2 * pi) * arcsin(1);
			
			return -(power(2,10 * (--time)) * sin((time * 1 - s) * (2 * pi) / p));
		case ANIM_CURVE.OUT_ELASTIC:
			p = 0.3;
			s = p / (2 * pi) * arcsin(1);
			
			return power(2, -10 * time) * sin((time * 1 - s) * (2 * pi) / p) + 1;
		case ANIM_CURVE.IN_OUT_ELASTIC:
			if (time < 0.5) {
				return (Ease(ANIM_CURVE.IN_ELASTIC, time * 2) * 0.5);
			} else {
				return (Ease(ANIM_CURVE.OUT_ELASTIC, time * 2 - 1) * 0.5 + 0.5);
			}
		case ANIM_CURVE.IN_BACK:
			s = 1.70158;
			
			return sqr(time) * ((s + 1) * time - s);
		case ANIM_CURVE.OUT_BACK:
			s = 1.70158;
			time --;
			
			return sqr(time) * ((s + 1) * time + s) + 1;
		case ANIM_CURVE.IN_OUT_BACK:
			s = 1.70158;
			time *= 2;
			
			if (time < 1) {
				s *= 1.525;
				return 0.5 * (sqr(time) * ((s + 1) * time - s));
			} else {
				time -= 2;
				s *= 1.525;
				return 0.5 * (sqr(time) * ((s + 1) * time + s) + 2);
			}
		case ANIM_CURVE.IN_BOUNCE:
			return 1 - Ease(ANIM_CURVE.OUT_BOUNCE, 1 - time);
		case ANIM_CURVE.OUT_BOUNCE:
			if (time < 1 / 2.75) {
				return 7.5625 * sqr(time);
			} else if (time < 2 / 2.75)	{
				time -= 1.5 / 2.75;
				return (7.5625 * sqr(time) + 0.75);
			} else if (time < 2.5 / 2.75) {
				time -= 2.25 / 2.75;
				return (7.5625 * sqr(time) + 0.9375);
			} else {
				time -= 2.625 / 2.75;
				return (7.5625 * sqr(time) + 0.984375);
			}
		case ANIM_CURVE.IN_OUT_BOUNCE:
			if (time < 0.5) {
				return Ease(ANIM_CURVE.IN_BOUNCE, time * 2) * 0.5;
			} else {
				return Ease(ANIM_CURVE.OUT_BOUNCE, time * 2 - 1) * 0.5 + 0.5;
			}
	}
};
