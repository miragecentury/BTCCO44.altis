sleep 7;
if !(isDedicated) then {
enableRadio false;
ShowCinemaBorder true;
0 fadeSound 0;
0 fademusic 1;

private ["_cam"];
_cam = "camera" camCreate [(position player select 0)+50, (position player select 1) + 200, 60];
_cam camSetTarget player;
_cam cameraEffect ["internal", "BACK"];
_cam camCommit 0;
titleText ["", "BLACK IN"];
sleep 2;
_cam camSetPos [(position player select 0)-200, (position player select 1) + 200, 40];
sleep 5;
_cam camCommit 30;
playMusic "Track02_SolarPower";
sleep 3;
cutRsc ["BTC_intro","PLAIN",1];
Titletext ["=BLACK TEMPLARS CLAN= IS PROUD TO PRESENT...","plain",3];
sleep 5;
Titletext ["-SIDES PATROLS-","plain",6];
sleep 7;
Titletext ["BY AN IDEA OF =BTC= 'MUTTLEY'","plain",3];
sleep 3;
Titletext ["A MP COOP MISSION FOR ARMA 3","plain",3];

_cam camSetPos [(position player select 0)- 100, (position player select 1) + 100, 80];
_cam camcommit 5;
sleep 5;
Titletext ["","plain",3];

titleText ["", "BLACK OUT",3];
sleep 3;
_cam cameraeffect ["terminate", "back"];
camdestroy _cam;
titleText ["Get ready!", "BLACK IN",3];

1 fadeSound 1;
10 fademusic 0;

sleep 5;
[str ("WELCOME SOLDIER"),str (ProfileName)] spawn BIS_fnc_infoText;
sleep 5;
[str ("Visit us:"),str ("www.blacktemplars.altervista.org")] spawn BIS_fnc_infoText;
sleep 5;
enableRadio true;
BTC_intro_fnsh = true; publicVariable "BTC_intro_fnsh";
};






