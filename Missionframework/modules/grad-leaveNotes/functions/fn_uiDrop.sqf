#include "..\dialog\defines.hpp"

disableSerialization;
_dialog = findDisplay LN_DIALOG;
_editBox = _dialog displayCtrl LN_EDITBOX;
_message = ctrlText _editBox;
_handwriting = player getVariable ["GRAD_leaveNotes_handwriting",["",["",""]]];

_note = player getVariable ["GRAD_leaveNotes_activeNote", objNull];
_nodeName = format ["GRAD_leaveNotes_myNotes_%1", _note];
_type= player getVariable [_nodeName + "_type", "note"];
_handwriting = player getVariable [_nodeName + "_handwriting",_handwriting];

[_message, _handwriting,_type] call GRAD_leaveNotes_fnc_dropNote;
player setVariable ["GRAD_leaveNotes_amount", (player getVariable ["GRAD_leaveNotes_amount", 1]) - 1];
