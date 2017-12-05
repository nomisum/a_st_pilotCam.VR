_turnOn = ["CameraOn", "Turn Cam On", "", {
	[_player, _target] remoteExec ["GRAD_pilotCam_fnc_camTurnOnServer", 2];
	_target setVariable ["GRAD_pilotCam_camIsOn", true, true];
},
{!(_target getVariable ["GRAD_pilotCam_camIsOn", false])}] call ace_interact_menu_fnc_createAction;

["Camera1", 0, ["ACE_MainActions"], _turnOn, true] call ace_interact_menu_fnc_addActionToClass;


_turnOff = ["CameraOff", "Turn Cam Off", "", {
	_target setVariable ["GRAD_pilotCam_camIsOn", false, true];
},
{(_target getVariable ["GRAD_pilotCam_camIsOn", false])}] call ace_interact_menu_fnc_createAction;

["Camera1", 0, ["ACE_MainActions"], _turnOff, true] call ace_interact_menu_fnc_addActionToClass;
