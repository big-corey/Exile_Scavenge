private["_apples","_chance","_maxapples","_applesfound","_apple","_pos"];
//--------------------------------------------------------------------------//
_apples = ["items_pack_apple_red", "items_pack_apple"];
_chance = 50;			//	Chance to find
_maxapples = 5;		//	Max apple per drop
//--------------------------------------------------------------------------//
	_pos = getPosATL player;
	if (ExileClientPlayerIsInCombat) exitWith {["ErrorTitleOnly", ["Its not safe to pick apples."]] call ExileClient_gui_toaster_addTemplateToast;};
	if (player call ExileClient_util_world_isInTraderZone) exitWith {["ErrorTitleOnly", ["No stealing the Trader's apples!"]] call ExileClient_gui_toaster_addTemplateToast;};
	if !(player getVariable "canloot") exitWith {["ErrorTitleOnly", ["You cannot look for apples just yet."]] call ExileClient_gui_toaster_addTemplateToast;};
	if !(alive player) exitWith {};
	player setVariable [ "canloot",false];
	player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
	uiSleep 6;

if (random 100 > _chance) then {
	createVehicle ["Land_ClutterCutter_medium_F", _pos, [], 0, "CAN_COLLIDE"];		// LawnMower
    _applesfound = createVehicle ["GroundWeaponHolder", _pos, [], 0, "CAN_COLLIDE"];
    ["SuccessTitleOnly", ["You found something!"]] call ExileClient_gui_toaster_addTemplateToast;
	
for "_i" from 0 to floor(random _maxapples) do { 	
	_apple = _apples call BIS_fnc_selectRandom;
	_applesfound addItemCargoGlobal [ _apple, 1];
};
	uiSleep 3;
    player setVariable ["canloot",true];
} else {
	["ErrorTitleOnly", ["Nope, No apples here."]] call ExileClient_gui_toaster_addTemplateToast;
	player setVariable ["canloot",true];
};