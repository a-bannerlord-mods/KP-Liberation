rhs_fnc_drawSymbol = {
    private["_object", "_labels", "_type", "_symbol", "_variant"];
    
    if (3 <= count _this) then {
        _object = _this select 0;
        _labels = _this select 1;
        _type = _this select 2;
        
        if !(_object getVariable["RHS_Decal_Symbol_Enabled", true]) exitwith {};
        
        private["_getindex", "_idx", "_dkv", "_i"];
        
        _getindex = compile(
        preprocessFileLineNumbers format[
            "\%1\Data\Labels\%2\index.sqf",
            RHSDecalsmodul,
            _type
        ]
        );
        
        _idx = [] call _getindex;
        if (4 == count _this) then {
            _symbol = _this select 3;
            if ("ARRAY" == typeName _symbol) then {
                _variant = _symbol select 1;
                _symbol = _symbol select 0;
                _dkv = _idx param[_symbol, ["empty"], [1, []]];
                _dkv = _dkv select _variant;
            } else {
                _dkv = _idx param[_symbol, [
                    ["empty"]
                ], [1, []]];
                if (1 < count _dkv) then {
                    _dkv = selectRandom _dkv;
                } else {
                    _dkv = _dkv select 0;
                };
            };
        } else {
            _dkv = selectRandom _idx;
            if (1 < count _dkv) then {
                _dkv = selectRandom _dkv;
            } else {
                _dkv = _dkv select 0;
            };
        };
        
        for "_i"
        from 0 to((count _labels) - 1) do {
            private["_c"];
            if (1 < count _dkv) then {
                _c = selectRandom _dkv;
            } else {
                _c = _dkv select 0;
            };
            
            _object setobjecttextureGlobal[
                _labels select _i,
                "custom\res\saka_ca.paa"
            ];
        };
    };
};

rhsusf_fnc_drawSymbol={
    private ["_object", "_labels", "_type", "_symbol", "_variant"];
    
    if (3 <= count _this) then {
        _object = _this select 0;
        _labels = _this select 1;
        _type = _this select 2;
        
        // Check if object symbol decals are enabled, exit if disabled
        if !(_object getVariable ["RHS_Decal_Symbol_Enabled", true]) exitwith {};
        
        if ("ARRAY" != typeName _labels) then {
            _selections = getArray (configFile >> "Cfgvehicles" >> typeOf _object >> "hiddenselections");
            _labels = [_selections find _labels];
        };
        if (count _labels isEqualto 0) exitwith {
            diag_log format ["ERRor! Unable to find selection: %1 %2", _this select 1, _dmsg];
        };
        
        private ["_getindex", "_idx", "_dkv", "_i"];
        
        // compile the proper list
        _getindex = compile (
        preprocessFileLineNumbers format [
            "\%1\Data\Labels\%2\index.sqf",
            RHSUSFDecalsmodul,
            _type
        ]
        );
        
        _idx = [] call _getindex;
        if (4 == count _this) then {
            _symbol = _this select 3;
            if ("ARRAY" == typeName _symbol) then {
                _variant = _symbol select 1;
                _symbol = _symbol select 0;
                _dkv = _idx param [_symbol, ["empty"], [ 1, [] ]];
                _dkv = _dkv select _variant;
            } else {
                _dkv = _idx param [_symbol, [["empty"]], [ 1, [] ]];
                if (1 < count _dkv) then {
                    _dkv = selectRandom _dkv;
                } else {
                    _dkv = _dkv select 0;
                };
            };
        } else {
            _dkv = selectRandom _idx;
            if (1 < count _dkv) then {
                _dkv = selectRandom _dkv;
            } else {
                _dkv = _dkv select 0;
            };
        };
        
        for "_i" from 0 to ((count _labels) - 1) do
        {
            private ["_c"];
            if (1 < count _dkv) then {
                _c = selectRandom _dkv;
            } else {
                _c = _dkv select 0;
            };
            
            // diag_log format ["Decals running server label return: %1", _c];
            
            _object setobjecttextureGlobal [
                _labels select _i,
                "custom\res\saka_ca.paa"
            ];
        };
    };
};

// rhsusf_fnc_drawNumber = {
//     private ["_style", "_labels", "_size", "_number", "_dig"];
    
//     // number of array members has to be more than 2
//     if (2 < count _this) then {
//         // get the properties from the array
//         // object is the vehicles
//         // labels - hiddenselection places, has to be an array.
//         // style - the folder from which the decals are taken
        
//         _object = _this select 0;
//         _labels = _this select 1;
//         _style = _this select 2;
        
//         // Check if object number decals are enabled, exit if disabled
//         if !(_object getVariable ["RHS_Decal_Number_Enabled", true]) exitwith {};
        
//         // if a fourth element is present, it specifies the number
//         if (3 < count _this) then {
//             _number = _this select 3;
//         } else {
//             // if number is not specified, set to 0
//             _number = 0;
//         };
        
//         // get number of digits in the number
//         // if just an array of places
//         _size = count _labels;
        
//         if ("ARRAY" != typeName _labels) then {
//             private _hiddenselections = getArray (configFile >> "Cfgvehicles" >> typeOf _object >> "hiddenselections");
            
//             private _i = 0;
//             private _labels = [];
            
//             // find indexes of selection
//             while {_i = _i + 1;
//             true} do {
//                 _search = _hiddenselections find (format["%1%2", _selection, _i]);
//                 if (_search isEqualto -1) exitwith {};
//                 _labels pushBack _search;
//             };
            
//             _labels = [_selections find _labels];
//         };
        
//         // the places are array of arrays
//         if ("ARRAY" == typeName (_labels select 0)) then {
//             _size = count (_labels select 0);
//         } else {
//             // make the array of arrays
//             _labels = [_labels];
//         };
        
//         private ["_i", "_l", "_c"];
        
//         // if number is 0 set the number as random
//         if (0 == _number) then {
//             _number = _object getVariable ["RHS_randomNumber", 999];
//             if (_number == 999) then {
//                 _number = [_size] call rhsusf_fnc_randomNum;
//             };
//         };
//         // set number in variable
//         _object setVariable ["RHS_randomNumber", _number];
        
//         // get the array of digits
//         _dig = [_number] call rhsusf_fnc_NumbertoDigits;
//         // resizing array if custom value has wrong size
//         if (count _dig != _size) then {
//             reverse _dig;
//             _dig resize _size;
//             reverse _dig;
//         };
//         // diag_log format ["Decals running return digits: %1", _dig];
        
//         // set the texture
//         for "_i" from 0 to ((count _labels) - 1) do
//         {
//             _l = _labels select _i;
//             for "_c" from 0 to ((count _l) - 1) do
//             {
//                 _object setobjecttextureGlobal [
//                     _l select _c,
//                     format [
//                         "\%1\Data\Numbers\%2\%3_ca.paa",
//                         RHSUSFDecalsmodul,
//                         _style,
//                         _dig param [_c, 0, [0]]
//                     ]
//                 ];
//             };
//         };
//     };
// }