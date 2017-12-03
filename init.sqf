call GRAD_pilotCam_fnc_init;

[] remoteExec ["GRAD_pilotCam_fnc_addInteractionToCams", [0,-2] select isDedicated];

GRAD_pilotCam_RECORDING_DURATION = 20;
GRAD_pilotCam_RECORDING_DONE = 0;