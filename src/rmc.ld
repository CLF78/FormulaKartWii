SECTIONS {
	/* Base Functions */
	_directWriteArray = 0x80005F34;
	StartFunc = 0x808DD400;

	/* EVA Variables */
	GameMode = 0x800001B0;
	AlwaysWinVote = 0x800001B1;
	MirrorOn = 0x800001B2;
	TeamsOn = 0x800001B3;
	VehicleRestrict = 0x800001B4;
	RandomCombos = 0x800001B5;
	ItemAmounts = 0x800001B8;
	Version = 0x800001D0;
	CurrentStrmChannels = 0x800001D1;
	SubtractItemFix = 0x800001D2;
	AltKMP = 0x800001D4;

	/* Change Character Between Races */
	ScenePtr = 0x80000EA0;
	CupSelPtr = 0x80000EA4;
	CharSelPtr = 0x80000EA8;
	VRPtr = 0x80000EAC;
	VtablePtr = 0x80000EB0;
	DCScreenPtr = 0x80000EB4;

	/* FKW - Core Features */
	FCIs = 0x80004030;
	DriftBikes = 0x80004031;
	DriftKarts = 0x80004032;

	/* FKW - Newbie Helper */
	BetterItems = 0x80004040;
	ExtraItem = 0x80004041;
	BulletTCs = 0x80004042;
	InstantRespawn = 0x80004043;
	AutoRespawnBoost = 0x80004044;
	InstantDraft = 0x80004045;

	/* FKW - Video Settings */
	ThirtyFPS = 0x80004050;
	FasterMenu = 0x80004051;
	Speedometer = 0x80004052;
	KCPMap = 0x80004053;
	MiiHeads = 0x80004054;
	TagsDist = 0x80004055;
	TimeDiff = 0x80004056;
	Bloom = 0x80004057;
	LightFlash = 0x80004058;
	FOVSetting = 0x80004059;
	TMCam = 0x8000405A;

	/* FKW - Audio Settings */
	CharVoices = 0x80004060;
	RaceMusic = 0x80004061;
	TransfMusic = 0x80004062;
	DistortedMusic = 0x80004063;
	BRSARPatch = 0x80004064;

}
