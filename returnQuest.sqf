	if (dayz_actionInProgress) exitWith {localize "str_player_actionslimit" call dayz_rollingMessages;};


local _returnQuest = {

	if (isnil {player getvariable "dtaQuest"}) exitwith {	"You don't have an active quest!" call dayz_rollingMessages;	};
	private ["_currentKills"];

		local _passed = false;
		local _questVars = player getVariable ["dtaQuest", []];
		local _humanity = player getVariable ["humanity", 0]; 
		local _reqKills = _questVars select 0;
		local _startingKills = _questVars select 1;
		local _questType = _questVars select 3;
		local _reward = _questVars select 4;
		local _humanityReward = _reward / 10;
		_currentKills = 0;


		diag_log format ["dtaQuest return %1", _questVars];

		if (_questType == "Hero") then {
			_currentKills = player getVariable ["humanKills", 0]; 
		} else {
			_currentKills = player getVariable ["banditKills", 0]; 
		};
		
		_currentKills = _currentKills - _startingKills;

		diag_log format ["dtaQuest _currentKills %1", _currentKills];

		if (_currentKills >= _reqKills) then {
			_passed = true;
		};

		if !(_passed) exitWith { 
			format ["You need to eliminate %1 more targets to complete your current quest!", _reqKills] call dayz_rollingMessages;
		};

		if (_passed) then {
			player setVariable ["cashMoney", ((player getVariable ["cashMoney", 0]) + _reward), true];
			
			if (_questType == "Hero") then {
				player setVariable ["humanity",(_humanity - _humanityReward),true];
				format ["Congratulations %1,<br/> You have been rewarded %2 coins and -%3 Humanity for completing the quest!", name player, _reward,_humanityReward] call dayz_rollingMessages;
			}else{
				player setVariable ["humanity",(_humanity + _humanityReward),true];
				format ["Congratulations %1,<br/> You have been rewarded %2 coins and %3 Humanity for completing the quest!", name player, _reward,_humanityReward] call dayz_rollingMessages;
			};
			
			player setVariable ["dtaQuest", nil];
			hintSilent "";
			
		};
	};


player spawn _returnQuest;

