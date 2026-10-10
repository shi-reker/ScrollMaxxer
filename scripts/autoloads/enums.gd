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
	ANIME_LIKE1, KNEADTANYAHU_IMPRESSED,
	LOCALBARS, ABSOLUTE_CINEMA,
	ITS_PEAK, BLUEBLOB, DOAKES,
	TANJIRO_PHONE, SQUINT_PAPER,
	FORK_IN_KITCHEN, BROTHER_JUST_ME,
	MOMOI_SCROLL, SLANDER_LK_RIGHT,
	SPONGEBOB_DELETE,
}

enum Content {
	SYLPHY, COOKIETY, AI_CAT, 
	CAT_VET,
	JJK_SLANDER,
	MESMERIZER,
	HUHUSHENGWEI,
	JOB_APPLICATION,
	COMM_ARTIST,
	COMMENTTYPE_01, COMMENTTYPE_02, COMMENTTYPE_03, COMMENTTYPE_04, 
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
	Content.COMM_ARTIST: preload("res://resources/contents/comm_artist.tres"),
	Content.COMMENTTYPE_01: preload("res://resources/contents/comment-type_01.tres"),
	Content.COMMENTTYPE_02: preload("res://resources/contents/comment-type_02.tres"),
	Content.COMMENTTYPE_03: preload("res://resources/contents/comment-type_03.tres"),
	Content.COMMENTTYPE_04: preload("res://resources/contents/comment-type_04.tres"),
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
	Meme.LOCALBARS: preload("res://resources/memes/local_bars.tres"),
	Meme.ABSOLUTE_CINEMA: preload("res://resources/memes/absolute_cinema.tres"),
	Meme.ITS_PEAK: preload("res://resources/memes/its_peak.tres"),
	Meme.BLUEBLOB: preload("res://resources/memes/blue_blob.tres"),
	Meme.DOAKES: preload("res://resources/memes/doakes.tres"),
	Meme.TANJIRO_PHONE: preload("res://resources/memes/tanjiro_phohe.tres"),
	Meme.SQUINT_PAPER: preload("res://resources/memes/squint_paper.tres"),
	Meme.FORK_IN_KITCHEN: preload("res://resources/memes/fork_in_kitchen.tres"),
	Meme.BROTHER_JUST_ME: preload("res://resources/memes/bro_just_another_me.tres"),
	Meme.MOMOI_SCROLL: preload("res://resources/memes/momoi_scroll.tres"),
	Meme.SPONGEBOB_DELETE: preload("res://resources/memes/spongebob_del.tres"),
	Meme.SLANDER_LK_RIGHT: preload("res://resources/memes/slander_lk_right.tres"),
	Meme.KNEADTANYAHU_IMPRESSED: preload("res://resources/memes/kneadtanyahu_impressed.tres"),
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
