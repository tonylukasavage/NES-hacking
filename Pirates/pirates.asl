// Written by Tony Lukasavage 
// discord/twitch/github: BloodSweatAndCode

state("fceux") {
    byte gamepad: 0x003B1388, 0x26;
	ulong screen1: 0x003B1388, 0x200;
	ulong screen2: 0x003B1388, 0x208;
}

init {
    vars.pressedStart = false;
}

start {
	if (!vars.pressedStart && ((current.gamepad & 0x10) != 0)) {
		vars.pressedStart = true;
		return true;
	}
}

split {
	if (vars.pressedStart && current.screen1 == 0x5800C057F8F8F8F8 && current.screen2 == 0x5200C2675200C15F) {
		return true;
	}
}