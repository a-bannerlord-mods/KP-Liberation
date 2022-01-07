// [_item] call jn_fnc_arsenal_hasItemPermission;
params ["_item"];
_item = tolower _item;

if !(_originalTarget getVariable ['KPLIB_hasDirectAccess', false]) exitwith { 
	true 
}; 

if !(_item in GRLIB_arsenal_items) exitwith { 
	true 
};

_hasperm =false;
_requirments = (GRLIB_arsenal_items get _item) select 1; 
if (count _requirments == 0 ) exitwith { 
	true
};

{ 
	if ([_x] call KPLIB_fnc_hasQualification) exitwith { 
		_hasperm = true ;
	};
} forEach _requirments; 

_hasperm