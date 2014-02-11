///////////////////////////////////////////////////
/// ® March 2013 =BTC= Muttley & =BTC= Giallustio//	
/// Visit us: www.blacktemplars.altervista.org   //
///////////////////////////////////////////////////

class BTC_intro
{
	idd=-1;
	movingEnable = true;
	duration=15; // Fade Duration
	fadein=1; // Fade Time
	name = "BTC_intro"; // Name in Editor
	controls[]={Picture};
	class Picture : BTC_RscPicture
	{
		x = 0.37; // X-Axis
		y = 0; // Y-Axis
		w = 0.25; //WindowWidth
		h = 0.40; //Window Height
		text = "=BTC=_logo.paa"; // Graphic Direction
		sizeEx = 0.04;
		style = 48;
	};
};