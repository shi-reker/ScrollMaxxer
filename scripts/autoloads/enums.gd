extends Node

enum Emo {
	LIKE, DISLIKE, SUS
}

enum Genre {
	FUNNY, EDUCATIONAL, ENTERTAINMENT
}

enum Meme {
	TEN_OF_TEN, TAI_LUNG,
	ANIME_LIKE1,ANIME_DISLIKE1
}

enum Content {
	CAT_VET,
	JJK_SLANDER
}

var content_resource: Dictionary[Enums.Content, ContentStats] = {
	Content.CAT_VET: preload("res://resources/contents/cat_vet.tres"),
	Content.JJK_SLANDER: preload("res://resources/contents/jjk_slander.tres")
}
