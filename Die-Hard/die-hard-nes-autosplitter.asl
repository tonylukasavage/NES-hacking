// Written by BloodSweatAndCode 
// discord/twitch/github: BloodSweatAndCode

state("fceux") {
	byte screenType: 0x003B1388, 0x119;
    ushort screenId: 0x003B1388, 0x77f;
	byte inventory: 0x003B1388, 0x779;
    byte feetDamage: 0x003B1388, 0x797;
}

startup {
	// set to true for debug output
	vars.doDebug = true;
	Action<string> DebugOutput = (text) => {
		if (vars.doDebug) {
			print("[Die Hard Autosplitter] " + text);
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
	if (old.screenType == 0x1A && old.screenId == 0x2C0B && current.screenType == 0x0F) {
		vars.DebugOutput("Die Hard started, good luck!");
        vars.foundDetonator = false;
        vars.steppedOnGlass = false;
        vars.gotKey = false;
		return true;
	}
}

split {

    // step on glass
    if (!vars.steppedOnGlass && current.feetDamage - old.feetDamage >= 8) {
        vars.DebugOutput("stepped on glass");
        vars.steppedOnGlass = true;
        return true;
    }

    // detonator
    if (!vars.foundDetonator && (old.inventory & 8) == 0 && (current.inventory & 8) == 8) {
        vars.DebugOutput("detonator");
        vars.foundDetonator = true;
        return true;
    }

    // roof key
    if (!vars.gotKey && (old.inventory & 32) == 0 && (current.inventory & 32) == 32) {
        vars.DebugOutput("roof key");
        vars.gotKey = true;
        return true;
    }

    // ending
    if (old.screenType == 0x0F && current.screenType == 0x16 && current.screenId == 0x1916) {
		vars.DebugOutput("winner winner chicken dinner");
		return true;
	}
}
