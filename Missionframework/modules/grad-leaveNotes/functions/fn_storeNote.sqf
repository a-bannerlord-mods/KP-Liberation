params ["_target", "_caller", "_args"];
_args params ["_noteID", "_message", "_handwriting",["_type", "note"]];



_stored_docs = _target getVariable ["GRAD_leaveNotes_stored_notes",[]];
_stored_docs pushBack [_message, _handwriting,_type];
_target setVariable ["GRAD_leaveNotes_stored_notes",_stored_docs,true];

[_noteID, "remove", _message, _handwriting,_type] call GRAD_leaveNotes_fnc_updateMyNotes;

// [_target, _caller, _message, _handwriting,_type] remoteExec ["GRAD_leaveNotes_fnc_receiveNote",0,false];

[] call GRAD_leaveNotes_fnc_playGiveAnimation;
