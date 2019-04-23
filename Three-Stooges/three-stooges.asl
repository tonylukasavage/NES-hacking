// Written by Tony Lukasavage 
// discord/twitch/github: BloodSweatAndCode

state("fceux") {
	byte isGameStarted: 0x003B1388, 0x7D;
    byte gamepad: 0x003B1388, 0xC5;
    byte gameState1: 0x003B1388, 0x1F5;
    byte gameState2: 0x003B1388, 0x1F6;
    byte gameState3: 0x003B1388, 0x1F7;
}

startup {
	// set to true for debug output
	vars.doDebug = true;
	Action<string> DebugOutput = (text) => {
		if (vars.doDebug) {
			print("[Three Stooges Autosplitter] " + text);
		}
	};
	vars.DebugOutput = DebugOutput;
}

init {
    vars.foundDetonator = false;
    vars.steppedOnGlass = false;
    vars.gotKey = false;
}

start {
	if (current.isGameStarted == 0 && old.gameState1 == 0xFC && old.gameState2 == 0x23 && 
        old.gameState3 == 0x34 && current.gameState1 == 0x25 && current.gameState3 == 0x96) {
		vars.DebugOutput("Three Stooges started, good luck!");
		return true;
	}
}
