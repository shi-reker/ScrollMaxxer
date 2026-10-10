extends Node

enum Emo {
	PLEASED, FUNNY, SUS, DISGUSTED, BEWILDERED 
}

enum Genre {
	NORMIE, FANDOM, VIRAL
}

enum Effect{
	MORE_ENERGY,
	ZERO_ENERGY,
	TIME_STOP,
	INSTANT_FINNISH
}

enum Meme {
	TEN_OF_TEN, TAI_LUNG, ANGRY_RED_FACE,
	SHOULDER_TOUCH, CRACKED, POINTING, IQ_CROW,
	ANIME_LIKE1,ANIME_DISLIKE1,
	LOCALBARS,
	ABSOLUTE_CINEMA,
	ITS_PEAK,
}

enum Content {
	SYLPHY, COOKIETY, AI_CAT, 
	CAT_VET,
	JJK_SLANDER,
	MESMERIZER,
	SYLPHHYCOOKIE,
	HUHUSHENGWEI,
	JOB_APPLICATION,
	COMMENTTYPE_01, 
	COMM_ARTIST,
	DUMMY_CONTENT_02, DUMMY_CONTENT_03, DUMMY_CONTENT_04, DUMMY_CONTENT_05,
	DUMMY_CONTENT_06, DUMMY_CONTENT_07, DUMMY_CONTENT_08, DUMMY_CONTENT_09, DUMMY_CONTENT_10,
	DUMMY_CONTENT_11, DUMMY_CONTENT_12, DUMMY_CONTENT_13, DUMMY_CONTENT_14, DUMMY_CONTENT_15,
	DUMMY_CONTENT_16, DUMMY_CONTENT_17, DUMMY_CONTENT_18, DUMMY_CONTENT_19, DUMMY_CONTENT_20
}

var content_resource: Dictionary[Enums.Content, ContentStats] = {
	Content.COOKIETY: preload("res://resources/contents/cookiety.tres"),
	Content.SYLPHY: preload("res://resources/contents/Sylphi-oatmeal.tres"),
	Content.AI_CAT: preload("res://resources/contents/ai_cat.tres"),
	Content.CAT_VET: preload("res://resources/contents/cat_vet.tres"),
	Content.JJK_SLANDER: preload("res://resources/contents/jjk_slander.tres"),
	Content.MESMERIZER: preload("res://resources/contents/mesmerizer.tres"),
	Content.HUHUSHENGWEI: preload("res://resources/contents/hu_hu_sheng_wei.tres"),
	Content.JOB_APPLICATION: preload("res://resources/contents/job_application.tres"),	
	Content.COMMENTTYPE_01: preload("res://resources/contents/comment-type_01.tres"),
	#Content.COMM_ARTIST: preload("res://resources/contents/comm_artist.tres"),
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
	Meme.SHOULDER_TOUCH: preload("res://resources/memes/shoulder.tres"), 
	Meme.CRACKED: preload("res://resources/memes/cracked.tres"), 
	Meme.POINTING: preload("res://resources/memes/pointing.tres"),
	Meme.TEN_OF_TEN: preload("res://resources/memes/normie/like/10of10.tres"),
	Meme.TAI_LUNG: preload("res://resources/memes/normie/dislike/tai_lung.tres"),
	Meme.ANGRY_RED_FACE: preload("res://resources/memes/angry_red_face.tres"),
	Meme.IQ_CROW: preload("res://resources/memes/iq_crow.tres"),
	Meme.ANIME_LIKE1: preload("res://resources/memes/anime_like1.tres"),
	Meme.ANIME_DISLIKE1: preload("res://resources/memes/anime_dislike1.tres"),
	Meme.LOCALBARS: preload("res://resources/memes/local_bars.tres"),
	#Meme.ABSOLUTE_CINEMA: preload("res://resources/memes/absolute_cinema.tres"),
	#Meme.ITS_PEAK: preload("res://resources/memes/its_peak.tres"),
}

var meme_of_g_and_e: Dictionary = {} # {Emo: {Genre: [MemeStats]}}
func load_meme_genre_emo():
	for m in Meme.values():
		var s: MemeStats = meme_resource[m]
		var e = s.emo
		var g = s.genre
		meme_of_g_and_e.get_or_add(e, {}).get_or_add(g, []).append(m)

func _ready() -> void:
	load_meme_genre_emo()
	print_debug("meme g r: ", meme_of_g_and_e)
