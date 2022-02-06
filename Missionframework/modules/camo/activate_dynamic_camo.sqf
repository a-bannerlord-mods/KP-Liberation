// DynamicCamo by Bunc v 1.5
// Free to use but credit me please.
// Script adjusts unitTrait camouflagecoef & audibleCoef based on environmental factors, stance and uniform.
// makes it harder for ai to detect unit depending on weather, stance, camo, cover etc.
// v1.5 Script call now passes the following arguments for easy adjustment
// [this,"Debug", "Ghillie",camLo,CamHi,AudLo,AudHi,Autodelay]
// Where CamLo = n  and   n>= 0 and n<=1 default 0
// where CamHi = n and    n>= 0 and n<=1 default 1
// same for AudLo and AudHi.
// Autodelay is delay bewteen each autorecalc in secs.
// Script now detects specific uniforms.
// script also impacts ai to ai perception - ai units will benefit from DynamicCamo re detection by other ai.
// to use on non player ai simply put unique call to script in that units init.

// FACTORS
// fog.  - (0 is no fog 1 is full fog.)
// Camo -  factor for uniform. 0 is high uniform camo. changed via Ghillie switch.
// rain -  rain density. 1 full rain 0 no rain.
// lightlevel - Stepwise function accounting for night, dawn, midday, dusk. range 0 dark to 1 light.
// overcast - 0 clear skies to 1 full overcast.
// NB script allows for linear rescaling to give better weights for each factor as required.
// NB camouflageCoef values in unit trait appear to have a subtle effect
// until values are small. rescaling of values ensures calculation produces figure in appropriate range for desired impact.
// NB units start with camouflageCoeff set to 1 as far as I can tell.
// we want combination of these factors where they are all present to produce a small ccoef
// approaching zero and perhaps not too near 1 when there are no factors in play.
// linear rescaling is available on the output the output if further adjustment is required.

// basic formula  -
// newcamcoef is the value that will be set as unit trait camouflageCoef
// newcamcoef = sqrt(  (1-fog) * camo * (1-rain) * darkvalue * (1-overcast)
// NB 0 for a factor would set camocoef to zero and we might also want some 
// effect even when a factor is 1 so we can scale these inputs to a smaller range eg 0.01 to 0.99
// the specific scaling needs to be tested for best effect.

// We start the main loop which continues while player alive
// then waituntil player presses User1 assigned key or set autodelay _ad via param.
//-----------------------------------------------------------------------------------------------

params["_unit", "_debug", "_cLo", "_cHi", "_aLo", "_aHi", "_ad"];

if (_debug == "DEBUG") then {
_autoInfo = "autodelay " + str _ad;
hint _autoInfo;
};


_time = time;
while {
alive player
}
do {
waitUntil {
        _newtime = time;
        inputAction "User1" > 0 OR (_newtime > _time + _ad)
};

//GET FACTORS AND SCALE THEM.

//GET TREES BUSHES AND HIDE FACTOR _tbhf
_ntbh = count nearestterrainobjects[_unit, ["Tree", "Bush", "Hide"], 2.5, false, true];
//set default tbh factor before if
_tbhf = 1;
if (_ntbh == 0) then {
        _tbhf = 1;
};
if (_ntbh == 1) then {
        _tbhf = 0.5
};
if (_ntbh >= 2) then {
        _tbhf = 0.25
};

// get fog and rescale result to desired range.
_foglevel = linearconversion[0, 1, fog, 0, 0.9, true];

// Camo  V1.5 includes uniform test. Default Camo is 1
_uniform = uniform _unit;
_camo = 1;
if (_uniform in GRLIB_uniform_camo_value) then {
        _camo = GRLIB_uniform_camo_value get _uniform;
} else {
        if ((str _uniform find "Ghillie" >= 1) OR(str _uniform find "Sniper" >= 1) OR(str _uniform find "Viper" >= 1)) then {
                _camo = 0.4;
        };
};


// v 1.3 getwind strength and scale it
_windstrength = vectormagnitude wind;
_windscaled = linearconversion[0, 7, _windstrength, 0, 0.9, true];

// get rain level and scale it v.13 added specific audible level
_rainLevel = linearconversion[0, 1, rain, 0, 0.8, true];
_rainLevelA = linearconversion[0, 1, rain, 0, 0.9, true];


// NEW LIGHT LEVEL FACTOR
// 1 is full light 0 is dark. Light will not impact audible.
// initialise _lightlevel before if statements
// now handles dusk and dawn.

// get sunrise and sunset
_sunriseSunsetTime = date call BIS_fnc_sunriseSunsetTime;
_sunrise = _sunriseSunsetTime select 0;
_sunset = _sunriseSunsetTime select 1;
_lightlevel = .5;

// get decimal time
_timenow = daytime;

// set required variables
p = 1;
_sre = _sunrise + p;
_srs = _sunrise - p;
_sss = _sunset - p;
_sse = _sunset + p;

// Test and assign _lightlevel values

if ((_timenow >= 0) && (_timenow <= _srs)) then {
        _lightlevel = 0;
};

if ((_timenow >= _sse) && (_timenow <= 24)) then {
        _lightlevel = 0;
};

if ((_timenow <= _sse) && (_timenow >= _sre)) then {
        _lightlevel = 1;
};

if ((_timenow >= _srs) && (_timenow <= _sre)) then {
        _lightlevel = 0.5 * (_timenow - _srs);
};

if ((_timenow >= _sss) && (_timenow <= _sse)) then {
        _lightlevel = -0.5 * (_timenow - (_sse));
};

// Linear scaling to allow adjustment of lightlevel impact.
_lightlevelscaled = linearconversion[0, 1, _lightlevel, 0.05, 1];

// get overcast level and scale it.
_overcastLevel = linearconversion[0, 1, overcast, 0, 0.9, true];

// GET STANCE AND ASSIGN VALUES  v1.3 added _stA stance audible impact.
_stanceresult = stance _unit;
_st = 1;
_stA = .5;

switch (_stanceresult) do {
        case "STAND":{
                _st = 1;
                _stA = 1;
        };
        case "CROUCH":{
                _st = 0.6;
                _stA = .5;
        };
        case "PRONE":{
                _st = 0.4;
                _stA = .2;
        };
        case "SWIMMING":{
                _st = 0.75;
                _stA = .5;
        };
        case "UNDEFINED":{
                _st = 1;
                _stA = 0;
        };
};


// RUN THE CALCULATION
_newCamCoef = sqrt(
        (1 - _foglevel) * _camo * (1 - _rainLevel) * _lightLevelscaled * (1 - _overcastLevel) * _st * _tbhf
);

_newCamCoefA = sqrt(
        (1 - _foglevel) * (1 - _rainLevel) * (1 - _overcastLevel) * _stA * (1 - _windscaled)
);

// scale our new camcoefs to whatever ranges we desire
// as given in arguments to the script

_newCamCoefScaled = linearconversion[0, 1, _newCamCoef, _cLo, _cHi, true];
_newaudibleCoefScaled = linearconversion[0, 1, _newCamCoefA, _aLo, _aHi, true];


// set our calculated value as the UnitTrait for camouflageCoef and audibleCoef
_unit setUnitTrait["camouflageCoef", _newcamCoefscaled];
_unit setunitTrait["audibleCoef", _newaudibleCoefScaled];

// DEBUG / ONSCREEN INFO

if ((_debug == "DEBUG" || !isNil "ENABLE_DCDEBUG")) then {
        _debugobj = objNull;
        if !(isNil "man") then {
                if (alive man) then {
                        _debugobj = man;
                } else {
                        _debugobj = player call BIS_fnc_enemyTargets;
                };
        } else {
                _debugobj = player findNearestEnemy player;
        };

        _testit = _unit getUnitTrait "camouflageCoef";
        _testit1 = _unit getUnitTrait "audibleCoef";
        // show calculated result for tuning - comment out if required
        _camCoeftest = "Camo " + str _testit;
        _AudCoeftest = "Audio " + str _testit1;
        
        _TBresult = "Trees&Bushes&Hides  " + str _ntbh;

        hint _TBresult;
        systemchat _camCoeftest;
        systemchat _AudCoeftest;
        if !(isNull _debugobj) then {
                _known = _debugobj knowsAbout _unit;
                _knowledge = "KnowsAbout " + str _known;
                systemchat str _knowledge;
        };    
};



// sleep for a bit so that bobbing up and down in combat doesnt cause
// too many runs on the script. Also allows player to go prone,
// get extra camo then bob up again retaining prone camo for a short while.

sleep 2;
_time = time;

};