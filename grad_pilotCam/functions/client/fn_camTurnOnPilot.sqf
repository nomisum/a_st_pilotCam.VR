params ["_unit", "_camObj"];

private _area = _camObj getVariable ["GRAD_pilotCam_area", objNull];
private _relPos = _camObj getRelPos [0.2, _camObj getDir _area];
_relPos set [2,1.1];

private _aimPos = _camObj getRelPos [3000, _camObj getDir _area];
private _targetObject = "Sign_Sphere10cm_F" createVehicle _aimPos;
_targetObject setObjectTextureGlobal [0,"#(argb,8,8,3)color(0,0,0,0)"];

// only display this for pilot
if (!(player getVariable ["GRAD_pilotTracking_isPilot",false])) exitWith {
	[_relPos, _targetObject, _area] call GRAD_pilotCam_fnc_camTurnOnPlayers;
};

private _cam = "camera" camCreate _relPos;

diag_log format ["_area %1", _area];
diag_log format ["aimpos %1", _aimPos];
/*
_camVector = getCameraViewDirection cam;
_camNewPos = _camVector vectorMultiply 1.1;
cam setPos _camNewPos;
*/
_cam camSetTarget _aimPos;
_cam cameraEffect ["INTERNAL", "BACK"];
_cam camSetFocus [5, 1];
_cam camSetFov 0.5;
_cam camCommit 0;
showCinemaBorder false;



// black and white
_ppcolor = ppEffectCreate ["colorCorrections", 2005];
_ppcolor ppEffectAdjust [1, 1.7, 0, [1, 1, 1, 0], [1, 1, 1, 0], [0.75, 0.25, 0, 1.0]]; 
_ppcolor ppEffectCommit 0; 
_ppcolor ppEffectEnable TRUE;


// white
_ppgrain = ppEffectCreate ["filmGrain", 2004];
_ppgrain ppEffectAdjust [1, 2.5, 3, 0.5, 1]; 
_ppgrain ppEffectCommit 0; 
_ppgrain ppEffectEnable TRUE;


// camera overlay
"cameraOverlay" cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
private _display = uiNamespace getVariable ["RscTitleDisplayEmpty",displayNull];
private _background = _display ctrlCreate ["RscPicture",-1];
_background ctrlSetText "GRAD_pilotCam\data\campic6.paa";
_background ctrlSetPosition [safezoneX,safezoneY,safeZoneW, safeZoneH];
_background ctrlCommit 0;


disableSerialization;
private _progressBar = findDisplay 46 ctrlCreate ["RscProgress",-1];
_progressBar ctrlSetPosition [safezoneX+0.452*safezoneW,safezoneY+0.725011110*safezoneH,0.10*safezoneW,0.01*safezoneH];
_progressBar ctrlSetTextColor [1,1,1,1];
_progressBar progressSetPosition 0;
_progressBar ctrlCommit 0;

"camOverlayStatic" cutRsc ["RscStatic", "PLAIN" , 1];
[{
	params ["_args", "_handle"];
	_args params ["_cam", "_camObj", "_area", "_ppcolor", "_ppgrain", "_targetObject", "_progressBar"];
	
	private _entities = (position _area) nearEntities 5;
	_pilotInside = false;
	
	{
		if (_x getVariable ["GRAD_pilotTracking_isPilot", false]) exitWith {
			_pilotInside = true;
		};
	} forEach _entities;
	
	if (!_pilotInside) exitWith {
		[_cam, _ppcolor, _ppgrain] call GRAD_pilotCam_fnc_camTurnOff;
		_camObj setVariable ["GRAD_pilotCam_camIsOn", false];
		[_handle] call CBA_fnc_removePerFrameHandler;
		diag_log format ["no pilot inside %1", _area];
		deleteVehicle _targetObject;
	};


	GRAD_pilotCam_RECORDING_DONE = GRAD_pilotCam_RECORDING_DONE + 1;
	_progressBar progressSetPosition (linearConversion [0, GRAD_pilotCam_RECORDING_DURATION, GRAD_pilotCam_RECORDING_DONE, 0, 1, true]);

	if (GRAD_pilotCam_RECORDING_DONE > GRAD_pilotCam_RECORDING_DURATION) exitWith {
		[_cam, _ppcolor, _ppgrain] call GRAD_pilotCam_fnc_camTurnOff;
		_camObj setVariable ["GRAD_pilotCam_camIsOn", false];
		[_handle] call CBA_fnc_removePerFrameHandler;
		diag_log format ["SUCCESS %1", _area];
		deleteVehicle _targetObject;
	};

	
	if (random 2 > 1.9) then {
		missionnamespace setvariable ["RscStatic_mode",selectRandom [0,1]];
		"camOverlayStatic" cutRsc ["RscStatic", "PLAIN" , 1];
	};

}, 1, [_cam, _camObj, _area, _ppcolor, _ppgrain, _targetObject, _progressBar, _progress]] call CBA_fnc_addPerFrameHandler;




/*
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