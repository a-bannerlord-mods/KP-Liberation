if (isClass(configFile >> "CfgPatches" >> "task_force_radio") && KPLIB_Enable_TFAR_compatibility) exitwith {
[["tfar_radioSetter_", (KPLIB_TFAR_Set_Default_Channels_Device select 1)]]
};

[]