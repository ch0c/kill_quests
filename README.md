# kill_quests
Kill AI for Rewards. 


Players will be give a quest to kill a group of up to 11 heroes or bandits. 
They must hand in the quest when complete and before dying.


You can execute it however you want.




Example using fn_selfActions.sqf

Paste
```c++

	if ( _cursorTarget isKindOf "Info_Board_EP1") then {
    if (s_player_getQuest < 0) then {
		s_player_getQuest = player addAction ["<t color='#00DED3'>Request Kill Quest.</t>", "dayz_code\external\quests\getQuest.sqf",1, 0, true, true, "", ""];
		};
	    if (s_player_returnQuest < 0) then {
		s_player_returnQuest = player addAction ["<t color='#00DE5C'>Return Kill Quest.</t>", "dayz_code\external\quests\returnQuest.sqf",1, 0, true, true, "", ""];
		};
	} else {
		player removeAction s_player_getQuest;
		s_player_getQuest= -1;
		player removeAction s_player_returnQuest;
		s_player_returnQuest= -1;
	};

```

Above

```	// All Traders```


Paste 
```
		player removeAction s_player_getQuest;
		s_player_getQuest= -1;
		player removeAction s_player_returnQuest;
		s_player_returnQuest= -1;
```
Below
```
	s_garage_dialog = -1;	
```


In your variables.sqf add
```
		s_player_getQuest= -1;
		s_player_returnQuest= -1;
```
under
```
	dayz_resetSelfActions = {
```

Complete.
