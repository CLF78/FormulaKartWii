SECTIONS {
	/* Common Classes and Functions */
	SystemManager = 0x80385980;
	Racedata = 0x809BC788;
	Raceinfo = 0x809BC790;
	PlayerHolder = 0x809C0958;
	Menudata = 0x809C0E98;
	RKNetController = 0x809C1138;
	ItemHolder = 0x809C2678;
	ItemStructs = 0x809C2718;

	NETSHA1Init = 0x801D2414;
	NETSHA1Update = 0x801D2464;
	NETSHA1GetDigest = 0x801D2518;

	SetPaneColor = 0x807EB58C;
	SetTextSrc = 0x805CD5DC;

	isOnlineRace = 0x809C2919;

	/* Codehandler Hooks */
	VIHook = 0x801BAA40;
	KPADHook = 0x801979C8;
	GXDrawHook = 0x8016EA8C;
	GXFlushHook = 0x8016E5CC;
	OSSleepHook = 0x801AA9C0;
	AXNextFrameHook = 0x801264C0;

	/* Auto Strap Screen Skip */
	AutoStrapScreenSkip = 0x800077C8;

	/* Payload Hook */
	RelHook = 0x801A6C50;

	/* Base Functions */
	DVDOpen = 0x8015E1DC;
	DVDReadPrio = 0x8015E754;
	DVDClose = 0x8015E488;
	sprintf = 0x80011950;
	swprintf = 0x80017738;
	OSFatal = 0x801A4DE4;

	/* Exception Handler */
	ShowExceptions = 0x802A6D84;
	ExcDispInfo = 0x802A6D90;

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
	NaswiiURL = 0x80279DA4;
	NaswiiURL2 = 0x80279DCC;
	NaswiiURL3 = 0x80279E4C;
	NaswiiURL4 = 0x80279DF0;
	AvailableURL = 0x8027A708;
	GPCMURL = 0x8027AE78;
	GPSPURL = 0x8027B890;
	MasterURL = 0x8027CA31;
	NatnegURL = 0x8027D64B;
	NatnegURL2 = 0x8027D667;
	NatnegURL3 = 0x8027D683;
	MSURL = 0x8027D7D3;
	GSURL = 0x8027D857;

	/* 30 Second Time Limit */
	ThirtySecs = 0x8053E60E;

	/* All Items Can Land */
	AICLUnk1 = 0x807A5D30;
	AICLUnk2 = 0x8079639C;
	NoItemLandingPoof = 0x8079055C;
	ItemLandMega = 0x808B4630;
	ItemLandGolden = 0x808B4660;
	ItemLandBill = 0x808B466C;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A4D24;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A8E27;
	ItemWindowCTR = 0x808A8D6A;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B4B58;
	CannonLandingFix = 0x80577EDB;
	CannonSpeed = 0x80596130;
	CannonSpeed2 = 0x80584A44;
	CannonSpeed3 = 0x80584A50;

	/* DC Bug Fix */
	DCFix = 0x8053F044;

	/* Disable Item Poof */
	NoItemPoof = 0x80795C2C;

	/* Replace Blooper with Triple FIBs */
	BlooperKiller = 0x807A891C;
	BlooperHideModel = 0x808A49FC;
	BlooperHideModel2 = 0x808A4A04;
	BlooperItemStruct = 0x808A49E0;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807F4424;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x80790FDC;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x807ADF14;

	/* Fast POW */
	POWTimer = 0x807B143F;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x808A0238;
	FastMusicHook = 0x8070A938;
	FastMusicHook2 = 0x80711144;
	FastMusicHook3 = 0x8062F7DC;

	/* GeoHit Redirector */
	GeoHitTableItem = 0x808D71C0;
	GeoHitTableItemObj = 0x808D71D8;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A4F1C;

	/* Inside Drift Bikes */
	KartParamHook = 0x80591968;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x80828548;

	/* Lap Counter */
	SetLapCount = 0x807EEDD8;
	ColorFixHook = 0x807EEE54;

	/* Show Times After Race */
	ShowTimesVS = 0x8085BF80;
	ShowTimesWW = 0x8085CACC;
	TimesFunc = 0x807F4FC8;

	/* Ultra UnCut */
	CKPTCheck = 0x80534A9C;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807B96E3;

	/* Remove Mushroom Bug 2 */
	RemoveFakeShroom = 0x807B9AEC;
	RemoveFakeShroom2 = 0x807B9AF0;

	/* Woodbox Modifier */
	WoodRespawn = 0x808D03E0;
	WoodProb = 0x8076E494;
	BushFunc = 0x80766994;

	/* Mega Flips Cars */
	MegaFlip = 0x8082A26F;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807BBC9C;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807B97CC;
	SpecialItemHook = 0x80799634;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807B9C3C;

	/* Motion-Sensor Bombs */
	BombTimer = 0x807A5262;
	BombTimer2 = 0x807A4136;

	/* Time Limit Modifier */
	TimeLimit = 0x8053E724;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x80591AA8;
	FOVChange = 0x80578D2C;

	/* Mega Thundercloud */
	MegaTCHook = 0x8057FFB0;
	MegaFunc = 0x80797D20;

	/* Shells Never Break */
	ShellHitCount = 0x807B54C4;

	/* Starting Lap Modifier */
	StartingLapHook = 0x80533A20;
	NoPlayerFlags = 0x80533A30;
	JingleFixHook = 0x8070A924;
	LastLap = 0x8053455C;
	LastLapLakitu = 0x80723338;
	NoLapFix = 0x807233A8;
	LapSignFix2 = 0x807233B4;
	LakituBoardHook = 0x807233C0;
	TimeStoreHook = 0x805344D8;
	TimeStoreHook2 = 0x805350AC;
	TimeStoreHook3 = 0x80535118;
	FinishTimesHook = 0x80533D0C;
	LapSignFixHook = 0x80534398;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80567114;

	/* Banana Spinout Modifier */
	BananaDamage = 0x80572B08;
	BlueSpinoutDmg = 0x80572B43;
	BombSpinoutDmg = 0x80572B5B;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x80790274;
	ItemLimits = 0x809C1FA4;

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

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x80852B27;
	RaceCountFix2 = 0x808530A4;
	RaceCountFix3 = 0x808530AC;
	RaceCountFix4 = 0x80851F5C;
	RaceCountFix5 = 0x8085203C;

	/* Play VS Race Alone */
	NoCPU = 0x808527B4;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x805344D0;
	RampUpSpeedFixHook = 0x8057B334;
	DriftFixHook = 0x8057DAA8;
	DriftFixHook2 = 0x8057D89C;
	DriftFixHook3 = 0x8057DF28;
	DriftFixHook4 = 0x8057E424;
	DriftFixHook5 = 0x8057E988;

	/* Game Mode - Teams */
	NoItemGlow = 0x807BC928;
	NoTeamInvincibility = 0x8052FEEC;

	/* Online Stuff */
	ForceCCHook = 0x80660A70;
	FroomRaceCount = 0x80645727;
	FroomRaceCount2 = 0x8064EB8B;

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

	/* Antifreeze */
	EVENTOverflowHook = 0x8065B240;
	MiiC = 0x808B2C60;
	NoLag = 0x8065416C;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x800911F4;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80718F8C;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80855BCC;

	/* Instant DC */
	WiiWheel = 0x80345162;
	InstantDCHook = 0x8053EDF0;

	/* License Unlocker */
	LicenseUnlocker = 0x805492F4;

	/* Points Modifier */
	PointsModifierHook = 0x8052E5B8;

	/* Silent Controller Changing */
	NoControllerDC = 0x8061A70C;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x8038898C;
	FasterMenuHook2 = 0x80895E80;
	FasterMenuHook3 = 0x80634DBC;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807EA7CC;

	/* No Music */
	NoMusicHook = 0x8009122C;

	/* No Character Voices */
	NoCharVoiceHook = 0x80715874;

	/* Force Battle Glitch */
	TagDistance = 0x808D2F64;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x8066148C;

	/* Show Time Difference */
	ItemAlertFixHook = 0x80601BD0;
	GhostFileSkip = 0x807EDBEC;
	GhostFileSkip2 = 0x807EDC10;
	TimeDiffPatchHook = 0x807EDC2C;
	TimeDiffPatchHook2 = 0x807EDC44;
	TimeDiffMPFixHook = 0x80857AB0;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8062D7A4;
	CreateScreen = 0x80622454;
	PushButton_HandleClick = 0x805BDCD8;
	PushButton_Vtable = 0x808B6918;
	ChangeCharsHook2 = 0x80622574;
	ChangeCharsHook3 = 0x8062D81C;

	/* Force 30 FPS */
	FramerateHook = 0x80428DD4;
	FramerateHook2 = 0x8051ACBE;

	/* Speedometer */
	SpeedoScreenElement = 0x80857B44;
	SpeedoUpdate = 0x8057BD28;
	SpeedoTextParseNop = 0x805CD610;
	SpeedoTextParse = 0x805CD64C;
	SpeedoParseSkip = 0x805CD6E4;
	SpeedoNoPauseHook = 0x807EABE0;
}