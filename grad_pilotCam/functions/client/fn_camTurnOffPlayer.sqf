params ["_pipCam", "_pipcamVehicle"];

_pipCam cameraEffect ["terminate","back"];
camDestroy _pipCam;
["renderPIPtarget0"] call BIS_fnc_PIP;
detach _pipcamVehicle;
deleteVehicle _pipcamVehicle;

"cameraOverlay" cutRsc ["Default", "PLAIN"];
