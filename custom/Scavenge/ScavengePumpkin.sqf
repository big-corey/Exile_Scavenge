private["_pumpkinsConfig","_pumpkins","_chance","_maxpumpkins","_pumpkinsfound","_pumpkin","_pos"];
//--------------------------------------------------------------------------//
_pumpkinsConfig = missionConfigFile >> "CfgExileScavange";					// Pumpkins config reference
_pumpkins = getArray (_pumpkinsConfig >> "Pumpkins" >> "items");				// Items array config
_chance = getNumber (_pumpkinsConfig >> "Pumpkins" >> "chance");				//	Chance to find config
_maxpumpkins = getNumber (_pumpkinsConfig >> "Pumpkins" >> "maxitems");		//	Max items per drop config
//--------------------------------------------------------------------------//
	_pos = getPosATL player;
	if (ExileClientPlayerIsInCombat) exitWith {["ErrorTitleOnly", ["Its not safe to harvest pumpkins."]] call ExileClient_gui_toaster_addTemplateToast;};
	if (player call ExileClient_util_world_isInTraderZone) exitWith {["ErrorTitleOnly", ["No stealing the Trader's pumpkins!"]] call ExileClient_gui_toaster_addTemplateToast;};
	if !(player getVariable "canloot") exitWith {["ErrorTitleOnly", ["You cannot look for pumpkins just yet."]] call ExileClient_gui_toaster_addTemplateToast;};
	if !(alive player) exitWith {};
	player setVariable [ "canloot",false];
	player playMove "AinvPknlMstpSnonWnonDnon_medic_1";
	uiSleep 6;

if (random 100 > _chance) then {
	createVehicle ["Land_ClutterCutter_medium_F", _pos, [], 0, "CAN_COLLIDE"];		// LawnMower
    _pumpkinsfound = createVehicle ["GroundWeaponHolder", _pos, [], 0, "CAN_COLLIDE"];
    ["SuccessTitleOnly", ["You found something!"]] call ExileClient_gui_toaster_addTemplateToast;
	
for "_i" from 0 to floor(random _maxpumpkins) do { 	
	_pumpkin = _pumpkins call BIS_fnc_selectRandom;
	_pumpkinsfound addItemCargoGlobal [ _pumpkin, 1];
};
	uiSleep 3;
    player setVariable ["canloot",true];
} else {
	["ErrorTitleOnly", ["Nope, No pumpkins here."]] call ExileClient_gui_toaster_addTemplateToast;
	player setVariable ["canloot",true];
};