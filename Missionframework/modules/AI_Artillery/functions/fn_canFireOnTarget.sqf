
params [
		["_grp", grpNull],
		["_vehs", []],
    	["_target", objnull],
		["_type",""],
		["_amount",0]
	];

_pos = getPos _target;
_resu = [];
_addedV =[];
{
	if ((typeof _x) in opfor_artillery_ammo) then {
		_ammoSettings = opfor_artillery_ammo get (typeof _x);
		_veh= _x;
		_magtypes = getArtilleryAmmo[_veh];
		{
			_megtype= _x;
			_ind = _ammoSettings findIf {_x select 0 == _megtype && _x select 1 == _type};
			if (_ind > -1) then {
				(_ammoSettings select _ind) params ["_s", "_t","_minRange","_maxRange","_minReadiness"];
				_avamount = 0;
				{
					if (_x select 0==_megtype) then {
						_avamount = _avamount + (_x select 1);
					} 
				} forEach (magazinesAmmo _veh);

				_vehAvl = 
				(_veh distance _target )> _minRange 
				&& (_veh distance _target ) < _maxRange 
				//&& combat_readiness >= _minReadiness
				&&	_avamount >= _amount;
				if (_vehAvl && !(_veh in _addedV)) then {
					_resu pushBack [_veh,_megtype];
					_addedV pushBack _veh;
				};
			};
		} forEach _magtypes;
	};
} forEach _vehs;

_resu