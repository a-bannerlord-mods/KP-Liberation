
_getTimeFactor = {
    /* ----------------------------------------------------------------------------------------------------
    * Inputs
    * ----------
    * dayDur [Number] (Optional): Duration of the whole day in real hours (defaults to 24)
    * dnFac [Number] (Optional): The day-to-night ratio (defaults to 1)
    * dayOfYear [date] (Optional): The day of the year for which the multipliers will be
    *                              calculated (defaults to the current ArmA date)
    * ----------------------------------------------------------------------------------------------------
    * Output
    * ----------
    * data [Array]: - _this select 0 [Number]: Day multiplier
    *               - _this select 1 [Number]: Night multiplier
    *               - _this select 2 [Number]: Sunrise time
    *               - _this select 3 [Number]: Sunset time
    *
    * ----------------------------------------------------------------------------------------------------
    */

    // Get input variables
    params[["_dayDur", 24, [24]], // Total duration of day
        ["_dnFac", 1, [1]], // Day-to-Night factor
        ["_dayOfYear", date, [date]]]; // Asked date

    // Declare some variables
    private _riseSet = _dayOfYear call BIS_fnc_sunriseSunsetTime; // Get the sunrise and sunset times of the day
    private _durs = [nil, nil];

    // Calculate day and night duration (in real life hours)
    _durs set[0, (_riseSet select 1) - (_riseSet select 0)]; // Calculate day duration
    _durs set[1, 24 - (_durs select 0)]; // Calculate night duration

    // Calculate multipliers
    /* Solve simultaneously:
    *
    * dayDur * dayMul + nightDur * nightMul = 24 (1)
    * (dayDur * dayMul)/(nightDur * nightMul) = dayNightFrac (2)
    *
    * The result is:
    *
    * dayMul = 24/(nightDur * (1 + dayNightFrac))
    * nightMul = (nightDur * dayNightFrac * dayMul)/dayDur
    */
    private _dMul = 24/((_durs select 1) * (1 + _dnFac)); // Calculate the day multiplier
    private _nMul = ((_durs select 1) * _dnFac * _dMul)/(_durs select 0); // Calculate the night multiplier

    // Multiply with "global multiplier"
    _dMul = _dMul * 24/_dayDur; // Final day multiplier
    _nMul = _nMul * 24/_dayDur; // Final night multiplier

    // Return and exit
    [_dMul, _nMul, _riseSet select 0, _riseSet select 1]
};

while {true} do { 
    _timefactor = [];
    if (GRLIB_shorter_nights) then {
        _timefactor = [GRLIB_time_factor,4] call _getTimeFactor;
    } else {
        _timefactor = [GRLIB_time_factor,1] call _getTimeFactor;
    };

    if ((daytime > (_timefactor select 3)) || (daytime < (_timefactor select 2))) then {
        setTimeMultiplier (_timefactor select 1);
    } else {
        setTimeMultiplier (_timefactor select 0);
    };
    sleep 10;
};
