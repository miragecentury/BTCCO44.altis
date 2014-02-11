ShowCinemaBorder true;
enableRadio false;
1 fademusic 1;

BTC_end_movie = false; publicVariable "BTC_end_movie";
my_bomb = false; publicVariable "my_bomb";
_cam = "camera" camcreate [(getPos actor1 select 0)+50, (getPos actor1 select 1)+50, 20];
_cam cameraeffect ["internal", "back"];
_cam camsettarget actor1;
_cam camsetrelpos [-5,5,2];
_cam camcommit 0;
_nul = [] spawn 
{
	sleep 10;
	Titletext ["After longs years of cold war, the situation in the archipelago of Altis has worsened.","PLAIN DOWN",3];
	sleep 10;
	Titletext ["","PLAIN DOWN"];
	sleep 10;
	Titletext ["NATO troops are invading Stratis to the detriment of Syrian troops ...","PLAIN DOWN",3];
	sleep 10;
	Titletext ["","PLAIN DOWN",3];
	sleep 5;
	Titletext ["War just began!","PLAIN DOWN",3];
	sleep 5;
	Titletext ["","PLAIN DOWN"];
};
sleep 5;
_cam camsettarget actor1;
_cam camsetrelpos [-100,100,30];
_cam camcommit 6;
waitUntil {(camcommitted _cam)};


if !(alive fly1) then {_cam camsettarget fly2;} else {_cam camsettarget fly1;};
//_cam camsetrelpos [100,100,30];
_cam camcommit 5;
waitUntil {(camcommitted _cam)};


_cam camsettarget molo_1;
_cam camcommit 6;
waitUntil {(camcommitted _cam)};

if (!(alive actor3) OR ((getdammage actor3) >= 0.7)) then {_cam camsettarget actor4;} else {_cam camsettarget actor3;};
_cam camsetrelpos [0,70,2];
_cam camcommit 6;
waitUntil {(camcommitted _cam)};


sleep 7;
_cam camsettarget molo;
_cam camsetrelpos [-50,50,15];
_cam camcommit 6;
waitUntil {(camcommitted _cam)};

sleep 7;
_cam camsettarget molo_2;
_cam camsetrelpos [-5,5,10];
_cam camsettarget molo_1;
_cam camcommit 0;
waitUntil {(camcommitted _cam)};


sleep 7;
my_bomb = true; publicVariable "my_bomb";
_cam camsettarget molo_1;
_cam camsetrelpos [-150,0,20];
_cam camcommit 6;
waitUntil {(camcommitted _cam)};

_cam camsettarget molo_2;
_cam camcommit 5;
waitUntil {(camcommitted _cam)};


Titletext ["Airport it's our! Mission it's a success!","PLAIN"];
Titletext ["Airport it's our! Mission it's a success!","BLACK OUT",20];
_nul = [] spawn {sleep 5; cuttext ["Get ready for the 'Sides Patrols', the battle has just began!","PLAIN DOWN"]; };
19 fadeSound 0;
19 fademusic 0;
sleep 20; 
Titletext ["","Black"];
BTC_end_movie = true; publicVariable "BTC_end_movie";
Titletext ["","Black"];
