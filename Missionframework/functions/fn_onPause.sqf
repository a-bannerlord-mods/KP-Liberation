/*
    File: fn_onPause.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2020-04-13
    Last Update: 2020-04-13
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Handle opening the pause menu via ESC key.

    Parameter(s):
        _display - main display

    Returns:
        Function reached the end [BOOL]
*/
// [_display] call KPLIB_fnc_onPause;

isNil {
    params ["_display"];
    //HELP
        private _ctrlButtonAbort = _display displayCtrl 122;
        _ctrlButtonAbort ctrlSetText "LIBERATION HELP";
        _ctrlButtonAbort ctrlSetTooltip "";

        _ctrlButtonAbort ctrlSetEventHandler ["ButtonClick", "
            params ['_control'];
            ctrlParent _control closeDisplay 2;
            howtoplay = 1;
            true
        "];

    //RESPAWN
    //if (GRLIB_replaceRespawnButtonWithRedeploy)then{
        private _ctrlButtonAbort = _display displayCtrl 1010;
        _ctrlButtonAbort ctrlSetText "REDEPLOY";
        _ctrlButtonAbort ctrlSetTooltip "Redeploy into another FOB";

        _ctrlButtonAbort ctrlSetEventHandler ["ButtonClick", "
            params ['_control'];
            ctrlParent _control closeDisplay 2;
            if(
                player getVariable ['KPLIB_fobDist', 99999] < 20
                || {player getVariable ['KPLIB_isNearMobRespawn', false]}
                || {player getVariable ['KPLIB_isNearStart', false]}
            )then{
                GRLIB_force_redeploy = true;
            }else{
                hint 'You may only redeploy near base or FOB or Mobile Respawn';
            };
            true
        "];
    //};
    //SAVE
    //if (GRLIB_enableSaveLocation || GRLIB_enableSaveLoadout) then {
         //SAVE Player
            private _ctrlButtonAbort = _display displayCtrl 103;
            _ctrlButtonAbort ctrlSetText "SAVE PLAYER";
            _ctrlButtonAbort ctrlSetTooltip "Save player into server";
            _ctrlButtonAbort ctrlEnable true;
            _ctrlButtonAbort ctrlSetEventHandler ["ButtonClick", "
                params ['_control'];
                ctrlParent _control closeDisplay 2;
                [player] remoteExec ['KPLIB_fnc_updatePlayerData', 2];
                rue
            "];
    //};
    
    
    
};

true
