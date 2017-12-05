params ["_camObj", "_relPos", "_targetObject", "_area"];

private _cam = "camera" camCreate _relPos;

_cam camSetTarget _targetObject;
_cam cameraEffect ["INTERNAL", "BACK"];
_cam camSetFocus [5, 1];
_cam camSetFov 0.5;
_cam camCommit 0;
showCinemaBorder false;

private _effectsArray = call GRAD_pilotCam_fnc_createCameraEffectsPilot;
private _progressBar = call GRAD_pilotCam_fnc_createProgressBarPilot;

[{
	params ["_args", "_handle"];
	_args params ["_camObj", "_cam", "_effectsArray", "_progressBar"];

	_progressBar progressSetPosition (linearConversion [0, GRAD_pilotCam_RECORDING_DURATION, GRAD_pilotCam_RECORDING_DONE, 0, 1, true]);

	if (!(_camObj getVariable ["GRAD_pilotCam_camIsOn", false])) then {
			[_handle] call CBA_fnc_removePerFrameHandler;
			[_cam, _effectsArray] call GRAD_pilotCam_fnc_camTurnOffPilot;
	};

	if (random 2 > 1.9) then {
			missionnamespace setvariable ["RscStatic_mode",selectRandom [0,1]];
			"camOverlayStatic" cutRsc ["RscStatic", "PLAIN" , 1];
	};

}, 1, [_camObj, _cam, _effectsArray, _progressBar]] call CBA_fnc_addPerFrameHandler;




/*
	// lights

	dummyLightRight = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	dummyLightRight attachTo [this,[0.43,-0.18,1]]; dummyLightLeft = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	dummyLightLeft attachTo [this,[-0.43,-0.18,1]];

	lightLeft = "#lightpoint" createVehicleLocal [0,0,0];
	lightLeft setLightBrightness 0.2;
	lightLeft setLightColor [1,1,1];
	lightLeft setLightUseFlare true;
	lightLeft setLightFlareMaxDistance 1000;
	lightLeft setLightFlareSize 15;
	lightLeft lightAttachObject [dummyLightLeft, [0,0,0]];

	lightRight = "#lightpoint" createVehicleLocal [0,0,0];
	lightRight setLightBrightness 0.2;
	lightRight setLightColor [1,1,1];
	lightRight setLightUseFlare true;
	lightRight setLightFlareMaxDistance 1000;
	lightRight setLightFlareSize 15;
	lightRight lightAttachObject [dummyLightRight, [0,0,0]];
*/
