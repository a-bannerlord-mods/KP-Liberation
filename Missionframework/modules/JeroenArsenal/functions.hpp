class JN {
	
	class Test {
		file = "modules\JeroenArsenal\Test";
		class test_init {preinit = 1;};
		class test_recompile {};
		class test_configViewer {};
		class test_debugv2 {postinit = 1;};
	};
	class Common {
		file = "modules\JeroenArsenal\Common";
		class common_addActionSelect {};
		class common_addActionCancel {};
		class common_updateActionCancel {};
		class common_removeActionCancel {};
		class common_getActionCanceled {};
	};
	class Common_Vehicle {
		file = "modules\JeroenArsenal\Common\vehicle";
		class common_vehicle_getSeatNames {};
		class common_vehicle_getVehicleType {};
	};
	class Common_Array {
		file = "modules\JeroenArsenal\Common\array";
		class common_array_add {};
		class common_array_remove {};
	};
	class JNA {
		file = "modules\JeroenArsenal\JNA";
		class arsenal {};
		
		class arsenal_addItem {};
		class arsenal_cargoToArray {};
		class arsenal_arrayToArsenal {};
		class arsenal_cargoToArsenal {};
		class arsenal_container {};
		class arsenal_init {};
		class arsenal_initPersistent {};
		class arsenal_inList {};
		class arsenal_itemCount {};
		class arsenal_itemType {};
		class arsenal_loadInventory {};
		class arsenal_applyInventory {};
		class arsenal_removeItem {};
		class arsenal_requestOpen {};
		class arsenal_requestClose {};
		class arsenal_getEmptyArray {};
		class arsenal_getPrimaryWeapons {};
		class arsenal_getSecondaryWeapons {};
		class arsenal_addInitialArsenalItems {};
		class arsenal_hasItemPermission {};
		class arsenal_addLoadAction {};
		class arsenal_getConfigClass {};
		class arsenal_getCompatibleMagazines {};
		class arsenal_getItemsWithPermission {};
		class arsenal_calculateLoadoutCost	 {};
	};
	
};
