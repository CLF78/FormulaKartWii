SECTIONS {
	/* Base Functions */
	DVDOpen = 0x8015E1DC;
	DVDReadPrio = 0x8015E754;
	DVDClose = 0x8015E488;
	sprintf = 0x80011950;
	swprintf = 0x80017738;
	OSFatal = 0x801A4DE4;

	/* Codehandler Hooks */
	VIHook = 0x801BAA40;
	KPADHook = 0x801979C8;
	GXDrawHook = 0x8016EA8C;
	GXFlushHook = 0x8016E5CC;
	OSSleepHook = 0x801AA9C0;
	AXNextFrameHook = 0x801264C0;

	/* Common Classes and Functions */
	SystemManager = 0x80385980;
	Racedata = 0x809BC788;
	Raceinfo = 0x809BC790;
	ArchiveRoot = 0x809BC798;
	PlayerHolder = 0x809C0958;
	KartParam = 0x809C0978;
	DriverParam = 0x809C097C;
	Menudata = 0x809C0E98;
	RKNetController = 0x809C1138;
	RKNetItemHandler = 0x809C1158;
	ItemHolder = 0x809C2678;
	ItemStructs = 0x809C2718;
	ItemStructsEX = 0x809C1FA8;
	ScreenHUD = 0x809C36E0;

	PlayerGetControllerHolder = 0x8058FD74;
	getPlayerById = 0x8058FA80;
	getPlayerPosition = 0x8058FB8C;

	NETSHA1Init = 0x801D2414;
	NETSHA1Update = 0x801D2464;
	NETSHA1GetDigest = 0x801D2518;

	SetPaneColor = 0x807EB58C;
	SetTextSrc = 0x805CD5DC;
	SetMatText = 0x8063D328;

	playerCount = 0x809C2918;
	isOnlineRace = 0x809C2919;

	UtilRandomSeed = 0x800F2DE8;
	UtilRandint = 0x800F2E00;

	ptmf_test = 0x80021308;
	ptmf_scall = 0x80021374;

	SubtractTimers = 0x807EDECC;

	RandomConstruct = 0x80554DE4;
	RandomNextLimited = 0x80554F4C;
	RandomRefresh = 0x80554E50;

	/* 30 FPS */
	ThirtyFPSHook1 = 0x80009998;
	ThirtyFPSHook2 = 0x80009207;
	ThirtyFPSHook3 = 0x8000900B;
	ThirtyFPSHook4 = 0x8051A914;
	ThirtyFPSHook5 = 0x8051ACBC;
	ThirtyFPSHook6 = 0x8051ACAB;

	/* 30 Second Time Limit */
	ThirtySecs = 0x8053E60E;

	/* All Items Can Land */
	AICLUnk1 = 0x807A5D30;
	AICLUnk2 = 0x8079639C;
	NoItemLandingPoof = 0x8079055C;
	ItemLandMega = 0x808B4630;
	ItemLandFeather = 0x808B4648;
	ItemLandGolden = 0x808B4660;
	ItemLandBill = 0x808B466C;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x8066148C;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x800911F4;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A8E27;
	ItemWindowCTR = 0x808A8D6A;

	/* Banana/Blue/Bomb Spinout Modifier */
	BananaDamage = 0x80572B08;
	BlueSpinoutDmg = 0x80572B43;
	BombSpinoutDmg = 0x80572B5B;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A4D24;
	BlueShellSpeed2 = 0x808A4D84;

	/* Bomb Lag Fix */
	NoFakeBomb = 0x80572010;
	NoDmgChange = 0x805698E8;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B4B58;
	CannonLandingFixHook = 0x80577EDC;
	CannonSpeed = 0x80584A44;
	CannonSpeed2 = 0x80584A50;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8062D7A4;
	CreateScreen = 0x80622454;
	PushButton_HandleClick = 0x805BDCD8;
	PushButton_Vtable = 0x808B6918;
	ChangeCharsHook2 = 0x80622574;
	ChangeCharsHook3 = 0x8062D81C;

	/* Crazy Eight */
	CrazyEightEnableCircling = 0x808A4AD0;
	ItemAssignerCall = 0x807910B4;
	ItemAssignerCall2 = 0x807BBB00;
	ItemAssignerStackFixHook = 0x80795470;
	ItemAssignerHook2 = 0x80795494;
	ItemAssignerHook3 = 0x80795498;
	ItemAssignerHook4 = 0x80795520;
	ItemAssignerHook5 = 0x8079553C;
	ItemAssignerStackFix2Hook = 0x80795584;
	ItemUsageFixHook = 0x80793EF0;
	ItemUsageFixHook2 = 0x80794060;
	DestroyItem = 0x807A5D6C;

	/* Credits Button */
	CreditsButton = 0x80850937;

	/* Cycle Fixes - Coconut Mall */
	EscalatorFixHook = 0x80800030;
	PiantaFixHook = 0x80801820;

	/* Cycle Fixes - Dry Dry Ruins */
	PillarFixHook = 0x807FE480;
	SandpitFixHook = 0x80686694;
	SandpitFix2 = 0x806872E8;
	SandpitFix3 = 0x80686EE8;

	/* Cycle Fixes - Ghost Valley 2 */
	GV2Fix = 0x8080A45A;

	/* Cycle Fixes - Grumble Volcano */
	RockFix = 0x806E31BE;
	RockFix2Hook = 0x8081758C;
	GeyserFixHook = 0x806C3194;

	/* Cycle Fixes - Toad's Factory */
	ConveyorFixHook = 0x807FCA30;

	/* DC Bug Fix */
	DCFix = 0x8053F034;

	/* Disable Item Poof */
	NoItemPoof = 0x80795C2C;
	NoItemPoof2Hook = 0x807A10C0;
	NoItemPoof3Hook = 0x807A10D0;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80718F8C;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807F4433;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80855BCC;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x808A4C90;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x80790FDC;

	/* Dynamic Item Sizing */
	DynamicSizingHook = 0x807856D0;
	DynamicSizingHook2 = 0x807D0DAC;
	DynamicSizingHook3 = 0x8079E2B0;
	DynamicSizingHook4 = 0x8079E688;
	DynamicSizingHook7 = 0x8079D588;
	BombVisualSizeHook = 0x807A3CC8;
	BombVisualSizeHook2 = 0x807A5728;
	BombSizeHook2 = 0x807A3DFC;
	BombSizeHook3 = 0x807A4CE8;
	BlueVisualSizeHook = 0x807AD8D0;
	BlueSizeHook2 = 0x807AD9F0;
	BlueExplosionFunc = 0x807AD5C4;

	/* Exception Handler */
	ShowExceptions = 0x802A6D84;

	/* Fast POW */
	NoPOWDelay = 0x807B1438;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x8038898C;
	FasterMenuHook2 = 0x80895E80;
	FasterMenuHook3 = 0x80634DBC;

	/* Faster Score Increase */
	ScoreSkip = 0x807F4E63;
	NoTransition = 0x8085B60C;

	/* Feather Item */
	FeatherUseFunc = 0x808A49F4;
	FeatherOnlineFixHook = 0x807963F8;
	FeatherFilename = 0x808A4A18;
	FeatherSpeed = 0x808B4D84;
	GenerateEVENT = 0x8079B88C;
	SubtractItem = 0x807BBFE8;
	FeatherInvisWallHook = 0x805B61E8;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x808A0238;
	FastMusicHook = 0x8070A938;
	FastMusicHook2 = 0x80711144;
	FastMusicHook3 = 0x8062F7DC;

	/* Force Battle Glitch */
	TagDistance = 0x808D2F64;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x805344D0;
	RampUpSpeedFixHook = 0x8057B334;
	DriftSpeedHook = 0x8057D898;
	DriftSpeedHook2 = 0x8057DAA4;
	DriftSpeedHook3 = 0x8057DF24;
	DriftSpeedHook4 = 0x8057E420;
	DriftSpeedHook5 = 0x8057E984;
	BoostAccelHook = 0x80588834;
	BrakeDriftClassicHook = 0x8051EF78;
	BrakeDriftGCNHook = 0x8051FC1C;
	BrakeDriftNunchuckHook = 0x80745320;
	BrakeDriftWheelHook = 0x807455DC;
	BrakeDriftMainHook = 0x8057A76C;
	BrakeDriftSoundHook = 0x806FA664;
	BrakeDriftEffBikesHook = 0x80699304;
	BrakeDriftEffKartsHook = 0x806985BC;
	BrakeDriftEffFunc = 0x806A1044;
	BrakeDriftEffFunc2 = 0x806A11D4;
	FastFallingHook = 0x8059610C;
	FastFallingHook2 = 0x80596D10;

	/* Game Mode - Teams */
	NoItemGlow = 0x807BC928;
	NoTeamInvincibility = 0x80571F90;
	NoTeamInvincibility2 = 0x80572C18;
	NoTeamInvincibility3 = 0x8068D944;
	NoTeamInvincibility4 = 0x807B0248;
	NoTeamInvincibility5 = 0x8056F6B0;
	NoTeamInvincibility6 = 0x8068D988;

	/* Game Modes - Generic */
	SceneSwapHook = 0x80621568;
	HostFlagsHook = 0x8065A4DC;
	GuestFlagsHook = 0x8065A5DC;
	FlagResetHook = 0x800D19D0;
	FlagResetHook2 = 0x800D18A0;
	FlagResetHook3 = 0x800D1C84;
	FlagResetHook4 = 0x800D2BF0;
	FlagResetHook5 = 0x800CCCC8;
	BattleFixHook = 0x808600F8;
	BattleFixHook2 = 0x8084F55C;
	TimerManagerHook = 0x805355FC;
	VehicleRestrictionHook = 0x80844C10;
	MessageButtons = 0x805DBCC7;
	MessageButtons2Hook = 0x805DACBC;
	MessageButtons3Hook = 0x805DA658;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808D71C0;
	GeoHitTableItemObj = 0x808D71D8;
	GeoHitTableKartHook = 0x80829AE4;
	GeyserCollFix = 0x80572D47;

	/* Glitch Prevention */
	DisableWallrideHook = 0x8057B998;
	DisableHWG = 0x80594D6B;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A4F1C;

	/* Host Version Check */
	GuestSendHook = 0x800DBC58;
	HostCheckHook = 0x800DC3BC;
	DWCiCheckResvCommand = 0x800DE5D8;

	/* Impervious TC */
	ImperviousTCHook = 0x807AF114;

	/* Inside Drift Bikes */
	KartParamHook = 0x80591968;

	/* Instant DC */
	WiiWheel = 0x80345162;
	InstantDCHook = 0x8053EDF0;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x80828548;
	ItemBoxFix = 0x8076C44C;
	ItemBoxFix2 = 0x8076C583;
	ItemBoxFix3Hook = 0x8076D374;

	/* Item Textures */
	ItemTexturesHook = 0x8086015C;
	OriginalTextures = 0x808AE920;
	DoubleShroom = 0x808AEB07;

	/* Lap Counter */
	ColorFixHook = 0x807EEE54;
	PositionFixHook = 0x807EEED0;

	/* License Unlocker */
	LicenseUnlocker = 0x805492F4;

	/* MK7 Shock Squishing */
	SquishCheckHook = 0x8056F6CC;
	SquishFunc = 0x8056924B;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x80790274;
	ItemLimits = 0x809C1FAC;

	/* Mega Flips Cars */
	MegaFlip = 0x8082A26F;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x80591AA8;
	FOVChange = 0x80578D38;

	/* Mega Thundercloud */
	MegaTCHook = 0x8057FFB0;
	MegaFunc = 0x80797D20;

	/* Message Patch */
	MSGPatchHook = 0x8051A6B0;
	MSGPatchHook2 = 0x805F84B3;
	MSGPatchHook3 = 0x80854AB4;
	MSGPatchHook4 = 0x807F81C4;
	GetSceneHolderThing = 0x8051B850;
	LoadArchive = 0x8053FDD0;
	AddFileToList = 0x8051A3D8;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807EA7CC;

	/* Motion-Sensor Bombs */
	BombTimer = 0x807A5262;
	BombTimer2 = 0x807A4136;

	/* Newbie Helper */
	RespawnHelperHook = 0x805737A8;
	RespawnHelperHook2 = 0x805795A0;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807B9C3C;

	/* No Character Voices */
	NoCharVoiceHook = 0x80715874;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80567114;
	NoRespawnInv = 0x80566FCE;
	StarInBullet = 0x8057FBF2;
	ShroomInBullet = 0x8057ED62;
	StarWhenHit = 0x8057FC24;
	ShroomWhenHit = 0x8057EDD0;

	/* No Multi Channel Track Music */
	NoMultiChannelHook = 0x806FA198;
	NoMultiChannelHook2 = 0x800A4E38;
	FirstCall = 0x80718C58;

	/* No Music */
	NoMusicHook = 0x8009122C;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x80852B27;
	RaceCountFix2 = 0x808530A4;
	RaceCountFix3 = 0x808530AC;
	RaceCountFix4 = 0x80851F5C;
	RaceCountFix5 = 0x8085203C;

	/* Online Stuff */
	ForceCCHook = 0x80660A70;
	FroomRaceCount = 0x80645727;
	FroomRaceCount2 = 0x8064EB8B;

	/* POW Yourself in 1st */
	POWSelfHook = 0x807B149C;

	/* Pause Menu Fix */
	PauseMenuScreenHook = 0x8062BDB8;
	PauseMenuScreenHook2 = 0x8062BEFC;

	/* Payload Hook */
	RelHook = 0x801A6C50;

	/* Play VS Race Alone */
	NoCPU = 0x808527B4;

	/* Points Modifier */
	PointsModifierHook = 0x8052E5B8;

	/* Prediction Removal */
	PredictionRemoval = 0x80891178;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807BBC9C;

	/* Red Shell Target Modifier */
	TargetWhileRespawn = 0x80590C16;
	TargetWhileHit = 0x80590C63;
	TargetPositionHook = 0x807B2F0C;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807B96E3;
	RemoveFakeShroom = 0x807B9AEC;
	RemoveFakeShroom2 = 0x807B9AF0;
	RemoveFakeShroom3 = 0x807B9790;

	/* Remove WW Button */
	NoWWButton = 0x8064AFEF;
	NoWWButton2 = 0x8064B07C;
	NoWWButton3 = 0x8064B0A4;
	NoWWButton4 = 0x8064B0BC;
	NoWWButton5 = 0x8064B27F;
	NoWWButton6 = 0x8064B2AA;
	NoWWButton7 = 0x8064B322;
	NoWWButton8 = 0x8064B2BA;
	NoWWButton9 = 0x8064B32E;

	/* Set Default Drift Type */
	DefaultDriftType = 0x80545CEC;

	/* Shells Never Break */
	ShellHitCount = 0x807B5580;
	ShellHitCount2 = 0x807A3178;

	/* Show Time Difference */
	TimeDiffPatchHook = 0x807EDBF4;
	TimeDiffApplyHook = 0x80855924;

	/* Show Timers */
	TimerShow = 0x8064F8C0;

	/* Show Times After Race */
	ShowTimesVS = 0x8085BF78;
	ShowTimesWW = 0x8085CACC;
	TimesFunc = 0x807F4FC8;
	TimePrintHook = 0x807F508C;

	/* Silent Controller Changing */
	NoControllerDC = 0x8061A70C;

	/* Speedometer */
	SpeedoTextParseNop = 0x805CD610;
	SpeedoTextParse = 0x805CD64C;
	SpeedoParseSkip = 0x805CD6E4;
	SpeedoNoPauseHook = 0x807EABE0;

	/* Starting Lap Modifier */
	LapCount1 = 0x80532227;
	LapCount2 = 0x8053302B;
	LapCount3 = 0x80533CC3;
	LapCount4 = 0x8053452F;
	LapCount5 = 0x8053465B;
	LakituBoardHook = 0x807233A8;

	/* Super Miniturbo Multiplier */
	SMTMultiplier = 0x808B4E30;
	SMTMinimum = 0x808B4E26;

	/* Time Limit Modifier */
	TimeLimit = 0x8053E724;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807B97CC;
	SpecialItemHook = 0x80799754;
	ItemAmountHook1 = 0x8065BD40;
	ItemAmountHook2 = 0x807BBFC4;

	/* Ultra UnCut */
	CKPTCheck = 0x80534A98;

	/* VS Menu Skip */
	VSMenuSkipHook = 0x80851A98;
	VSMenuSkipHook2 = 0x805FB068;
	VSMenuSkip3 = 0x8062C9A8;
	VSMenuSkip4 = 0x8062FE3F;
	VSMenuReturnHook = 0x80852188;
	VSMenuReturn = 0x8084F1A4;
	VSMenuReturnHook2 = 0x808520B4;
	VSMenuReturn2Func = 0x8083758C;
	VSMenuSkipMulti = 0x80602ABF;
	NoGhostLoading = 0x80620928;

	/* Wiimmfi */
	WiimmfiPatch1 = 0x800ED788;
	WiimmfiPatch2 = 0x800EC9CC;
	WiimmfiPatch3 = 0x800EE2C0;
	WiimmfiPatch4 = 0x801D4E1C;

	LoginRegion = 0x80384950;
	VSRegion = 0x80652CB0;
	VSRegion2 = 0x80658878;
	VSRegion3 = 0x80658D90;
	VSRegion4 = 0x806596EC;

	WiimmfiVersionString = 0x802759F4;
	WiimmfiURLs = 0x80279DA4;

	/* Woodbox Modifier */
	WoodRespawn = 0x808D03E0;
	WoodProb = 0x8076E494;
	BushFunc = 0x80766994;
}
