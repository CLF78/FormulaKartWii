SECTIONS {
	/* Base Functions */
	DVDOpen = 0x8015E1DC;
	DVDReadPrio = 0x8015E754;
	DVDClose = 0x8015E488;
	sprintf = 0x80011950;
	snprintf = 0x8001185C;
	swprintf = 0x80017738;
	OSReport = 0x801A24F0;
	OSFatal = 0x801A4DE4;
	CalcCRC32 = 0x801D1BC0;
	new = 0x80229CF8;
	delete = 0x80229D34;

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
	KMPdata = 0x809BC748;
	ArchiveRoot = 0x809BC798;
	PlayerHolder = 0x809C0958;
	KartParam = 0x809C0978;
	DriverParam = 0x809C097C;
	DriverManager = 0x809C291C;
	Menudata = 0x809C0E98;
	RKNetController = 0x809C1138;
	RKNetItemHandler = 0x809C1158;
	RKNetPacketManager = 0x809C0FB0;
	ItemHolder = 0x809C2678;
	ItemStructs = 0x809C2718;
	ItemStructsEX = 0x809C1FA8;
	ScreenHUD = 0x809C36E0;
	DisableInterrupts = 0x801A64CC;
	RestoreInterrupts = 0x801A64F4;
	GetTime = 0x801AAC7C;
	GXDrawDone = 0x8016E9D0;
	BeginFrame = 0x8020FD44;
	PlayerModels = 0x809C1F98;

	/* Math Functions */
	cos = 0x8001b4b4;
	sin = 0x8001b9bc;
	tan = 0x8001ba88;
	atan = 0x80085170;
	atan2 = 0x800852e0;
	acos = 0x8001bb00;
	pow = 0x8001bb14;
	sqrt = 0x8001bb18;
	rd_atan2 = 0x8001bb08;

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

	CalcRandom = 0x800ACF70;
	canItemBeGotten = 0x80799254;

	ptmf_test = 0x80021308;
	ptmf_scall = 0x80021374;

	SubtractTimers = 0x807EDECC;

	/* 1st Place Crown on Minimap */
	CrownMinimapHook = 0x807EAAFC;

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

	/* Allow looking backwards during respawn */
	RespawnLookBack = 0x805A1C0C;

	/* Allow looking backwards during the countdown */
	CountdownLookBack = 0x805A1BDC;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x8066148C;

	/* Anti Lag/Late Start Online */
	AntiLagStartHook = 0x80532DB0;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x800911F4;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A8E27;
	ItemWindowCTR = 0x808A8D6A;
	MapCharaCTR = 0x808a864e;

	/* Banana/Blue/Bomb Spinout Modifier */
	BananaDamage = 0x80572B08;
	BlueSpinoutDmg = 0x80572B43;
	BombSpinoutDmg = 0x80572B5B;

	/* Blue Flag */
	BlueFlagHook = 0x807efdb0;
	setPaneVisible = 0x8063dbb8;
	BalloonCTR = 0x808a908e;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A4D24;
	BlueShellSpeed2 = 0x808A4D84;

	/* Bomb Lag Fix */
	NoFakeBomb = 0x80572010;
	NoDmgChange = 0x805698E8;
	
	/* Bullet Bill Exhaust Animation Fix */
	BillAnimationFixHook = 0x8059B308;
	EffectPointer = 0x809C1230;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B4B58;
	CannonLandingFixHook = 0x80577EDC;
	CannonSpeed = 0x80584A44;
	CannonSpeed2 = 0x80584A50;
	BulletBillPosition = 0x8059C67C;

	/* Camera Distance Modifier */
	CustomFOV = 0x80891974;

	/* Cannon Fixes */
	CannonOffroadFix = 0x80584468;
	CannonTCFix = 0x805844F0;

	/* Change Camera Perspective after Race */
	CameraPersp = 0x805A22C8;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8062D7A4;
	CreateScreen = 0x80622454;
	PushButton_HandleClick = 0x805BDCD8;
	PushButton_Vtable = 0x808B6918;
	ChangeCharsHook2 = 0x80622574;
	ChangeCharsHook3 = 0x8062D81C;

	/* Clear Exhaust Pipe Boost Particle After Damage */
	ClearExhaustHook = 0x80566E38;

	/* Conditional Out of Bounds */
	ConditionalOutofBoundsHook = 0x805711F4;

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
	SandpitFix2 = 0x80686954;
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
	
	/* DC Prevention from laggy players */
	DCPrevention = 0x80654D58;

	/* Disable Bob-omb Backspam */
	NoBackBombs = 0x807a40e4;

	/* Disable Item Poof */
	NoItemPoof = 0x80795C2C;
	NoItemPoof2Hook = 0x807A10C0;
	NoItemPoof3Hook = 0x807A10D0;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80718F8C;

	/* Disable Title Demo Movie */
	DisableTitleDemoMovie = 0x806F9F90;

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

	/* Emitted Bob-ombs Explode (Idle Fix) */
	BombIdleFixHook = 0x807A67DC;

	/* Enhanced Race/Battle Pause Menu */
	CreateTTPause1 = 0x8062bda4;
	CreateTTPause2 = 0x8062bee8;
	CreateTTPause3 = 0x8062c02c;
	CreateTTPause4 = 0x806331e4;
	CreateTTPause5 = 0x806330bc;
	PreventStoringTTs = 0x8083cc84;
	DisableControllerImage1 = 0x808586d4;
	DisableControllerImage2 = 0x808584a4;
	VSPauseMenuHook = 0x80601c4c;

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

	/* Feather Cut Indicators */
	FCIHook1 = 0x8081F3F8;
	FCIHook2 = 0x8081F418;

	/* Feather Item */
	FeatherUseFunc = 0x808A49F4;
	FeatherOnlineFixHook = 0x807963F8;
	FeatherFilename = 0x808A4A18;
	FeatherSpeed = 0x808B4D84;
	GenerateEVENT = 0x8079B88C;
	SubtractItem = 0x807BBFE8;
	FeatherInvisWallHook = 0x805B61E8;

	/* FIBs Float in Midair when Backspammed */
	AirFIBsHook = 0x807a7090;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x808A0238;
	FastMusicHook = 0x8070A938;
	FastMusicHook2 = 0x80711144;
	FastMusicHook3 = 0x8062F7DC;

	/* Fix Offroad Glitch */
	OffroadRampGlitchFixHook = 0x80581FFC;

	/* Fix Online Players Stuck in Halfpipe */
	HalfPipeFixHook = 0x8058B8D8;

	/* Force Battle Glitch */
	TagDistance = 0x808D2F64;

	/* Frameskip */
	FrameskipHook1 = 0x80562450;
	FrameskipHook2 = 0x80009520;
	FrameskipHook3 = 0x80009540;
	FrameskipHook4 = 0x80009550;
	FrameskipHook5 = 0x8051B01C;
	FrameskipHook6 = 0x80653A6C;
	FrameskipHook7 = 0x80001614;
	FrameskipHook8 = 0x80001634;

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
	FastFallingHook2 = 0x80596D0C;
	RedSpeedHook = 0x807AA580;

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
	RandomComboPickerHook = 0x805DE034;
	GetWeightClass = 0x8081C3A8;
	DriftMenuBackFixHook = 0x8084D7E0;
	DriftMenuBackFix2Hook = 0x808BB1DC;
	DriftMenuBackFix2Return = 0x8084DD64;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808D71C0;
	GeoHitTableItemObj = 0x808D71D8;
	GeoHitTableKartHook = 0x80829AE4;
	GeyserCollFix = 0x80572D47;

	/* Glitch Prevention */
	DisableWallrideHook = 0x8057B998;
	TCGlitchFixHook = 0x807AFFD8;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A4F1C;

	/* Host Version Check */
	GuestSendHook = 0x800DBC58;
	HostCheckHook = 0x800DC3B8;
	DWCiCheckResvCommand = 0x800DE5D8;
	HostCheckHelperHook = 0x800DC2D0;
	Original30 = 0x802769F0;

	/* Hybrid Drift */
	HybridDrift1 = 0x805943E0;
	HybridDrift3Hook = 0x8057D928;
	HybridDrift4Hook = 0x8057DD70;
	HybridDrift5Hook = 0x8057874C;
	HybridDrift6Hook = 0x8057DA88;
	HybridDrift7 = 0x80593E8E;
	HybridDrift8 = 0x805A2F3C;
	WiiWheelFix = 0x808CA85A;
	WiiWheelFix2 = 0x8074511C;

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
	ItemBoxFix3Hook = 0x8076D378;

	/* Item Textures */
	ItemTexturesHook = 0x8086015C;
	ItemRouletteUpdate1Hook = 0x807B9860;
	ItemRouletteUpdate2Hook = 0x807B9AA0;
	ItemRouletteUpdate3Hook = 0x807EEA48;
	OriginalTextures = 0x808AE920;
	DoubleShroom = 0x808AEB07;

	/* KCP Map */
	KCPMapHook = 0x807e9b4c;
	KCPMapHook1 = 0x807e9d50;
	CtrlRace2dMapObject_vt = 0x808d2a50;
	CtrlRace2dMapObject_initSelf = 0x807ea298;
	LayoutUIControl_construct = 0x8063ce04;
	UIControl_insertChild = 0x8063c8e4;
	ControlLoader_load = 0x805c25e0;
	TranslateCoordinates = 0x807dff50;
	Map2DRenderer = 0x809c2fb8;

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
	MegaFunc = 0x80580494;
	BillFunc = 0x8058522C;
	MegaTCHook2 = 0x807AF428;

	/* Message Patch */
	MSGPatchHook = 0x805F84A8;
	MSGPatchHook2 = 0x80854AB4;
	MSGPatchHook3 = 0x807F81C4;
	TitleCTR = 0x80897BF1;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807EA7CC;

	/* Motion-Sensor Bombs */
	BombTimer = 0x807A5262;
	BombTimer2 = 0x807A4136;

	/* Newbie Helper */
	RespawnHelperHook = 0x805737A8;
	RespawnHelperHook2 = 0x805795A0;
	RespawnHelperHook3 = 0x8058167C;
	InstaDraftHook = 0x80586C60;
	
	/* No Bullet Bill Cancel When Touching Bottom of Rainbow Road */
	NoBillCancelRR = 0x8059B7B0;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807B9C3C;

	/* No Character Voices */
	NoCharVoiceHook = 0x80715874;
	
	/* No Disconnect */
	NoDC1 = 0x80520D88;
	NoDC2 = 0x8053E614;
	NoDC3 = 0x8053E8EC;
	NoDC4 = 0x8053EA34;
	NoDC5 = 0x8053EAA4;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80567114;
	NoRespawnInv = 0x80566FCE;
	StarInBullet = 0x8057FBF2;
	ShroomInBullet = 0x8057ED62;
	StarWhenHit = 0x8057FC24;
	ShroomWhenHit = 0x8057EDD0;

	/* No Lightning Flash */
	NoLightningFlash = 0x8054EB30;

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

	/* Patch.szs */
	SZSCount = 0x80529B0B;
	PatchSZSHook = 0x80529CD8;
	FilenameEndings = 0x808B22E8;
	DefaultFileEnding = 0x8088F450;

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

	/* Remove Bloom and Depth of Field */
	NoBloomHook = 0x805B0F5C;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807B96E3;
	RemoveFakeShroom = 0x807B9AF0;

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
	ShellHitCount2 = 0x807AE31C;

	/* Show Time Difference */
	TimeDiffPatchHook = 0x807EDBF4;
	TimeDiffApplyHook = 0x80855924;

	/* Show Timers */
	TimerShow = 0x8064F8C0;

	/* Show Times After Race */
	ShowTimesVS = 0x8085BF88;
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
	TimeLimit = 0x8053ED38;

	/* Track Identifier */
	TrackIdentifierHook = 0x80513740;
	TrackIdentifierDeleteHook = 0x805120E8;
	ITPHHook = 0x805135E4;
	ITPTHook = 0x805134C4;
	CKPTHook = 0x80513028;
	AREAHook = 0x80512CE0;
	JGPTHook = 0x80512AAC;
	CKPHHook = 0x8051316C;

	/* Transformation Music */
	TransfMusicHook = 0x8070F3C8;

	/* Trickable Cannons */
	TrickableCannonHook = 0x80584530;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807B97CC;
	SpecialItemHook = 0x80799754;
	ItemAmountHook = 0x807BBFC4;

	/* Ultra UnCut */
	CKPTCheck = 0x80534A98;

	/* Un-Beancorner */
	UnBeanCornerHook = 0x8056e184;

	/* Use Items in Cannon */
	ItemsCannon1 = 0x807975f4;
	ItemsCannon2 = 0x8079720c;
	ItemsCannon3 = 0x807972a0;

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

	/* Wiilink */
	WL_Code_Text_Hook = 0x800EDFB8;
	WL_Code_Data_Hook = 0x800EDDA4;
	WL_Auth_Response_Hook = 0x800EE2C4;
	WL_Domain_Hook = 0x8027A705;
	WL_URL_Hook = 0x80279DCC;
	WL_Skip_DNS = 0x800D1438;

	/* Anti-Wiimmfi */
	Anti_Wiimmfi_1 = 0x800EE2C0;
	Anti_Wiimmfi_2 = 0x800EC9CC;
	Anti_Wiimmfi_3 = 0x80005EFC;

	/* Wiimmfi */
	WiimmfiPatch1 = 0x800ED788;
	WiimmfiPatch2 = 0x800EC9CC;
	WiimmfiPatch3 = 0x800EE2C0;
	WiimmfiPatch4 = 0x801D4E1C;

	LoginRegion = 0x80384950;
	VSRegion = 0x80652CB0;
	VSRegion2 = 0x80658878;
	VSRegion3 = 0x80658D90;
	VSRegion4 = 0x806596A0;

	WiimmfiVersionString = 0x802759F4;
	WiimmfiURLs = 0x80279DA4;

	/* Woodbox Modifier */
	WoodRespawn = 0x808D03E0;
	WoodProb = 0x8076E494;
	BushFunc = 0x80766994;
}
