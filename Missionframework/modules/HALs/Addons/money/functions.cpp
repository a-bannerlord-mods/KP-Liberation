class HALs_money {
	class Init {
		file = "modules\HALs\Addons\money\functions";
		class initModule {postInit = 1;};
	};
	
	class Client {
		file = "modules\HALs\Addons\money\functions\client";
		class initClient {};
	};
	
	class Server {
		file = "modules\HALs\Addons\money\functions\server";
		class addFunds {};
		class getFunds {};
		class initServer {};
	};
};
