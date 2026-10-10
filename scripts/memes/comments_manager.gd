extends VBoxContainer
class_name CommentsManager

var comment_nodes: Array[Comment] = []

static var comments_of_genre: Dictionary = { 
	Enums.Genre.NORMIE: [
		"🔥🔥", "🤮🤮🤮", "😂😂", "Who is watching in 2026? 👀", "So true!! 💯", 
		"Bro thought we wouldn't notice 💀", "First 😂", "This is sending me", 
		"Can we talk about how good this is?", "My last two brain cells during this video: 👁️👄👁️"
	], 
	Enums.Genre.FANDOM: [
		"that's crazy", "THE FORESHADOWING IS CRAZY", "WE ARE SO BACK", 
		"Is this canon???", "The way I gasped at the end", "My hyperfixation is back", 
		"They really gave us peak fiction today", "The animator deserves a raise 😭", 
		"I'm literally crying crying right now", "They did NOT just do that to my favorite character"
	], 
	Enums.Genre.VIRAL: [
		"am i tripping", "The algorithm brought me here", "Bro spawned out of nowhere", 
		"This is going to the top of the feed", "I've seen this 50 times today already", 
		"Why is this so lowkey addictive?", "Is this real or AI?", 
		"New core memory unlocked", "I am early to a viral masterpiece", "The internet was a mistake 💀"
	]
}


static var usernames: Array[String] = [
  "NovaKnight79", "NovaWolf14", "GhostSpecter16", "VortexSpecter45", "SwiftWolf69",
  "FrostTitan37", "ShadowRanger95", "LunarStorm26", "CyberStriker57", "VortexStorm90",
  "NovaStorm13", "NovaRanger93", "GhostRider45", "GhostStriker43", "OmegaRanger40",
  "NeonSpecter39", "VortexHunter75", "NovaStorm61", "EpicWizard90", "NeonRanger29",
  "QuantumStorm27", "SolarStorm82", "AlphaGlitch99", "ShadowKnight97", "ShadowPulse91",
  "CyberSpecter93", "AlphaHunter71", "FrostStriker79", "GhostEcho68", "OmegaWizard26"
]
