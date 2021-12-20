//if (!GRLIB_qualifications_param) exitWith {};

waitUntil {!isNil "GRLIB_qualifications"};
waitUntil {!isNil "save_is_loaded"};
waitUntil {save_is_loaded};

while {true} do {
    
    //qualifications
    private _default_qualifications = [];
    {if ((_x select 0) == "Default") exitWith {_default_qualifications = (_x select 2);}} foreach GRLIB_qualifications;

    if (count _default_qualifications > 0) then {
        private _all_players_uids = [];
        {if ((_x select 0) != "Default") then {_all_players_uids pushback (_x select 0)}} foreach GRLIB_qualifications;

        private _old_count = count GRLIB_qualifications;
        {
            if !(((getPlayerUID _x) in _all_players_uids) || ((getPlayerUID _x) isEqualTo "")) then {
                GRLIB_qualifications pushBack [getPlayerUID _x, name _x, _default_qualifications];
            };
        } foreach (allPlayers - entities "HeadlessClient_F");

        if (_old_count != count GRLIB_qualifications) then {
            publicVariable "GRLIB_qualifications"
        };
    };

    sleep 10;

};
