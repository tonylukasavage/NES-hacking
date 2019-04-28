// Written by BloodSweatAndCode
// discord/twitch/github: BloodSweatAndCode

// This splitter is really rudimentary and not my best work. The start is all I implemented because I had
// trouble dealing with all of the 3 stooges switches between cutscenes, mini games, and other game states.
// I'm sure it's easy enough to decipher, but instead of spending the time on it I just worried about 
// getting the WR. When someone beats that, I'll revisit the game and the autosplitter. :P

state("fceux") {
	byte isGameStarted: 0x003B1388, 0x7D;
	byte gamepad: 0x003B1388, 0xC5;
	byte gameState1: 0x003B1388, 0x1F5;
	byte gameState2: 0x003B1388, 0x1F6;
	byte gameState3: 0x003B1388, 0x1F7;
}

startup {
	// set to true for debug output
	vars.doDebug = false;
	Action<string> DebugOutput = (text) => {
		if (vars.doDebug) {
			print("[Three Stooges Autosplitter] " + text);
		}
	};
	vars.DebugOutput = DebugOutput;
}

start {
	if (current.isGameStarted == 0 && old.gameState1 == 0xFC && old.gameState2 == 0x23 && 
        old.gameState3 == 0x34 && current.gameState1 == 0x25 && current.gameState3 == 0x96) {
		vars.DebugOutput("Three Stooges started, good luck!");
		return true;
	}
}
