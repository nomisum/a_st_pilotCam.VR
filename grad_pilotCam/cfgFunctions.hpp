class GRAD_pilotCam {

	class client {
		file = grad_pilotCam\functions\client;

		class addInteractionToCams;
		class camTurnOffPilot;
		class camTurnOffPlayer;
		class camTurnOnPilot;
		class camTurnOnPlayer;
		class createCameraEffectsPilot;
		class createProgressBarPilot;
		class createProgressBarPlayer;

		class init { preInit = 1; };
	};

	class server {
		file = grad_pilotCam\functions\server;

		class turnCamOnServer;
	};
};
