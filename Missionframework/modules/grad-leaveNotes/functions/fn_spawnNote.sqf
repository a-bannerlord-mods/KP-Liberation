params ["_requestedPos", "_requestedDir", "_message", "_handwriting",["_type", "note"]];
_classType = grad_leaveNotes_noteObject;
switch (_type) do {
    	case "note": { };
		case "topSecret": { _classType = "Land_File1_F"};
    	default { };
    };
_note = createVehicle [_classType, _requestedPos, [], 0, "NONE"];
_note setPos _requestedPos;
_note setVectorUp surfaceNormal _requestedPos;
_note setDir _requestedDir;

_note setVariable ["message", _message, true];
_note setVariable ["handwriting", _handwriting, true];
_note setVariable ["type", _type, true];
_note setVariable ["GRAD_leaveNotes_data", [_message,_handwriting,_type], true];

[_note] remoteExec ["GRAD_leaveNotes_fnc_initNote", 0, true];
