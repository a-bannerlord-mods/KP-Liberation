/*
Extends fn_arsenal_init.
initializes the arsenal persistently, handles generation of a unique JIP ID string.
Must run on the server.

Author: Sparker
*/


#define __JIpiD(ID) format ["jna_init_%1", ID]

if (!isServer) exitwith {};
//load_content_from_section = compile preprocessFile "scripts\database\fn_load_content_from_section.sqf";

params [["_object", objNull, [objNull]], ["_initialValue", []], ["_arsenalname", ""]];

// Bail if a null object is passed (why??)
if (isNull _object) exitwith {};

// if (_arsenalname!= "") then {
//     _object setVariable ["jna_name", _arsenalname, true];
    
//     private _inidbi = ["new", _arsenalname] call OO_inIDBI;
//     private _fileExist = "exists" call _inidbi;
    
//     if (_fileExist) then {
     
//         _contentstr = [_inidbi, "content"] call load_content_from_section;
//         if (_contentstr!="") then {
//             _initialValue = parseSimpleArray _contentstr;
//         };
//     };
// } else {
    _object setVariable ["jna_name", "", true];
//};

// set initial arsenal item array value
if (count _initialValue > 0) then {
    _object setVariable ["jna_datalist", _initialValue];
};

// Generate a JIP ID
private _ID = 0;
if (isnil "jna_nextID") then {
    jna_nextID = 0;
    _ID = 0;
} else {
    _ID = jna_nextID;
};
jna_nextID = jna_nextID + 1;

private _JIpiD = __JIpiD(_ID);
_object setVariable ["jna_id", _ID];
[_object] remoteExecCall ["jn_fnc_arsenal_init", 0, _JIpiD];
// execute globally, add to the JIP queue

// Add an event handler to delete the init from the JIP queue when the object is gone
_object addEventHandler ["Deleted", {
    params ["_entity"];
    private _ID = _entity getVariable "jna_id";
    if (isnil "_ID") exitwith {
        diag_log format ["JNA arsenal_initPersistent: error: no JIP ID for object %1", _entity];
    };
    private _JIpiD = __JIpiD(_ID);
    remoteExecCall ["", _JIpiD];
    // Remove it from the queue
}];