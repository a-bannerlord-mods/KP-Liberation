#define PREFIX grad
#define COMPONENT leaveNotes
#include "\x\cba\addons\main\script_macros_mission.hpp"
#include "..\dialog\defines.hpp"

params [["_mode", "UNDEFINED"],"_note","_message","_handwriting",["_type", "note"]];

disableSerialization;

switch (_mode) do {
  case "WRITE": {
    createDialog "GRAD_leaveNotes_write";
    _dialog = findDisplay LN_DIALOG;
    _notepad = _dialog displayCtrl LN_NOTEPAD;
    _editBox = _dialog displayCtrl LN_EDITBOX;
    switch (_type) do {
      case "note": { _notepad ctrlSetText (GRAD_leaveNotes_moduleRoot + "\data\notepad.paa");};
      case "topSecret": { _notepad ctrlSetText (GRAD_leaveNotes_moduleRoot + "\data\topSecret.paa");};
      default {_notepad ctrlSetText (GRAD_leaveNotes_moduleRoot + "\data\notepad.paa"); };
    };
    

    if (GRAD_leaveNotes_visibleHandwriting) then {
        _handwriting = player getVariable ["GRAD_leaveNotes_handwriting", ["",["","TahomaB"]]];
        _handwriting params ["_modifier", "_type"];
        _editBox ctrlSetFont (_type select 1);
    };
  };

  case "READ": {
    createDialog "GRAD_leaveNotes_read";
    _dialog = findDisplay LN_DIALOG;
    _notepad = _dialog displayCtrl LN_NOTEPAD;
    switch (_type) do {
      case "note": { _notepad ctrlSetText (GRAD_leaveNotes_moduleRoot + "\data\notepad.paa");};
      case "topSecret": { _notepad ctrlSetText (GRAD_leaveNotes_moduleRoot + "\data\topSecret.paa");};
      default {_notepad ctrlSetText (GRAD_leaveNotes_moduleRoot + "\data\notepad.paa"); };
    };
    _textBox = _dialog displayCtrl LN_TEXTBOX;
    _button2 = _dialog displayCtrl LN_BUTTON2;
    _button3 = _dialog displayCtrl LN_BUTTON3;
    //_message = "";
    //_note = player getVariable ["GRAD_leaveNotes_activeNote", objNull];

    

    if (typeName _note == "OBJECT") then {
        _button2 ctrlSetText "TAKE";
    };

    if (typeName _note == "SCALAR") then {
        _nodeName = format ["GRAD_leaveNotes_myNotes_%1", _note];
        if (_message=="") then {
         _message =  player getVariable [_nodeName + "_message", ""];
         };
        _button2 ctrlSetText "DROP";
    };

    if !(player getVariable ["GRAD_leaveNotes_canInspect", GRAD_leaveNotes_canInspectDefault]) then {
        _button3 ctrlShow false;
    };

    if (GRAD_leaveNotes_visibleHandwriting) then {
        _handwriting params ["_modifier", "_type"];
        _textBox ctrlSetFont (_type select 1);
    };

    _textBox ctrlSetText _message;

  };

  default {ERROR(format ["%1 is not a valid mode.", _mode])};
};
