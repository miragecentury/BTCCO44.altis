
// http://forums.bistudio.com/showthread.php?135494-Mathematical-random-pos-in-an-oblique-rectangle

private ["_center","_xx","_yy","_rndPos"];
_center = _this select 0; //center object
_center setDir = _this select 1; //angle
_xx = _this select 2; //x-axis
_yy = _this select 3; //y-axis
_xx = (random _xx) - (0.5 * _xx);
_yy = (random _yy) - (0.5 * _yy);
_rndPos = _center modelToWorld [_xx,_yy,0];
_rndPos; //output

