SECTIONS {
	/* Common Classes and Functions */
	SystemManager = 0x80374020;
	Racedata = 0x809ABD68;
	Raceinfo = 0x809ABD70;
	PlayerHolder = 0x809AFF38;
	Menudata = 0x809B0478;
	RKNetController = 0x809B0718;
	ItemHolder = 0x809B1C58;
	ItemStructs = 0x80893E78;

	PlayerGetControllerHolder = 0x8057E44C;
	getPlayerById = 0x8057E158;
	getPlayerPosition = 0x8057E264;

	NETSHA1Init = 0x801D2850;
	NETSHA1Update = 0x801D28A0;
	NETSHA1GetDigest = 0x801D2954;

	SetPaneColor = 0x807DA2E0;
	SetTextSrc = 0x805BBCC0;

	playerCount = 0x809B1EF8;
	isOnlineRace = 0x809B1EF9;

	/* Codehandler Hooks */
	VIHook = 0x801BAE7C;
	KPADHook = 0x80197E04;
	GXDrawHook = 0x8016EC08;
	GXFlushHook = 0x8016E748;
	OSSleepHook = 0x801AAEF0;
	AXNextFrameHook = 0x80126618;

	/* Auto Strap Screen Skip */
	AutoStrapScreenSkip = 0x80007894;

	/* Payload Hook */
	RelHook = 0x801A708C;

	/* Base Functions */
	DVDOpen = 0x8015E334;
	DVDReadPrio = 0x8015E8AC;
	DVDClose = 0x8015E5E0;
	sprintf = 0x80011A94;
	swprintf = 0x8001787C;
	OSFatal = 0x801A5220;
	srand = 0x80011CF8;
	rand = 0x80011CD8;

	/* Exception Handler */
	ShowExceptions = 0x80295404;
	ExcDispInfo = 0x80295410;

	/* Wiimmfi */
	WiimmfiPatch1 = 0x800ED8E0;
	WiimmfiPatch2 = 0x800ECB24;
	WiimmfiPatch3 = 0x800EE418;
	WiimmfiPatch4 = 0x801D5258;

	LoginRegion = 0x80372FD0;
	VSRegion = 0x8064195C;
	VSRegion2 = 0x80647524;
	VSRegion3 = 0x80647A3C;
	VSRegion4 = 0x80648398;

	WiimmfiVersionString = 0x80263E34;
	NaswiiURL = 0x802682B4;
	NaswiiURL2 = 0x802682DC;
	NaswiiURL3 = 0x8026835C;
	NaswiiURL4 = 0x80268300;
	AvailableURL = 0x80268C18;
	GPCMURL = 0x80269388;
	GPSPURL = 0x80269DA0;
	MasterURL = 0x8026AF41;
	NatnegURL = 0x8026BB5B;
	NatnegURL2 = 0x8026BB77;
	NatnegURL3 = 0x8026BB93;
	MSURL = 0x8026BCE3;
	GSURL = 0x8026BD67;

	/* 30 Second Time Limit */
	ThirtySecs = 0x8052CCE6;

	/* All Items Can Land */
	AICLUnk1 = 0x80794A84;
	AICLUnk2 = 0x807850F0;
	NoItemLandingPoof = 0x8077F2B0;
	ItemLandMega = 0x808A3948;
	ItemLandGolden = 0x808A3978;
	ItemLandBill = 0x808A3984;
	ItemLandShock = 0x808A3930;
	ItemLandPOW = 0x808A396C;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x80894024;
	BlueShellSpeed2 = 0x80894084;

	/* BRCTR Redirector */
	LapNumberCTR = 0x80898127;
	ItemWindowCTR = 0x8089806A;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808A3E70;
	CannonLandingFix = 0x805665B3;
	CannonSpeed = 0x80584808;
	CannonSpeed2 = 0x8057311C;
	CannonSpeed3 = 0x80573128;

	/* DC Bug Fix */
	DCFix = 0x8052D71C;

	/* Disable Item Poof */
	NoItemPoofHook = 0x8078E240;

	/* Replace Blooper with Triple FIBs */
	BlooperKiller = 0x80797670;
	BlooperHideModel = 0x80893CFC;
	BlooperHideModel2 = 0x80893D04;
	BlooperItemStruct = 0x80893CE0;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807E3178;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x8077FD30;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x8079CC68;

	/* Fast POW */
	POWTimer = 0x807A0193;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x8088F538;
	FastMusicHook = 0x806F9674;
	FastMusicHook2 = 0x806FFE80;
	FastMusicHook3 = 0x8061E488;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808C6508;
	GeoHitTableItemObj = 0x808C6520;
	GeoHitTableKartHook = 0x80818838;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x8089421C;

	/* Inside Drift Bikes */
	KartParamHook = 0x80580040;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x8081729C;

	/* Lap Counter */
	SetLapCount = 0x807DDB2C;
	ColorFixHook = 0x807DDBA8;

	/* Show Times After Race */
	ShowTimesVS = 0x8084ACD4;
	ShowTimesWW = 0x8084B820;
	TimesFunc = 0x807E3D1C;

	/* Ultra UnCut */
	CKPTCheck = 0x80523174;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807A8437;

	/* Remove Mushroom Bug 2 */
	RemoveFakeShroom = 0x807A8840;
	RemoveFakeShroom2 = 0x807A8844;

	/* Woodbox Modifier */
	WoodRespawn = 0x808BF728;
	WoodProb = 0x8075D1E8;
	BushFunc = 0x807556E8;

	/* Mega Flips Cars */
	MegaFlip = 0x80818FC3;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807AA9F0;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807A8520;
	SpecialItemHook = 0x80788388;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807A8990;

	/* Motion-Sensor Bombs */
	BombTimer = 0x80793FB6;
	BombTimer2 = 0x80792E8A;

	/* Time Limit Modifier */
	TimeLimit = 0x8052D410;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x80580180;
	FOVChange = 0x80567404;

	/* Mega Thundercloud */
	MegaTCHook = 0x8056E688;
	MegaFunc = 0x80776A74;

	/* Shells Never Break */
	ShellHitCount = 0x807A39CC;
	ShellHitCount2 = 0x807A3B0C;
	ShellHitCount3 = 0x807A4218;
	ShellHitCount4 = 0x807A422C;
	ShellHitCount5 = 0x8079D05C;

	/* Starting Lap Modifier */
	StartingLapHook = 0x805220F8;
	NoPlayerFlags = 0x80522108;
	JingleFixHook = 0x806F9660;
	LastLap = 0x80522C34;
	LastLapLakitu = 0x80712074;
	NoLapFix = 0x807120E4;
	LapSignFix2 = 0x807120F0;
	LakituBoardHook = 0x807120FC ;
	TimeStoreHook = 0x80522BB0;
	TimeStoreHook2 = 0x80523784;
	TimeStoreHook3 = 0x805237F0;
	FinishTimesHook = 0x805223E4;
	LapSignFixHook = 0x80522A70;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x805557EC;

	/* Banana Spinout Modifier */
	BananaDamage = 0x805611E0;
	BlueSpinoutDmg = 0x8056121B;
	BombSpinoutDmg = 0x80561233;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x8077EFC8;
	ItemLimits = 0x809B1584;

	/* Cycle Fixes - Coconut Mall */
	EscalatorFixHook = 0x8087EED84;
	PiantaFixHook = 0x807F0574;

	/* Cycle Fixes - Dry Dry Ruins */
	PillarFixHook = 0x807ED1D4;
	SandpitFixHook = 0x806753D0;
	SandpitFix2 = 0x80675690;
	SandpitFix3 = 0x80675C24;

	/* Cycle Fixes - Ghost Valley 2 */
	GV2Fix = 0x807F91AE;

	/* Cycle Fixes - Grumble Volcano */
	RockFix = 0x806D1EFA;
	RockFix2Hook = 0x808062E0;
	GeyserFixHook = 0x806B1ED0;

	/* Cycle Fixes - Toad's Factory */
	ConveyorFixHook = 0x807EB784;

	/* Game Modes - Generic */
	SceneSwapHook = 0x80610214;
	HostFlagsHook = 0x80649188;
	GuestFlagsHook = 0x80649288;
	FlagResetHook = 0x800D1B10;
	FlagResetHook2 = 0x800D19E0;
	FlagResetHook3 = 0x800D1DC4;
	FlagResetHook4 = 0x800D2D30;
	FlagResetHook5 = 0x800CCE08;
	BattleFixHook = 0x8084EE4C;
	BattleFixHook2 = 0x8083E2B0;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x8084187B;
	RaceCountFix2 = 0x80841DF8;
	RaceCountFix3 = 0x80841E00;
	RaceCountFix4 = 0x80840CB0;
	RaceCountFix5 = 0x80840D90;

	/* Play VS Race Alone */
	NoCPU = 0x80841508;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x80522BA8;
	RampUpSpeedFixHook = 0x80569A0C;
	DriftFixHook = 0x8056C180;
	DriftFixHook2 = 0x8056BF74;
	DriftFixHook3 = 0x8056C600;
	DriftFixHook4 = 0x8056CAFC;
	DriftFixHook5 = 0x8056D060;

	/* Game Mode - Teams */
	NoItemGlow = 0x807AB67C;
	NoTeamInvincibility = 0x8051E5C4;

	/* Online Stuff */
	ForceCCHook = 0x8064F71C;
	FroomRaceCount = 0x806343D3;
	FroomRaceCount2 = 0x8063D837;

	/* Remove WW Button */
	NoWWButton = 0x80639C9B;
	NoWWButton2 = 0x80639D28;
	NoWWButton3 = 0x80639D50;
	NoWWButton4 = 0x80639D68;
	NoWWButton5 = 0x80639F2B;
	NoWWButton6 = 0x80639F56;
	NoWWButton7 = 0x80639FCE;
	NoWWButton8 = 0x80639F66;
	NoWWButton9 = 0x80639FDA;

	/* Antifreeze */
	EVENTOverflowHook = 0x80649EEC;
	MiiC = 0x808A1F78;
	NoLag = 0x80642E18;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x80091334;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80707CC8;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80844920;

	/* Instant DC */
	WiiWheel = 0x803337E2;
	InstantDCHook = 0x8052D4C8;

	/* License Unlocker */
	LicenseUnlocker = 0x805379CC;

	/* Points Modifier */
	PointsModifierHook = 0x8051CC90;

	/* Silent Controller Changing */
	NoControllerDC = 0x806093B8;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x8037702C;
	FasterMenuHook2 = 0x80885158;
	FasterMenuHook3 = 0x80623A68;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807D9520;

	/* No Music */
	NoMusicHook = 0x8009136C;

	/* No Character Voices */
	NoCharVoiceHook = 0x807045B0;

	/* Force Battle Glitch */
	TagDistance = 0x808C22AC;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x80650138;

	/* Show Time Difference */
	ItemAlertFixHook = 0x805F087C;
	GhostFileSkip = 0x807DC940;
	GhostFileSkip2 = 0x807DC964;
	TimeDiffPatchHook = 0x807DC980;
	TimeDiffPatchHook2 = 0x807DC998;
	TimeDiffMPFixHook = 0x80846804;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8061C450;
	CreateScreen = 0x80611100;
	PushButton_HandleClick = 0x805AC3B0;
	PushButton_Vtable = 0x808A5C30;
	ChangeCharsHook2 = 0x80611220;
	ChangeCharsHook3 = 0x8061C4C8;

	/* Force 30 FPS */
	FramerateHook = 0x80417474;

	/* Speedometer */
	SpeedoScreenElement = 0x80846898;
	SpeedoUpdate = 0x8056A400;
	SpeedoTextParseNop = 0x805BBCF4;
	SpeedoTextParse = 0x805BBD30;
	SpeedoParseSkip = 0x805BBDC8;
	SpeedoNoPauseHook = 0x807D9934;

	/* Brake Drifting */
	BrakeDriftClassicHook = 0x8050D61C;
	BrakeDriftGCNHook = 0x8050E2C0;
	BrakeDriftNunchuckHook = 0x80734074;
	BrakeDriftWheelHook = 0x80734330;
	BrakeDriftMainHook = 0x80568E44;
	BrakeDriftSoundHook = 0x806E93A0;
	BrakeDriftEffBikesHook = 0x80688040;
	BrakeDriftEffKartsHook = 0x806872F8;
	DoBrakeDrift = 0x80568EE4;
	BrakeDriftEffFunc = 0x8068FD80;
	BrakeDriftEffFunc2 = 0x8068FF10;

	/* Fast Falling */
	FastFallingHook = 0x805847E4;
	FastFallingHook2 = 0x805853E8;

	/* Item Rain */
	ItemRainMainHook = 0x80523CD4;
	KeepTheRain = 0x8078853C;
}