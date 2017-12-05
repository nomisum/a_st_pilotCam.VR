disableSerialization;
// get size of pip display
private _contentConfig = configfile >> "RscTitles" >> "RscPIP" >> "controlsBackground" >> "PIP";
private _contentX = getnumber (_contentConfig >> "x");
private _contentY = getnumber (_contentConfig >> "y");
private _contentW = getnumber (_contentConfig >> "w");
private _contentH = getnumber (_contentConfig >> "h");

// progressBar in PiP
private _progressBar = findDisplay 46 ctrlCreate ["RscProgress",-1];
_progressBar ctrlSetPosition [_contentX,_contentY + _contentH-_contentH/15,_contentW,_contentH/20];
_progressBar ctrlSetTextColor [1,0,0,1];
_progressBar progressSetPosition 0;
_progressBar ctrlCommit 0;

_progressBar
