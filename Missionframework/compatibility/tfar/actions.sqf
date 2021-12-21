
if (isClass(configFile >> "CfgPatches" >> "task_force_radio") && KPLIB_Enable_TFAR_compatibility) then {

    set_default_radio_channels = {
        if (isnil TFAR_fnc_activeSwradio && isnil TFAR_fnc_activeLrradio) then {
            hint "You don't have any radio!";
        }
		else 
		{
            // set short-range radio
            if (!isnil TFAR_fnc_activeSwradio) then {
				{
					[(call TFAR_fnc_activeSwradio), _forEachIndex, _x] call TFAR_fnc_setChannelFrequency;
				} forEach KPLIB_TFAR_Default_SR_Channels;
            };
            
            // set long-range radio
            if (!isnil TFAR_fnc_activeLrradio) then {
				{
					[(call TFAR_fnc_activeLrradio), _forEachIndex, _x] call TFAR_fnc_setChannelFrequency;
				} forEach KPLIB_TFAR_Default_LR_Channels;
            };
            
            hint "The radio channels have been set successfully.";
        };
    };

	_this addAction [
    ["<t color='#FFFF00'>", localize "STR_SET_RADIO_CHANNELS_ACTION", "</t>"] joinString "",
    {call set_default_radio_channels;},
    nil,
    -850,
    false,
    true,
    "",
    "
            typeof cursorObject in ['Static_Radio_Black_3']
        &&  cursorObject distance player < 5
    "
];


};
