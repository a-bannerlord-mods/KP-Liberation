#include "defineCommon.inc"

private["_list", "_item", "_return"];
_item = _this select 0;
_list = _this select 1;
_return = false;
{
    if (_item isEqualto (_x select 0)) exitwith {
        _return = true;
    };
}forEach _list;
_return;