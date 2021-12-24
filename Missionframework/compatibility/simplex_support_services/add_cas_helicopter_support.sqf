params[
    ["_vehicle", objNull, [objNull]], ["_callsign", "", [""]], ["_respawnTime", 60, [0]], ["_customInit", {},
        [{}, ""]
    ], ["_accessItems", [],
        [
            []
        ]
    ], ["_accessCondition", {
            true
        },
        [{}, ""]
    ], ["_requestCondition", {
            true
        },
        [{}, ""]
    ]
];


if (_callsign isEqualTo "") then {
    _callsign = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
};

if (_customInit isEqualType "") then {
    _customInit = compile _customInit;
};

if (_accessCondition isEqualType "") then {
    _accessCondition = compile _accessCondition;
};

if (_requestCondition isEqualType "") then {
    _requestCondition = compile _requestCondition;
};

if (!isNull(_vehicle getVariable["SSS_parentEntity", objNull])) exitWith {
    private _logMessage = format["SSS - %1", format["Error: %1", format["Vehicle is already a support: %1 (%2)", _callsign, _vehicle]]];
    diag_log _logMessage;
    systemChat _logMessage;
    objNull
};

if ({
        isPlayer _x
    }
    count crew _vehicle > 0) exitWith {
    private _logMessage = format["SSS - %1", format["Error: %1", format["No players allowed: %1 (%2)", _callsign, _vehicle]]];
    diag_log _logMessage;
    systemChat _logMessage;
    objNull
};

if (!alive driver _vehicle) exitWith {
    private _logMessage = format["SSS - %1", format["Error: %1", format["No driver in vehicle: %1 (%2)", _callsign, _vehicle]]];
    diag_log _logMessage;
    systemChat _logMessage;
    objNull
};

if (!isServer) exitWith {
    _this remoteExecCall["SSS_support_fnc_addCASHelicopter", 2];
    objNull
};


private _entity = true call CBA_fnc_createNamespace;
private _group = group _vehicle;
private _side = side _group;

_entity setVariable["SSS_classname", typeOf _vehicle, true];
_entity setVariable["SSS_callsign", _callsign, true];
_entity setVariable["SSS_side", _side, true];
_entity setVariable["SSS_icon", "z\SSS\addons\main\ui\icons\heli.paa", true];
_entity setVariable["SSS_iconYellow", ["z\SSS\addons\main\ui\icons\heli.paa", "#f5ca00"], true];
_entity setVariable["SSS_iconGreen", ["z\SSS\addons\main\ui\icons\heli.paa", "#20ca24"], true];
_entity setVariable["SSS_customInit", _customInit, true];
_entity setVariable["SSS_service", "CAS", true];
_entity setVariable["SSS_supportType", "CASHelicopter", true];
_entity setVariable["SSS_accessItems", _accessItems apply {
    toLower _x
}, true];
_entity setVariable["SSS_accessCondition", _accessCondition, true];
_entity setVariable["SSS_requestCondition", _requestCondition, true];
_vehicle setVariable["SSS_parentEntity", _entity, true];
_entity setVariable["SSS_vehicle", _vehicle, true];
_entity setVariable["SSS_base", getPosASL _vehicle, true];
_entity setVariable["SSS_baseDir", getDirVisual _vehicle, true];
_entity setVariable["SSS_respawnDir", getDir _vehicle, true];
_entity setVariable["SSS_respawnTime", _respawnTime, true];
_entity setVariable["SSS_respawning", false, true];
_group setVariable["SSS_protectWaypoints", true, true];
[_entity, _callsign, "mil_end", "CAS"] call SSS_common_fnc_createMarker;


_entity setVariable["SSS_awayFromBase", false, true];
_entity setVariable["SSS_onTask", false, true];
_entity setVariable["SSS_interrupt", false, true];
_entity setVariable["SSS_flyingHeight", 180, true];
_entity setVariable["SSS_lightsOn", isLightOn _vehicle, true];
_entity setVariable["SSS_collisionLightsOn", isCollisionLightOn _vehicle, true];


SSS_entities pushBack _entity;
publicVariable "SSS_entities";


[_entity, "Deleted", {
    _this call SSS_common_fnc_deletedEntity
}] call CBA_fnc_addBISEventHandler;
[_vehicle, "Deleted", {
    _this call SSS_common_fnc_deletedVehicle
}] call CBA_fnc_addBISEventHandler;

[_vehicle, "Killed", {
    _entity = _this;
    if (!isNil {
            _entity getVariable "SSS_parentEntity"
        }) then {
        _entity = _entity getVariable "SSS_parentEntity";
    };

    private _service = _entity getVariable "SSS_service";
    if (isNil "_service") exitWith {};

    SSS_entities deleteAt(SSS_entities find _entity);
    publicVariable "SSS_entities";

    deleteMarker(_entity getVariable "SSS_marker");
    _entity setVariable["SSS_respawnTime", -1, true];
}] remoteExecCall["CBA_fnc_addBISEventHandler", 0];

[driver _vehicle, "Killed", {
    _entity = _this;
    if (!isNil {
            _entity getVariable "SSS_parentEntity"
        }) then {
        _entity = _entity getVariable "SSS_parentEntity";
    };

    private _service = _entity getVariable "SSS_service";
    if (isNil "_service") exitWith {};

    SSS_entities deleteAt(SSS_entities find _entity);
    publicVariable "SSS_entities";

    deleteMarker(_entity getVariable "SSS_marker");
    _entity setVariable["SSS_respawnTime", -1, true];

}] remoteExecCall["CBA_fnc_addBISEventHandler", 0];

[_vehicle, "GetOut", {
    params["_vehicle", "_role"];
    _entity = _this;
    if (!isNil {
            _entity getVariable "SSS_parentEntity"
        }) then {
        _entity = _entity getVariable "SSS_parentEntity";
    };

    private _service = _entity getVariable "SSS_service";
    if (isNil "_service") exitWith {};

    SSS_entities deleteAt(SSS_entities find _entity);
    publicVariable "SSS_entities";

    deleteMarker(_entity getVariable "SSS_marker");
    _entity setVariable["SSS_respawnTime", -1, true];

}] call CBA_fnc_addBISEventHandler;


[_entity, _vehicle] call SSS_common_fnc_commission;


_vehicle call _customInit;

_entity