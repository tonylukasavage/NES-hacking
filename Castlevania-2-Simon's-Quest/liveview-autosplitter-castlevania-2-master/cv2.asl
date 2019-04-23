// Written by Tony Lukasavage 
// discord & twitch: BloodSweatAndCode
// github & twitter: tonylukasavage
//
// Find me in the Castlevania discord: https://discord.gg/w6HMSW7

state("fceux") {
	byte items: 0x003B1388, 0x91;
	byte whip: 0x003B1388, 0x434;
	byte objectIndex : 0x003B1388, 0x3BA;
	byte map1 : 0x003B1388, 0x3d;
	byte map2 : 0x003B1388, 0x3e;
}

startup {
	settings.Add("drac_parts", true, "Dracula Parts");
	settings.Add("part_rib", true, "Rib", "drac_parts");
	settings.Add("part_heart", true, "Heart", "drac_parts");
	settings.Add("part_eye", true, "Eye", "drac_parts");
	settings.Add("part_nail", true, "Nail", "drac_parts");
	settings.Add("part_ring", true, "Ring", "drac_parts");

	settings.Add("crystals", true, "Crystals");
	settings.Add("crystal_white", false, "White Crystal", "crystals");
	settings.Add("crystal_blue", true, "Blue Crystal", "crystals");
	settings.Add("crystal_red", true, "Red Crystal", "crystals");

	settings.Add("whips", true, "Whips");
	settings.Add("whip_thorn", false, "Thorn Whip", "whips");
	settings.Add("whip_chain", true, "Chain Whip", "whips");
	settings.Add("whip_ms", false, "Morning Star", "whips");
	settings.Add("whip_flame", false, "Flame Whip", "whips");

	settings.Add("misc", true, "Misc");
	settings.Add("blob_boost", true, "Blob Boost", "misc");
	settings.Add("drac_death", true, "Dracula Death Explosion End", "misc");

	// set to true for debug output
	vars.doDebug = true;
	Action<string> DebugOutput = (text) => {
		if (vars.doDebug) {
			print("[CV2 Autosplitter] " + text);
		}
	};
	vars.DebugOutput = DebugOutput;
}

start {
	if (old.map1 == 0x00 && old.map2 == 0x00 && current.map1 == 0xAC && current.map2 == 0x90) {
		vars.DebugOutput("CV2 started, good luck!");
		return true;
	}
}

split {

	// crystals
	if ((old.items & 32) == 0 && (current.items & 32) == 32) {  
		if (settings["crystal_red"] && (current.items & 64) == 64) {
			vars.DebugOutput("red crystal");
			return true;
		} else if (settings["crystal_white"]) {
			vars.DebugOutput("white crystal");
			return true;
		} 
	}
	if (settings["crystal_blue"] && (old.items & 64) == 0 && (current.items & 64) == 64) {  vars.DebugOutput("blue crystal"); return true; }

	// whips
	if (settings["whip_thorn"] && old.whip != 1 && current.whip == 1) {  vars.DebugOutput("thorn whip"); return true; }
	if (settings["whip_chain"] && old.whip != 2 && current.whip == 2) {  vars.DebugOutput("chain whip"); return true; }
	if (settings["whip_ms"] && old.whip != 3 && current.whip == 3) {  vars.DebugOutput("morning star"); return true; }
	if (settings["whip_flame"] && old.whip != 4 && current.whip == 4) {  vars.DebugOutput("flame whip"); return true; }

	// dracula parts
	if (settings["part_rib"] && (old.items & 1) == 0 && (current.items & 1) == 1) {  vars.DebugOutput("rib"); return true; }
	if (settings["part_heart"] && (old.items & 2) == 0 && (current.items & 2) == 2) {  vars.DebugOutput("heart"); return true; }
	if (settings["part_eye"] && (old.items & 4) == 0 && (current.items & 4) == 4) {  vars.DebugOutput("eye"); return true; }
	if (settings["part_nail"] && (old.items & 8) == 0 && (current.items & 8) == 8) {  vars.DebugOutput("nail"); return true; }
	if (settings["part_ring"] && (old.items & 16) == 0 && (current.items & 16) == 16) {  vars.DebugOutput("ring"); return true; }

	// dracula death explosion end
	if (settings["drac_death"] && old.objectIndex == 0x4D && current.objectIndex != 0x4D) { 
		vars.DebugOutput("dracula death explosion end"); 
		return true; 
	}

	// blob boost
	if (settings["blob_boost"] && old.map1 == 0x78 && old.map2 == 0xAF && current.map1 == 0x4B && current.map2 == 0xAF) {
		vars.DebugOutput("blob boost");
		return true;
	}

}