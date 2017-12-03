params ["_cam", "_pipcamVehicle"];

_cam cameraEffect ["terminate","back"];
camDestroy _cam;
["renderPIPtarget0"] call BIS_fnc_PIP;
detach _pipcamVehicle;
deleteVehicle _pipcamVehicle;

"cameraOverlay" cutRsc ["Default", "PLAIN"];