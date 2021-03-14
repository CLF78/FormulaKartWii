SECTIONS {
	/* Common Classes and Functions */
	SystemManager = 0x80386000;
	Racedata = 0x809BD728;
	Raceinfo = 0x809BD730;
	PlayerHolder = 0x809C18F8;
	Menudata = 0x809C1E38;
	RKNetController = 0x809C20D8;
	ItemHolder = 0x809C3618;
	ItemStructs = 0x809C36B8;

	PlayerGetControllerHolder = 0x805903F4;
	getPlayerById = 0x80590100;
	getPlayerPosition = 0x8059020C;

	NETSHA1Init = 0x801D24F4;
	NETSHA1Update = 0x801D2544;
	NETSHA1GetDigest = 0x801D25F8;

	SetPaneColor = 0x807EBF20;
	SetTextSrc = 0x805CDD00;

	playerCount = 0x809C38B8;
	isOnlineRace = 0x809C38B9;

	/* Codehandler Hooks */
	VIHook = 0x801BAB20;
	KPADHook = 0x80197AA8;
	GXDrawHook = 0x8016EB6C;
	GXFlushHook = 0x8016E6AC;
	OSSleepHook = 0x801AAAA0;
	AXNextFrameHook = 0x801265A0;

	/* Auto Strap Screen Skip */
	AutoStrapScreenSkip = 0x800077C8;

	/* Payload Hook */
	RelHook = 0x801A6D30;

	/* Base Functions */
	DVDOpen = 0x8015E2BC;
	DVDReadPrio = 0x8015E834;
	DVDClose = 0x8015E568;
	sprintf = 0x80011A2C;
	swprintf = 0x80017814;
	OSFatal = 0x801A4EC4;
	srand = 0x80011C90;
	rand = 0x80011C70;

	/* Exception Handler */
	ShowExceptions = 0x802A7404;
	ExcDispInfo = 0x802A7410;

	/* Wiimmfi */
	WiimmfiPatch1 = 0x800ED868;
	WiimmfiPatch2 = 0x800ECAAC;
	WiimmfiPatch3 = 0x800EE3A0;
	WiimmfiPatch4 = 0x801D4EFC;

	LoginRegion = 0x80384FD0;
	VSRegion = 0x80653644;
	VSRegion2 = 0x8065920C;
	VSRegion3 = 0x80659724;
	VSRegion4 = 0x8065A034;

	WiimmfiVersionString = 0x80276054;
	NaswiiURL = 0x8027A404;
	NaswiiURL2 = 0x8027A42C;
	NaswiiURL3 = 0x8027A4AC;
	NaswiiURL4 = 0x8027A450;
	AvailableURL = 0x8027AD68;
	GPCMURL = 0x8027B4D8;
	GPSPURL = 0x8027BEF0;
	MasterURL = 0x8027D091;
	NatnegURL = 0x8027DCAB;
	NatnegURL2 = 0x8027DCC7;
	NatnegURL3 = 0x8027DCE3;
	MSURL = 0x8027DE33;
	GSURL = 0x8027DEB7;

	/* 30 Second Time Limit */
	ThirtySecs = 0x8053EC8E;

	/* All Items Can Land */
	AICLUnk1 = 0x807A66C4;
	AICLUnk2 = 0x80796D30;
	NoItemLandingPoof = 0x80790EF0;
	ItemLandMega = 0x808B54D0;
	ItemLandGolden = 0x808B5500;
	ItemLandBill = 0x808B550C;
	ItemLandShock = 0x808B54B8;
	ItemLandPOW = 0x808B54F4;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A5BC4;
	BlueShellSpeed2 = 0x808A5C24;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A9CC7;
	ItemWindowCTR = 0x808A9C0A;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B59F8;
	CannonLandingFix = 0x8057855B;
	CannonSpeed = 0x805967B0;
	CannonSpeed2 = 0x805850C4;
	CannonSpeed3 = 0x805850D0;

	/* DC Bug Fix */
	DCFix = 0x8053F6C4;

	/* Disable Item Poof */
	NoItemPoofHook = 0x8079FE80;

	/* Replace Blooper with Triple FIBs */
	BlooperKiller = 0x807A92B0;
	BlooperHideModel = 0x808A589C;
	BlooperHideModel2 = 0x808A58A4;
	BlooperItemStruct = 0x808A5880;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807F4DB8;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x80791970;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x807AE8A8;

	/* Fast POW */
	POWTimer = 0x807B1DD3;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x808A10D8;
	FastMusicHook = 0x8070B2CC;
	FastMusicHook2 = 0x80711AD8;
	FastMusicHook3 = 0x80630090;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808D8070;
	GeoHitTableItemObj = 0x808D8088;
	GeoHitTableKartHook = 0x8082A478;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A5DBC;

	/* Inside Drift Bikes */
	KartParamHook = 0x80591FE8;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x80828EDC;

	/* Lap Counter */
	SetLapCount = 0x807EF76C;
	ColorFixHook = 0x807EF7E8;

	/* Show Times After Race */
	ShowTimesVS = 0x8085C914;
	ShowTimesWW = 0x8085D460;
	TimesFunc = 0x807F595C;

	/* Ultra UnCut */
	CKPTCheck = 0x8053511C;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807BA077;

	/* Remove Mushroom Bug 2 */
	RemoveFakeShroom = 0x807BA480;
	RemoveFakeShroom2 = 0x807BA484;

	/* Woodbox Modifier */
	WoodRespawn = 0x808D1290;
	WoodProb = 0x8076EE28;
	BushFunc = 0x80767328;

	/* Mega Flips Cars */
	MegaFlip = 0x8082AC03;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807BC630;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807BA160;
	SpecialItemHook = 0x80799FC8;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807BA5D0;

	/* Motion-Sensor Bombs */
	BombTimer = 0x807A5BF6;
	BombTimer2 = 0x807A4ACA;

	/* Time Limit Modifier */
	TimeLimit = 0x8053F3B8;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x80592128;
	FOVChange = 0x805793AC;

	/* Mega Thundercloud */
	MegaTCHook = 0x80580630;
	MegaFunc = 0x807986B4;

	/* Shells Never Break */
	ShellHitCount = 0x807B560C;
	ShellHitCount2 = 0x807B574C;
	ShellHitCount3 = 0x807B5E58;
	ShellHitCount4 = 0x807B5E6C;
	ShellHitCount5 = 0x807AEC9C;

	/* Starting Lap Modifier */
	StartingLapHook = 0x805340A0;
	NoPlayerFlags = 0x805340B0;
	JingleFixHook = 0x8070B2B8;
	LastLap = 0x80534BDC;
	LastLapLakitu = 0x80723CCC;
	NoLapFix = 0x80723D3C;
	LapSignFix2 = 0x80723D48;
	LakituBoardHook = 0x80723D54;
	TimeStoreHook = 0x80534B58;
	TimeStoreHook2 = 0x8053572C;
	TimeStoreHook3 = 0x80535798;
	FinishTimesHook = 0x8053438C;
	LapSignFixHook = 0x80534A18;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80567794;

	/* Banana Spinout Modifier */
	BananaDamage = 0x80573188;
	BlueSpinoutDmg = 0x805731C3;
	BombSpinoutDmg = 0x805731DB;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x80790C08;
	ItemLimits = 0x809C2F4C;

	/* Cycle Fixes - Coconut Mall */
	EscalatorFixHook = 0x808009C4;
	PiantaFixHook = 0x808021B4;

	/* Cycle Fixes - Dry Dry Ruins */
	PillarFixHook = 0x807FEE14;
	SandpitFixHook = 0x80687028;
	SandpitFix2 = 0x806872E8;
	SandpitFix3 = 0x8068787C;

	/* Cycle Fixes - Ghost Valley 2 */
	GV2Fix = 0x8080ADEE;

	/* Cycle Fixes - Grumble Volcano */
	RockFix = 0x806E3B52;
	RockFix2Hook = 0x80817F20;
	GeyserFixHook = 0x806C3B28;

	/* Cycle Fixes - Toad's Factory */
	ConveyorFixHook = 0x807FD3C4;

	/* Game Modes - Generic */
	SceneSwapHook = 0x80621E1C;
	HostFlagsHook = 0x8065AE70;
	GuestFlagsHook = 0x8065AF70;
	FlagResetHook = 0x800D1AB0;
	FlagResetHook2 = 0x800D1980;
	FlagResetHook3 = 0x800D1D64;
	FlagResetHook4 = 0x800D2CD0;
	FlagResetHook5 = 0x800CCDA8;
	BattleFixHook = 0x80860A8C;
	BattleFixHook2 = 0x8084FEF0;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x808534BB;
	RaceCountFix2 = 0x80853A38;
	RaceCountFix3 = 0x80853A40;
	RaceCountFix4 = 0x808528F0;
	RaceCountFix5 = 0x808529D0;

	/* Play VS Race Alone */
	NoCPU = 0x80853148;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x80534B50;
	RampUpSpeedFixHook = 0x8057B9B4;
	DriftFixHook = 0x8057E128;
	DriftFixHook2 = 0x8057DF1C;
	DriftFixHook3 = 0x8057E5A8;
	DriftFixHook4 = 0x8057EAA4;
	DriftFixHook5 = 0x8057F008;

	/* Game Mode - Teams */
	NoItemGlow = 0x807BD2BC;
	NoTeamInvincibility = 0x8053056C;
	TeamTCPass = 0x807B0BDC;

	/* Online Stuff */
	ForceCCHook = 0x80661404;
	FroomRaceCount = 0x806460BB;
	FroomRaceCount2 = 0x8064F51F;

	/* Remove WW Button */
	NoWWButton = 0x8064B983;
	NoWWButton2 = 0x8064BA10;
	NoWWButton3 = 0x8064BA38;
	NoWWButton4 = 0x8064BA50;
	NoWWButton5 = 0x8064BC13;
	NoWWButton6 = 0x8064BC3E;
	NoWWButton7 = 0x8064BCB6;
	NoWWButton8 = 0x8064BC4E;
	NoWWButton9 = 0x8064BCC2;

	/* Antifreeze */
	EVENTOverflowHook = 0x8065BBD4;
	MiiC = 0x808B3B00;
	NoLag = 0x80654B00;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x800912D4;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80719920;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80856560;

	/* Instant DC */
	WiiWheel = 0x803457E2;
	InstantDCHook = 0x8053F470;

	/* License Unlocker */
	LicenseUnlocker = 0x80549974;

	/* Points Modifier */
	PointsModifierHook = 0x8052EC38;

	/* Silent Controller Changing */
	NoControllerDC = 0x8061AF98;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x8038900C;
	FasterMenuHook2 = 0x80896830;
	FasterMenuHook3 = 0x80635670;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807EB160;

	/* No Music */
	NoMusicHook = 0x8009130C;

	/* No Character Voices */
	NoCharVoiceHook = 0x80716208;

	/* Force Battle Glitch */
	TagDistance = 0x808D3E14;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x80661E20;

	/* Show Time Difference */
	ItemAlertFixHook = 0x8060245C;
	GhostFileSkip = 0x807EE580;
	GhostFileSkip2 = 0x807EE5A4;
	TimeDiffPatchHook = 0x807EE5C0;
	TimeDiffPatchHook2 = 0x807EE5D8;
	TimeDiffMPFixHook = 0x80858444;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8062E058;
	CreateScreen = 0x80622D08;
	PushButton_HandleClick = 0x805BE358;
	PushButton_Vtable = 0x808B77B8;
	ChangeCharsHook2 = 0x80622E28;
	ChangeCharsHook3 = 0x8062E0D0;

	/* Force 30 FPS */
	FramerateHook = 0x80429454;
	FramerateHook2 = 0x802A40E9;

	/* Speedometer */
	SpeedoScreenElement = 0x808584D8;
	SpeedoUpdate = 0x8057C3A8;
	SpeedoTextParseNop = 0x805CDD34;
	SpeedoTextParse = 0x805CDD70;
	SpeedoParseSkip = 0x805CDE08;
	SpeedoNoPauseHook = 0x807EB574;

	/* Brake Drifting */
	BrakeDriftClassicHook = 0x8051F5F8;
	BrakeDriftGCNHook = 0x8052029C;
	BrakeDriftNunchuckHook = 0x80745CB4;
	BrakeDriftWheelHook = 0x80745F70;
	BrakeDriftMainHook = 0x8057ADEC;
	BrakeDriftSoundHook = 0x806FAFF8;
	BrakeDriftEffBikesHook = 0x80699C98;
	BrakeDriftEffKartsHook = 0x80698F50;
	DoBrakeDrift = 0x8057AE8C;
	BrakeDriftEffFunc = 0x806A19D8;
	BrakeDriftEffFunc2 = 0x806A1B68;

	/* Fast Falling */
	FastFallingHook = 0x8059678C;
	FastFallingHook2 = 0x80597390;

	/* Item Rain */
	ItemRainMainHook = 0x80535C7C;
	KeepTheRain = 0x8079A17C;
	ItemRainExplosionsHook = 0x80786F80;
	FreeExpiredSendEntriesPatchHook = 0x8065BB40;
	AddEntryPatchHook = 0x8065B870;
	ItemRainCollisionThingyHook = 0x807A1C64;
	ImportRecvEntriesPatchHook = 0x8065BDF8;
	DisableEVENTThingy2 = 0x80797018;
	DisableEVENTThingy = 0x807A6C74;
	SendNextRACEPacketPatch = 0x80657EAB;
	PacketCreatorPatch = 0x8065322A;
	ItemRainTrackLoadPatchHook = 0x80540864;
	memcmp = 0x8000F314;
	ItemRainCollisionThingyHook2 = 0x807A0FF4;
	ItemRainCollisionThingyHook3 = 0x807A1008;
}