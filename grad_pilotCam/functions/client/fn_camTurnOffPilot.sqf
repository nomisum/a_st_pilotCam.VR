params [["_cam", objNull], ["_effectsArray", []]];

_effectsArray params ["_ppcolor", "_ppgrain", "_display", "_background"];

if (!isNil "_ppcolor") then {
	ppEffectDestroy [_ppcolor, _ppgrain];
};
if (!isNull _cam) then {
	_cam cameraEffect ["terminate", "back"];
};

"camOverlayStatic" cutRsc ["RscStatic", "PLAIN" , 1];
"cameraOverlay" cutRsc ["Default", "PLAIN"];

hint "cam turned off for pilot";
