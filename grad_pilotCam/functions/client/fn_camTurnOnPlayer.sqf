params ["_relPos", "_targetObject", "_area"];

_cam camSetTarget _targetObject;
_cam cameraEffect ["INTERNAL", "BACK"];
_cam camSetFocus [5, 1];
_cam camSetFov 0.5;
_cam camCommit 0;
showCinemaBorder false;

_pipcamVehicle = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_pipcamVehicle setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0)"];

// _pos = getPosATL _area vectorAdd [0, -2, 0.5];
 //this is where I've been trying to make adjustments

_pipcamVehicle setPos _relPos;

_camPos = ([0,0,0]);

_pipcamVehicle attachTo [_targetObject];

_pipcamObject = ["renderPIPtarget0",[[_pipcamVehicle,_camPos],_targetObject],_pipcamVehicle] call BIS_fnc_PIP;
"renderPIPtarget0" setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];
//Larrow's awesome code for resizing pipcam displays:  https://forums.bistudio.com/topic/182321-increasing-bis-fnc-livefeed-display-size/
// [[safezoneX + safezoneW - 0.39, safezoneY + safezoneH - 0.38], 1.8 ] call fnc_resizePIP;


_pipcamObject camSetFocus [5, 1];
_pipcamObject camSetFov 0.5;
_pipcamObject camCommit 0;



_contentConfig = configfile >> "RscTitles" >> "RscPIP" >> "controlsBackground" >> "PIP";
_contentX = getnumber (_contentConfig >> "x");
_contentY = getnumber (_contentConfig >> "y");
_contentW = getnumber (_contentConfig >> "w");
_contentH = getnumber (_contentConfig >> "h");

"cameraOverlay" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable ["RscTitleDisplayEmpty",displayNull];
private _background = _display ctrlCreate ["RscPicture",-1];
_background ctrlSetText "GRAD_pilotCam\data\campic6.paa";
_background ctrlSetPosition [_contentX,_contentY,_contentW, _contentH];
_background ctrlCommit 0;



private _progressBar = findDisplay 46 ctrlCreate ["RscProgress",-1];
_progressBar ctrlSetPosition [_contentX,_contentY + _contentH-_contentH/15,_contentW,_contentH/20];
_progressBar ctrlSetTextColor [1,0,0,1];
_progressBar progressSetPosition 0;
_progressBar ctrlCommit 0;


[{
	params ["_pipcamObject", "_pipcamVehicle", "_camObj"];
	!(_camObj getVariable ["GRAD_pilotCam_camIsOn", false])
},
{
	params ["_pipcamObject", "_pipcamVehicle", "_camObj"];
	[_pipcamObject, _pipcamVehicle] call GRAD_pilotCam_fnc_camTurnOffPlayers;
},
[_pipcamObject, _pipcamVehicle, _camObj]] call CBA_fnc_waitUntilAndExecute;


[{
	params ["_args", "_handle"];
	_args params ["_progressBar"];

	GRAD_pilotCam_RECORDING_DONE = GRAD_pilotCam_RECORDING_DONE + 1;
	_progressBar progressSetPosition (linearConversion [0, GRAD_pilotCam_RECORDING_DURATION, GRAD_pilotCam_RECORDING_DONE, 0, 1, true]);

	if (!(_camObj getVariable ["GRAD_pilotCam_camIsOn", false])) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
		diag_log format ["cam turned off", _area];
		GRAD_pilotCam_RECORDING_DONE = 0;
	};

	if (GRAD_pilotCam_RECORDING_DONE > GRAD_pilotCam_RECORDING_DURATION) exitWith {
		[_handle] call CBA_fnc_removePerFrameHandler;
		diag_log format ["recording done"];
		GRAD_pilotCam_RECORDING_DONE = 0;
	};

}, 1, [_progressBar]] call CBA_fnc_addPerFrameHandler;
