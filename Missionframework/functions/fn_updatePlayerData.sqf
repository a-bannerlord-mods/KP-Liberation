
/*
    [player] call KPLIB_fnc_updatePlayerData;
    File: fn_updatePlayerData.sqf
    Author: Ahmed Salah 
    Date: 2019-12-03
    Last Update: 2020-04-05
    License: MIT License - http://www.opensource.org/licenses/MIT

    Description:
        Save Player Data to GRLIB_players_data

    Parameter(s):
        _player  - Player  [OBJECT, defaults to objNull]

    Returns:
        Nothing
*/
params ["_player"];
if (!((name _player) in ["HC0","HC1", "HC2", "HC3", "HC4", "HC5"])) then { 
		_playerUID = getPlayerUID _player; 

		_data = [getPosATL _player, [_player] call KPLIB_fnc_getLoadout,[]]; 

		private _displayname = ""; 
		_all_players_uids =[]; 
		if(count (squadParams _player) != 0) then { 
			_displayname = "[" + ((squadParams _player select 0) select 0) + "] "; 
		}; 
		_displayname = _displayname + name _player; 

		{_all_players_uids pushback (_x select 0)} foreach GRLIB_players_data; 

		if (_playerUID in _all_players_uids) then { 
			_index = _all_players_uids find  _playerUID; 
			GRLIB_players_data set [_index, [_playerUID, _displayname, _data]]; 
		} else { 
			GRLIB_players_data pushback [_playerUID, _displayname, _data]; 
		}; 
}; 
