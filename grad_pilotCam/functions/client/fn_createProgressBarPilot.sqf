disableSerialization;
private _progressBar = findDisplay 46 ctrlCreate ["RscProgress",-1];
_progressBar ctrlSetPosition [safezoneX+0.452*safezoneW,safezoneY+0.725011110*safezoneH,0.10*safezoneW,0.01*safezoneH];
_progressBar ctrlSetTextColor [1,1,1,1];
_progressBar progressSetPosition 0;
_progressBar ctrlCommit 0;
