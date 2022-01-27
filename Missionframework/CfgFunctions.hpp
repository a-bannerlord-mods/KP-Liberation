class KPLIB {
    class functions {
        file = "functions";

        class addActionsFob                 {};
        class addActionsPlayer              {};
        class addObjectInit                 {};
        class addRopeAttachEh               {};
        class allowCrewInImmobile           {};
        class checkClass                    {};
        class checkCrateValue               {};
        class checkGear                     {};
        class checkWeaponCargo              {};
        class cleanOpforVehicle             {};
        class clearCargo                    {};
        class crAddAceAction                {};
        class crateFromStorage              {};
        class crateToStorage                {};
        class crawlAllItems                 {};
        class createClearance               {};
        class createClearanceConfirm        {};
        class createCrate                   {};
        class createManagedUnit             {};
        class crGetMulti                    {};
        class crGlobalMsg                   {};
        class doSave                        {};
        class doBackupSave                  {};
        class doRestorPackupSave            {};
        class fillStorage                   {};
        class forceBluforCrew               {};
        class getAdaptiveVehicle            {};
        class getBluforRatio                {};
        class getCommander                  {};
        class getCrateHeight                {};
        class getFobName                    {};
        class getFobResources               {};
        class getGroupType                  {};
        class getLessLoadedHC               {};
        class getLoadout                    {};
        class getLocalCap                   {};
        class getLocationName               {};
        class getMilitaryId                 {};
        class getMobileRespawns             {};
        class getNearbyPlayers              {};
        class getNearestBluforObjective     {};
        class getNearestFob                 {};
        class getNearestSector              {};
        class getNearestTower               {};
        class getNearestViVTransport        {};
        class getOpforCap                   {};
        class getOpforFactor                {};
        class getOpforSpawnPoint            {};
        class getPlayerCount                {};
        class getResistanceTier             {};
        class getSaveableParam              {};
        class getSaveData                   {};
        class getSectorOwnership            {};
        class getSectorRange                {};
        class getSquadComp                  {};
        class getStoragePositions           {};
        class getUnitPositionId             {};
        class getUnitsCount                 {};
        class getWeaponComponents           {};
        class handlePlacedZeusObject        {};
        class hasPermission                 {};
        class hasQualification              {};
        class initSectors                   {};
        class isBigtownActive               {};
        class isClassUAV                    {};
        class isRadio                       {};
        class log                           {};
        class potatoScan                    {};
        class protectObject                 {};
        class secondsToTimer                {};
        class setDiscordState               {};
        class setFobMass                    {};
        class setLoadableViV                {};
        class setLoadout                    {};
        class setVehicleCaptured            {};
        class setVehiclesSeized              {};
        class sortStorage                   {};
        class spawnBuildingSquad            {};
        class spawnBuildingSquadFromCache   {};
        class spawnCivilians                {};
        class spawnGuerillaGroup            {};
        class spawnMilitaryPostSquad        {};
        class spawnMilitiaCrew              {};
        class spawnRegularSquad             {};
        class spawnVehicle                  {};
        class swapInventory                 {};
        class updatePlayerData              {};
        class setUnitTraits                 {};
        class onPause                       {};
        class combatReadinessUpdated        {}; 
        class removeUselessSectorMarkers    {};
        class getBuildingRooftopPositions   {};
        class getNearestSectorOfType        {};
        class makeUnitFlee                  {};
        class applyCustomUnitSettings       {};
        class isStartBase                   {};
        class isPlayerNearToFob             {};       
        class sectorCanBeActivated          {};
        class raiseAlarm                    {};
        class turnOffAlarm                  {};
        class applyUnitAnimations           {};
        class makeObjectDestroyable         {};
        class getHighestPos                 {};
    };
    class functions_curator {
        file = "functions\curator";

        class initCuratorHandlers       {
            postInit = 1;
        };
        class requestZeus               {};
    };
    class functions_ui {
        file = "functions\ui";

        class overlayUpdateResources    {};
    }; 
    class functions_objectives {
        file = "functions\objectives";
        class spawnCaptureObjectiveInSector     {};
        class spawnRescueObjectiveInSector      {};
        class spawnDestroyObjectiveInSector     {};        
        class captureObjective                  {};
        class rescueObjective                   {};
        class destroyObjective                  {};
    }; 
    class functions_lightGenerator {
        file = "functions\lightGenerator";
        class addLightGenerator     {};
        class addLightSwich         {};
    };
    class functions_items {
        file = "functions\items";
        class calculateMagValue    {};
    };
    class functions_cargo {
        file = "functions\logistics";
        class addLogisticsActions   {};
        class addBuyAmmoActions     {};
        class addBuyFuelActions     {};
        class addRepairActions      {};
        class addMoveFuelActions    {};
        class addMoveAmmoActions    {};
    };
    class functions_data {
        file = "functions\data";

        class getObjectExtraDataToSave  {};
        class setObjectExtraDataFromSave{};
        class getContainersItems        {};
        class setContainersItems        {};
        class getVehicleLoadout         {};
        class setVehicleLoadout         {};
        class getVehiclePylon           {};
        class setVehiclePylon           {};
    };
    #include "scripts\client\CfgFunctions.hpp"
    #include "scripts\server\CfgFunctions.hpp"
};
