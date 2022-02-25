#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class AI_Artillery {
    class common {
        file = MODULES_DIRECTORY\AI_Artillery\functions;
        class initFO {};
        class initArtillery {};
        class canFireOnTarget {};
        class fireArtillery {};
        class getAvailableArtillery {};
        class requestHEFire {};
        class requestSmokeFire {};
        class requestFlareFire {};
    };
};

