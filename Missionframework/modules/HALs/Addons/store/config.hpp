/*
	Macro: ERROR_WITH_TITLE()

	Parameters:
	0: CLASSNAME - Classname of item
	1: PRICE - Default item price
	2: STOCK - Default item stock
__________________________________________________________________*/
#define ITEM(CLASSNAME, PRICE, STOCK)\
	class CLASSNAME {\
		price = PRICE;\
		stock = STOCK;\
	};

class cfgHALsStore {
	containerTypes[] = {"LandVehicle", "Air", "Ship"};
	containerRadius = 10;
	currencySymbol = "Supplies";
	sellFactor = 0.2;
	debug = 0;

	class categories {
		class assultRifle {
			displayName = "Assult Rifles";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class dmr {
			displayName = "Marksman Rifles";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class sniper {
			displayName = "Snipers";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class   {
			displayName = "Submachine guns";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class mmgs {
			displayName = "Medium machine gun";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class smgs {
			displayName = "SMGs";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class handguns {
			displayName = "Handguns";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\handgun_ca.paa";
		};
		class launchers {
			displayName = "Rocket Launchers";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\secondaryWeapon_ca.paa";
		};
		class optics {
			displayName = "Optics Accessories";
			picture = "";
		};
		class underbarrel {
			displayName = "Underbarrel Accessories";
			picture = "";

		};
		class pointers {
			displayName = "Pointer Accessories";
			picture = "";

		};		
		class muzzles {
			displayName = "Muzzle Accessories";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class magazines {
			displayName = "Magazines";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
		};
		class uniforms {
			displayName = "Uniforms";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
		};
		class vests {
			displayName = "Vests";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
		};
		class backpacks {
			displayName = "Backpacks";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\primaryWeapon_ca.paa";
		};
		class headgear {
			displayName = "Headgear";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
		};
		class facegear {
			displayName = "Facegear";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\cargoMag_ca.paa";
		};
		class navigation {
			displayName = "Navigation, Vision and Rangefinders";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class handGrenade {
			displayName = "Hand Grenade";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class explosives {
			displayName = "Explosives";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class drones {
			displayName = "Drones";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class foods {
			displayName = "Foods and Drinks";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class engineering {
			displayName = "Engineering items";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class communications {
			displayName = "Communications items";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class medical {
			displayName = "Medical items";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class tools {
			displayName = "Tools and Gadget";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class others {
			displayName = "Others";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
		class civiliansItems {
			displayName = "Civilians Items";
			picture = "a3\ui_f\data\gui\Rsc\RscDisplayArsenal\compass_ca.paa";
		};
	};

	class stores {
		class supplies {
			displayName = "Supplies Store";
			categories[] = {"assultRifle","dmr","sniper","smgs","mmgs","handguns","launchers","optics","underbarrel","pointers","muzzles","magazines","uniforms","vests","backpacks","headgear","facegear","navigation","handGrenade","explosives","drones","foods","engineering","communications","medical","tools","others","civiliansItems"};
		};
	};
};
