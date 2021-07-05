SECTIONS {
	/* Common Classes and Functions */
	SystemManager = 0x80381C80;
	Racedata = 0x809B8F68;
	Raceinfo = 0x809B8F70;
	PlayerHolder = 0x809BD110;
	KartParam = 0x809BD130;
	DriverParam = 0x809BD134;
	Menudata = 0x809BD508;
	RKNetController = 0x809BD918;
	RKNetItemHandler = 0x809BD938;
	ItemHolder = 0x809BEE20;
	ItemStructs = 0x809BEEB0;
	ScreenHUD = 0x809BFDC0;

	PlayerGetControllerHolder = 0x80589BD0;
	getPlayerById = 0x805898DC;
	getPlayerPosition = 0x805899E8;

	NETSHA1Init = 0x801D2454;
	NETSHA1Update = 0x801D24A4;
	NETSHA1GetDigest = 0x801D2558;

	SetPaneColor = 0x807E2674;
	SetTextSrc = 0x805C11E0;
	SetMatText = 0x8060C89C;

	playerCount = 0x809AF0B0;
	isOnlineRace = 0x809AF0B1;

	UtilRandomSeed = 0x800F2E28;
	UtilRandint = 0x800F2E40;

	ptmf_test = 0x80020884;
	ptmf_scall = 0x800208F0;

	SubtractTimers = 0x808423FC;
	
	RandomConstruct = 0x8054F444;
	RandomNextLimited = 0x8054F5AC;

	/* Codehandler Hooks */
	VIHook = 0x801BAA80;
	KPADHook = 0x80197A08;
	GXDrawHook = 0x8016EACC;
	GXFlushHook = 0x8016E60C;
	OSSleepHook = 0x801AAAF4;
	AXNextFrameHook = 0x80126500;

	/* Payload Hook */
	RelHook = 0x801A6C90;

	/* Base Functions */
	DVDOpen = 0x8015E21C;
	DVDReadPrio = 0x8015E794;
	DVDClose = 0x8015E4C8;
	sprintf = 0x80010ECC;
	swprintf = 0x80016CB4;
	OSFatal = 0x801A4E24;
	_restgpr_31_x = 0x80020A9C;

	/* 30 FPS */
	ThirtyFPSHook1 = 0x800099FC;
	ThirtyFPSHook2 = 0x8000926B;
	ThirtyFPSHook3 = 0x8000906F;
	ThirtyFPSHook4 = 0x80516B20;
	ThirtyFPSHook5 = 0x80516EC8;
	ThirtyFPSHook6 = 0x80516EB7;

	/* Exception Handler */
	ShowExceptions = 0x802A3084;
	ExcDispInfo = 0x802A3090;

	/* Wiimmfi */
	WiimmfiPatch1 = 0x800ED7C8;
	WiimmfiPatch2 = 0x800ECA0C;
	WiimmfiPatch3 = 0x800EE300;
	WiimmfiPatch4 = 0x801D4E5C;

	LoginRegion = 0x80380C50;
	VSRegion = 0x8064F1BC;
	VSRegion2 = 0x80654D84;
	VSRegion3 = 0x8065529C;
	VSRegion4 = 0x80655BAC;

	WiimmfiVersionString = 0x80271D14;
	NaswiiURL = 0x802760C4;
	NaswiiURL2 = 0x802760EC;
	NaswiiURL3 = 0x8027616C;
	NaswiiURL4 = 0x80276110;
	AvailableURL = 0x80276A28;
	GPCMURL = 0x80277198;
	GPSPURL = 0x80277BB0;
	MasterURL = 0x80278D51;
	NatnegURL = 0x8027996B;
	NatnegURL2 = 0x80279987;
	NatnegURL3 = 0x802799A3;
	MSURL = 0x80279AF3;
	GSURL = 0x80279B77;

	/* 30 Second Time Limit */
	ThirtySecs = 0x80539752;

	/* All Items Can Land */
	AICLUnk1 = 0x8079D6B8;
	AICLUnk2 = 0x8078DD24;
	NoItemLandingPoof = 0x80787EE4;
	ItemLandMega = 0x808B0D98;
	ItemLandGolden = 0x808B0DC8;
	ItemLandBill = 0x808B0DD4;

	/* Banana/Blue/Bomb Spinout Modifier */
	BananaDamage = 0x8056E338;
	BlueSpinoutDmg = 0x8056E373;
	BombSpinoutDmg = 0x8056E38B;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A10EC;
	BlueShellSpeed2 = 0x808A114C;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A43FF;
	ItemWindowCTR = 0x808A4342;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B1138;
	CannonLandingFix = 0x80571CF7;
	CannonSpeed = 0x8057E8A0;
	CannonSpeed2 = 0x8057E8AC;

	/* DC Bug Fix */
	DCFix = 0x8053A188;

	/* Disable Item Poof */
	NoItemPoof = 0x8078D5B4;
	NoItemPoof2Hook = 0x80798A48;
	NoItemPoof3Hook = 0x80798A58;

	/* Replace Blooper with Triple FIBs */
	BlooperKiller = 0x807D6070;
	BlooperHideModel = 0x808A2D7C;
	BlooperHideModel2 = 0x808A2D84;
	BlooperItemStruct = 0x808A2D60;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807EA79F;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x808A1058;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x80788964;

	/* Fast POW */
	POWTimer = 0x807D9827;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x8089C9D0;
	FastMusicHook = 0x80704928;
	FastMusicHook2 = 0x8070A034;
	FastMusicHook3 = 0x805FF1DC;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808D2690;
	GeoHitTableItemObj = 0x808D26A8;
	GeoHitTableKartHook = 0x80816964;
	GeyserCollFix = 0x8056E577;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A12E4;

	/* Inside Drift Bikes */
	KartParamHook = 0x8058B7C4;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x808153C8;

	/* Item Textures */
	ItemTexturesHook = 0x8083BEA4;
	OriginalTextures = 0x808A8D00;
	DoubleShroom = 0x808A8EE7;

	/* Lap Counter */
	SetLapCount = 0x807E545C;
	ColorFixHook = 0x807E54D8;
	PositionFixHook = 0x807E5554;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x80787BFC;
	ItemLimits = 0x809BE754;

	/* Mega Flips Cars */
	MegaFlip = 0x808170EF;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x8058B904;
	FOVChange = 0x80572B54;

	/* Mega Thundercloud */
	MegaTCHook = 0x80579DCC;
	MegaFunc = 0x8078F6A8;

	/* Motion-Sensor Bombs */
	BombTimer = 0x8079CBEA;
	BombTimer2 = 0x8079BABE;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807ABB70;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80563414;
	NoRespawnInv = 0x805632CE;
	StarInBullet = 0x80579A0E;
	ShroomInBullet = 0x80578B7E;
	StarWhenHit = 0x80579A40;
	ShroomWhenHit = 0x80578BEC;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807ADBD0;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807AB617;
	RemoveFakeShroom = 0x807ABA20;
	RemoveFakeShroom2 = 0x807ABA24;
	RemoveFakeShroom3 = 0x807AB6C4;

	/* Show Times After Race */
	ShowTimesVS = 0x8085A27C;
	ShowTimesWW = 0x8085ADD0;
	TimesFunc = 0x807EB334;
	TimePrintHook = 0x807EB3F8;

	/* Ultra UnCut */
	CKPTCheck = 0x805305D4;

	/* Woodbox Modifier */
	WoodRespawn = 0x808CA6A8;
	WoodProb = 0x8077B300;
	BushFunc = 0x8077705C;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807AB700;
	SpecialItemHook = 0x80790FD8;
	ItemAmountHook1 = 0x8065D35C;
	ItemAmountHook2 = 0x807ADEF8;

	/* Time Limit Modifier */
	TimeLimit = 0x80539E7C;

	/* Shells Never Break */
	ShellHitCount = 0x807A74B4;
	ShellHitCount2 = 0x8079AB00;

	/* Starting Lap Modifier */
	StartingLapHook = 0x8052F558;
	JingleFixHook = 0x80704914;
	LastLap = 0x80530094;
	LastLapLakitu = 0x8071F89C;
	NoLapFix = 0x8071F90C;
	LapSignFix2 = 0x8071F918;
	LakituBoardHook = 0x8071F924;
	TimeStoreHook = 0x80530010;
	TimeStoreHook2 = 0x80530BE4;
	TimeStoreHook3 = 0x80530C50;
	FinishTimesHook = 0x8052F844;
	LapSignFixHook = 0x8052FED0;
	LapArrayIncrease = 0x8052DD88;
	LapCountFixHook = 0x8052F568;

	/* Cycle Fixes - Coconut Mall */
	EscalatorFixHook = 0x807F2E4C;
	PiantaFixHook = 0x807F463C;

	/* Cycle Fixes - Dry Dry Ruins */
	PillarFixHook = 0x80845124;
	SandpitFixHook = 0x80682BA0;
	SandpitFix2 = 0x80682E60;
	SandpitFix3 = 0x806833F4;

	/* Cycle Fixes - Ghost Valley 2 */
	GV2Fix = 0x807F9DCE;

	/* Cycle Fixes - Grumble Volcano */
	RockFix = 0x806EE98E;
	RockFix2Hook = 0x80805174;
	GeyserFixHook = 0x806E5814;

	/* Cycle Fixes - Toad's Factory */
	ConveyorFixHook = 0x807F0804;

	/* Game Modes - Generic */
	SceneSwapHook = 0x805F0F68;
	HostFlagsHook = 0x806569E8;
	GuestFlagsHook = 0x80656AE8;
	FlagResetHook = 0x800D1A10;
	FlagResetHook2 = 0x800D18E0;
	FlagResetHook3 = 0x800D1CC4;
	FlagResetHook4 = 0x800D2C30;
	FlagResetHook5 = 0x800CCD08;
	BattleFixHook = 0x8083BE40;
	BattleFixHook2 = 0x808308DC;
	TimerManagerHook = 0x80531134;
	VehicleRestrictionHook = 0x808286CC;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x80832F73;
	RaceCountFix2 = 0x808334F0;
	RaceCountFix3 = 0x808334F8;
	RaceCountFix4 = 0x80858478;
	RaceCountFix5 = 0x80858558;

	/* Play VS Race Alone */
	NoCPU = 0x80832C00;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x80530008;
	RampUpSpeedFixHook = 0x80575150;
	DriftSpeed = 0x808B125C;
	BrakeDriftClassicHook = 0x8051B184;
	BrakeDriftGCNHook = 0x8051BE28;
	BrakeDriftNunchuckHook = 0x80735DE8;
	BrakeDriftWheelHook = 0x807360A4;
	BrakeDriftMainHook = 0x80574588;
	BrakeDriftSoundHook = 0x806F6090;
	BrakeDriftEffBikesHook = 0x80695810;
	BrakeDriftEffKartsHook = 0x80694AC8;
	DoBrakeDrift = 0x80574628;
	BrakeDriftEffFunc = 0x8069D550;
	BrakeDriftEffFunc2 = 0x8069D6E0;
	FastFallingHook = 0x8058FF68;
	FastFallingHook2 = 0x80590B6C;

	/* Game Mode - Teams */
	NoItemGlow = 0x807AE85C;
	NoTeamInvincibility = 0x8056D7C0;
	NoTeamInvincibility2 = 0x8056E448;
	NoTeamInvincibility3 = 0x8056AF14;
	NoTeamInvincibility4 = 0x807D8630;

	/* Online Stuff */
	ForceCCHook = 0x806594C8;
	FroomRaceCount = 0x8064D463;
	FroomRaceCount2 = 0x8061C20B;

	/* Remove WW Button */
	NoWWButton = 0x8061866F;
	NoWWButton2 = 0x806186FC;
	NoWWButton3 = 0x80618724;
	NoWWButton4 = 0x8061873C;
	NoWWButton5 = 0x806188FF;
	NoWWButton6 = 0x8061892A;
	NoWWButton7 = 0x806189A2;
	NoWWButton8 = 0x8061893A;
	NoWWButton9 = 0x806189AE;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x80091234;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80711A54;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80834AD0;

	/* Instant DC */
	WiiWheel = 0x80341462;
	InstantDCHook = 0x80539F34;

	/* License Unlocker */
	LicenseUnlocker = 0x80544438;

	/* Points Modifier */
	PointsModifierHook = 0x8052A0F0;

	/* Silent Controller Changing */
	NoControllerDC = 0x805EAF5C;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x80384C84;
	FasterMenuHook2 = 0x808901B8;
	FasterMenuHook3 = 0x806047D8;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807E18B4;

	/* No Music */
	NoMusicHook = 0x8009126C;

	/* No Character Voices */
	NoCharVoiceHook = 0x8070E764;

	/* Force Battle Glitch */
	TagDistance = 0x808CEEAC;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x80659EE4;

	/* Show Time Difference */
	GhostFileSkip = 0x8084212F;
	TimeDiffPatchHook = 0x8084215C;
	TimeDiffPatchHook2 = 0x80842174;
	TimeDiffApplyHook = 0x80834828;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x805FD1A4;
	CreateScreen = 0x805F1E54;
	PushButton_HandleClick = 0x805B66B4;
	PushButton_Vtable = 0x808B2EF0;
	ChangeCharsHook2 = 0x805F1F74;
	ChangeCharsHook3 = 0x805FD21C;

	/* Speedometer */
	SpeedoTextParseNop = 0x805C1214;
	SpeedoTextParse = 0x805C1250;
	SpeedoParseSkip = 0x805C12E8;
	SpeedoNoPauseHook = 0x807E1CC8;

	/* Impervious TC */
	ImperviousTCHook = 0x807D74F0;
	ImperviousTCHook2 = 0x807D74FC;
}