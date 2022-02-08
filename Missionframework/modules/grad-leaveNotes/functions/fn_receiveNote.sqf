params ["_target", "_caller", "_message", "_handwriting",["_type", "note"], ["_hint",""]];

if (player != _target) exitWith {};
if (_hint=="") then {
	hint format ["You have received a note from %1.", name _caller];
} else {
	hint format [_hint, name _caller];
};

[(player getVariable ["GRAD_leaveNotes_notesHandled", 0]) + 1,"add", _message, _handwriting,_type] call GRAD_leaveNotes_fnc_updateMyNotes;
