
params[
        ["_artilleryBatteries",[]],
        ["_pos", [0, 0, 0], [[]], [2, 3]],
        ["_minRDist",0],
        ["_maxRDist",500],
        ["_barrageAmount",3],
        ["_type",""]
    ];

_grp = group gunner (_artilleryBatteries select 0 select 0 );

_grp setVariable ["AI_Artillery_Last_Fire_" + _type,time,true];

for "_i"
from 1 to _barrageAmount do {
            {
                _dist = (_minRDist + (random _maxRDist));
                _position = _pos getPos[_dist, (random 360)];
                _gun = _x select 0;
				_gun doArtilleryfire[_position, _x select 1, 1];
                sleep 1;
            }
            forEach _artilleryBatteries;
            sleep 10;
};