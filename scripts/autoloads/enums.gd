extends Node

enum Emo {
	LIKE, DISLIKE, SUS
}

enum Genre {
	FUNNY, EDUCATIONAL, ENTERTAINMENT
}

enum Effect{
	MORE_ENERGY,
	ZERO_ENERGY,
	TIME_STOP,
	FINNISH_TASK
}

enum Meme {
	TEN_OF_TEN, TAI_LUNG, ANGRY_RED_FACE,
	ANIME_LIKE1,ANIME_DISLIKE1,
	DUMMY_MEME_01, DUMMY_MEME_02, DUMMY_MEME_03, DUMMY_MEME_04, DUMMY_MEME_05,
	DUMMY_MEME_06, DUMMY_MEME_07, DUMMY_MEME_08, DUMMY_MEME_09, DUMMY_MEME_10,
	DUMMY_MEME_11, DUMMY_MEME_12, DUMMY_MEME_13, DUMMY_MEME_14, DUMMY_MEME_15,
	DUMMY_MEME_16, DUMMY_MEME_17, DUMMY_MEME_18, DUMMY_MEME_19, DUMMY_MEME_20,
}

enum Content {
	CAT_VET,
	JJK_SLANDER,
	BLUE,
	RED,
	ORANGE,
	GREY,
	DUMMY_CONTENT_01, DUMMY_CONTENT_02, DUMMY_CONTENT_03, DUMMY_CONTENT_04, DUMMY_CONTENT_05,
	DUMMY_CONTENT_06, DUMMY_CONTENT_07, DUMMY_CONTENT_08, DUMMY_CONTENT_09, DUMMY_CONTENT_10,
	DUMMY_CONTENT_11, DUMMY_CONTENT_12, DUMMY_CONTENT_13, DUMMY_CONTENT_14, DUMMY_CONTENT_15,
	DUMMY_CONTENT_16, DUMMY_CONTENT_17, DUMMY_CONTENT_18, DUMMY_CONTENT_19, DUMMY_CONTENT_20
}

var content_resource: Dictionary[Enums.Content, ContentStats] = {
	Content.CAT_VET: preload("res://resources/contents/cat_vet.tres"),
	Content.JJK_SLANDER: preload("res://resources/contents/jjk_slander.tres"),
	Content.BLUE: preload("res://resources/contents/blue.tres"),
	Content.RED: preload("res://resources/contents/red.tres"),
	Content.ORANGE: preload("res://resources/contents/orange.tres"),
	Content.GREY: preload("res://resources/contents/grey.tres"),
	Content.DUMMY_CONTENT_01: preload("res://resources/contents/dummy_content_01.tres"),
	Content.DUMMY_CONTENT_02: preload("res://resources/contents/dummy_content_02.tres"),
	Content.DUMMY_CONTENT_03: preload("res://resources/contents/dummy_content_03.tres"),
	Content.DUMMY_CONTENT_04: preload("res://resources/contents/dummy_content_04.tres"),
	Content.DUMMY_CONTENT_05: preload("res://resources/contents/dummy_content_05.tres"),
	Content.DUMMY_CONTENT_06: preload("res://resources/contents/dummy_content_06.tres"),
	Content.DUMMY_CONTENT_07: preload("res://resources/contents/dummy_content_07.tres"),
	Content.DUMMY_CONTENT_08: preload("res://resources/contents/dummy_content_08.tres"),
	Content.DUMMY_CONTENT_09: preload("res://resources/contents/dummy_content_09.tres"),
	Content.DUMMY_CONTENT_10: preload("res://resources/contents/dummy_content_10.tres"),
	Content.DUMMY_CONTENT_11: preload("res://resources/contents/dummy_content_11.tres"),
	Content.DUMMY_CONTENT_12: preload("res://resources/contents/dummy_content_12.tres"),
	Content.DUMMY_CONTENT_13: preload("res://resources/contents/dummy_content_13.tres"),
	Content.DUMMY_CONTENT_14: preload("res://resources/contents/dummy_content_14.tres"),
	Content.DUMMY_CONTENT_15: preload("res://resources/contents/dummy_content_15.tres"),
	Content.DUMMY_CONTENT_16: preload("res://resources/contents/dummy_content_16.tres"),
	Content.DUMMY_CONTENT_17: preload("res://resources/contents/dummy_content_17.tres"),
	Content.DUMMY_CONTENT_18: preload("res://resources/contents/dummy_content_18.tres"),
	Content.DUMMY_CONTENT_19: preload("res://resources/contents/dummy_content_19.tres"),
	Content.DUMMY_CONTENT_20: preload("res://resources/contents/dummy_content_20.tres")
}

var meme_resource: Dictionary[Enums.Meme, MemeStats] = {
	Meme.TEN_OF_TEN: preload("res://resources/memes/normie/like/10of10.tres"),
	Meme.TAI_LUNG: preload("res://resources/memes/normie/dislike/tai_lung.tres"),
	Meme.ANGRY_RED_FACE: preload("res://resources/memes/angry_red_face.tres"),
	Meme.ANIME_LIKE1: preload("res://resources/memes/anime_like1.tres"),
	Meme.ANIME_DISLIKE1: preload("res://resources/memes/anime_dislike1.tres"),
	Meme.DUMMY_MEME_01: preload("res://resources/memes/dummy_meme_01.tres"),
	Meme.DUMMY_MEME_02: preload("res://resources/memes/dummy_meme_02.tres"),
	Meme.DUMMY_MEME_03: preload("res://resources/memes/dummy_meme_03.tres"),
	Meme.DUMMY_MEME_04: preload("res://resources/memes/dummy_meme_04.tres"),
	Meme.DUMMY_MEME_05: preload("res://resources/memes/dummy_meme_05.tres"),
	Meme.DUMMY_MEME_06: preload("res://resources/memes/dummy_meme_06.tres"),
	Meme.DUMMY_MEME_07: preload("res://resources/memes/dummy_meme_07.tres"),
	Meme.DUMMY_MEME_08: preload("res://resources/memes/dummy_meme_08.tres"),
	Meme.DUMMY_MEME_09: preload("res://resources/memes/dummy_meme_09.tres"),
	Meme.DUMMY_MEME_10: preload("res://resources/memes/dummy_meme_10.tres"),
	Meme.DUMMY_MEME_11: preload("res://resources/memes/dummy_meme_11.tres"),
	Meme.DUMMY_MEME_12: preload("res://resources/memes/dummy_meme_12.tres"),
	Meme.DUMMY_MEME_13: preload("res://resources/memes/dummy_meme_13.tres"),
	Meme.DUMMY_MEME_14: preload("res://resources/memes/dummy_meme_14.tres"),
	Meme.DUMMY_MEME_15: preload("res://resources/memes/dummy_meme_15.tres"),
	Meme.DUMMY_MEME_16: preload("res://resources/memes/dummy_meme_16.tres"),
	Meme.DUMMY_MEME_17: preload("res://resources/memes/dummy_meme_17.tres"),
	Meme.DUMMY_MEME_18: preload("res://resources/memes/dummy_meme_18.tres"),
	Meme.DUMMY_MEME_19: preload("res://resources/memes/dummy_meme_19.tres"),
	Meme.DUMMY_MEME_20: preload("res://resources/memes/dummy_meme_20.tres")
}

var meme_of_g_and_e: Dictionary = {} # {Emo: {Genre: [MemeStats]}}
func load_meme_genre_emo():
	for m in Meme.values():
		var s: MemeStats = meme_resource[m]
		var e = s.emo
		var g = s.genre
		meme_of_g_and_e.get_or_add(e, {}).get_or_add(g, []).append(m)
	#print_debug("memes of emotion", Emo.find_key(0), " and ", Genre.find_key(0), ": ", meme_of_g_and_e[0][0])



func _ready() -> void:
	load_meme_genre_emo()
