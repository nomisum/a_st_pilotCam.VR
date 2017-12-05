params ["_camObj", "_relPos", "_targetObject", "_area"];


_pipcamVehicle = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_pipcamVehicle setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0)"];
_pipcamVehicle setPos _relPos;
_pipcamVehicle attachTo [_targetObject];

_camPos = ([0,0,0]);

_pipcamObject = ["renderPIPtarget0",[[_pipcamVehicle,_camPos],_targetObject],_pipcamVehicle] call BIS_fnc_PIP;
"renderPIPtarget0" setPiPEffect [3,1,1,0.4,0,[0,0,0,0],[1,1,1,0],[1,1,1,1]];

// zoom pip object to same levels as original cam
_pipcamObject camSetFocus [5, 1];
_pipcamObject camSetFov 0.5;
_pipcamObject camCommit 0;

[] call GRAD_pilotCam_fnc_createProgressBarPlayer;

// camera recording UI in PiP
"cameraOverlay" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable ["RscTitleDisplayEmpty",displayNull];
private _background = _display ctrlCreate ["RscPicture",-1];
_background ctrlSetText "GRAD_pilotCam\data\campic6.paa";
_background ctrlSetPosition [_contentX,_contentY,_contentW, _contentH];
_background ctrlCommit 0;


// loop progress and abort if necessary
[{
	params ["_args", "_handle"];
	_args params ["_camObj", "_pipcamObject", "_pipcamVehicle", "_progressBar"];

	_progressBar progressSetPosition (linearConversion [0, GRAD_pilotCam_RECORDING_DURATION, GRAD_pilotCam_RECORDING_DONE, 0, 1, true]);

	if (!(_camObj getVariable ["GRAD_pilotCam_camIsOn", false])) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
			[_pipcamObject, _pipcamVehicle] call GRAD_pilotCam_fnc_camTurnOffPlayer;
	};

}, 1, [_camObj, _pipcamObject, _pipcamVehicle, _progressBar]] call CBA_fnc_addPerFrameHandler;
