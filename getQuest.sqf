
local _getQuest = {
	
	if (!isnil {player getvariable "dtaQuest"}) exitwith {	"You already have an active quest!" call dayz_rollingMessages;	};
	if (dayz_actionInProgress) exitWith {localize "str_player_actionslimit" call dayz_rollingMessages;};

    local _showHint = false;  									// track kills with hint message
	local _reqKills			= floor(5 + (random 6));		// between 5 and 11 kills
    local _questReward	= _reqKills * 1000;				// 1000 coins per kill
	local _humanityReward = _questReward / 10;		//	100 Humanity per kill	also defined in returnQuest.sqf

	private ["_humanityVar","_playerType","_questType","_currentKills"];
	
    _humanityVar = ""; 
    _playerType = ""; 
    _questType = ""; 
    _currentKills = 0; 

	if (player getVariable ["humanity", 0] >= 2500) then {
		_playerType = "Hero"; 
		_questType = "Bandit"; 
		_currentKills = player getVariable ["banditKills", 0]; 
		_humanityVar = "+"; 
	} else {
		_playerType = "Bandit"; 
		_questType = "Hero";
		_currentKills = player getVariable ["humanKills", 0]; 
		_humanityVar = "-"; 
	};
	
    local _questTitle		= format ["Kill %1 %2 AI Units.", _reqKills, _questType];
    local _questDetails	= format ["Eliminate %1 %2 without dying.", _reqKills, _questType];

	player setVariable ["dtaQuest", [_reqKills,_currentKills,_playerType,_questType,_questReward]];

    format ["%1 %2 <br/> Reward: %3 coins and %4%5 Humanity.", _questTitle, _questDetails,_questReward,_humanityVar,_humanityReward] call dayz_rollingMessages;

	systemChat format ["[Quest]: %2 - Reward: %3 coins & %4%5 Humanity.", _questTitle, _questDetails,_questReward,_humanityVar,_humanityReward];

if (_showHint) then {
	while { !isnil {player getvariable "dtaQuest"} } do {
	
	private ["_currentKills","_hinttext","_image","_progressKills"];
		
		local _questVars = player getVariable ["dtaQuest", []];
		local _reqKills = _questVars select 0;
		local _startingKills = _questVars select 1;
		local _questType = _questVars select 3;
		_currentKills = 0; 
		_hinttext = ""; 
		_image = ""; 

		if (_questType == "Hero") then {
			_currentKills = player getVariable ["humanKills", 0]; 
			_image = "\ca\characters\data\portraits\combarhead_blufor_cdf_ca.paa";
		} else {
			_currentKills = player getVariable ["banditKills", 0]; 
			_image = "\ca\characters\data\portraits\combarhead_opfor_ca.paa";
		};
			
		_progressKills = _currentKills - _startingKills;


		if (_progressKills >= _reqKills) then {
			_hintText = format ["<t align='center' color='#ffc861' shadow='2' size='1.3'>%4 Kill Tracker.</t><br/><br/><t align='center' color='#15f205' shadow='2' size='1'>COMPLETE!</t><br/><t align='center' color='#f0f0f0' shadow='2' size='0.95'>Visit a trader and claim your reward! <br/>%2/%2 %4s Killed.</t><br/><br/>", 
			_progressKills,
			_reqKills,
			_questReward,
			_questType,
			_image
			];
		}else{
			_hintText = format ["<t align='center' color='#ffc861' shadow='2' size='1.3'>%4 Kill Tracker.</t><br/><br/><img size='4' image='%5' /><br/><br/><t align='center' color='#f0f0f0' shadow='2' size='0.95'>%1/%2 %4s Killed.</t><br/><br/>", 
			_progressKills,
			_reqKills,
			_questReward,
			_questType,
			_image
			];
			
		};
			hintSilent parseText _hintText;
			sleep 3; 
		};
	};
};

player spawn _getQuest;