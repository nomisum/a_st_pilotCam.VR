// temporary flicker
"camOverlayStatic" cutRsc ["RscStatic", "PLAIN" , 1];

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
