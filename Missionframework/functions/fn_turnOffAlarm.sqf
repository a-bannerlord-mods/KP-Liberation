params [
	"_fob"
];

_fob_key = format ["%1_%2_%3_Alarms", ceil(_fob select 0),ceil(_fob select 1),ceil(_fob select 2)];
_alarms = missionNamespace getVariable [_fob_key, []];

{
	deleteVehicle _x;
}forEach _alarms