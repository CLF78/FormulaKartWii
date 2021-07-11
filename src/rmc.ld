SECTIONS {
	/* Base Functions */
	gameRegion = 0x80000003;
	OSLaunchCode = 0x8000318C;
	_directWriteArray = 0x80005F34;
	memset = 0x80006038;

	/* EVA Variables */
	GameMode = 0x800001B0;
	AlwaysWinVote = 0x800001B1;
	MirrorOn = 0x800001B2;
	TeamsOn = 0x800001B3;
	VehicleRestrict = 0x800001B4;
	TimerInstance = 0x800001C0;
	EnableRampUpStuff = 0x800001CC;
	ItemAmountArray = 0x800001D8;
	RandomInstance = 0x800001E4;
	Version = 0x800001FC;
	ItemStatusArray = 0x80000F98;

	/* Change Character Between Races */
	ScenePtr = 0x80000EA0;
	CupSelPtr = 0x80000EA4;
	CharSelPtr = 0x80000EA8;
	VRPtr = 0x80000EAC;
	VtablePtr = 0x80000EB0;
	DCScreenPtr = 0x80000EB4;

	/* Riivolution Options */
	FasterMenu = 0x80004000;
	MiiHeads = 0x80004001;
	NoMusic = 0x80004002;
	NoCharVoice = 0x80004003;
	BtGlitch = 0x80004004;
	TimeDiff = 0x80004005;
	Speedometer = 0x80004006;
	NoMultiChan = 0x80004007;
	ThirtyFPS = 0x8000400F;
}
