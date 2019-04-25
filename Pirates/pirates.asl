// Written by Tony Lukasavage 
// discord/twitch/github: BloodSweatAndCode

state("fceux") {
    byte gamepad: 0x003B1388, 0x26;
	ulong screen1: 0x003B1388, 0x200;
	ulong screen2: 0x003B1388, 0x208;
}

start {
	// start whenever "start" is pressed
	if ((current.gamepad & 0x10) != 0) {
		return true;
	}3
}

split {
	// this seems to be specific enough to capture the graphics of when you return to the main screen
	if (current.screen1 == 0x5800C057F8F8F8F8 && current.screen2 == 0x5200C2675200C15F) {
		return true;
	}
}
