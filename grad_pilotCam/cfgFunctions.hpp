class GRAD_pilotCam {

	class client {
		file = grad_pilotCam\functions\client;

		class addInteractionToCams;
		class camTurnOnPilot;
		class camTurnOnPlayers;
		class camTurnOffPilot;
		class camTurnOffPlayers;

		class init { preInit = 1; };
	};

	class server {
		file = grad_pilotCam\functions\server;

		class handleProgress;

	};
};