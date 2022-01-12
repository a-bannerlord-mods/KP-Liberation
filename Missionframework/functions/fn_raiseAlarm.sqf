params [
	"_fob",
	["_sound","Sound_AirRaidSiren"]
];
_fob_key = format ["%1_%2_%3_Alarms", ceil(_fob select 0),ceil(_fob select 1),ceil(_fob select 2)];
_alarms = missionNamespace getVariable [_fob_key, []];
{ 
	_alarms pushBackUnique( createSoundSource [_sound, position _x, [], 0]); 
} forEach (_fob nearObjects  [KPLIB_alarm_speaker,800]); 

_alarms = missionNamespace setVariable [_fob_key, _alarms ,true];