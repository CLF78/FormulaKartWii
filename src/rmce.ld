SECTIONS {
	/* Base Functions */
	DVDOpen = 0x8015E21C;
	DVDReadPrio = 0x8015E794;
	DVDClose = 0x8015E4C8;
	sprintf = 0x80010ECC;
	snprintf = 0x80010DD8;
	swprintf = 0x80016CB4;
	OSReport = 0x801A2530;
	OSFatal = 0x801A4E24;
	CalcCRC32 = 0x801D1C00;
	new = 0x80229A54;
	delete = 0x80229A90;

	/* Codehandler Hooks */
	VIHook = 0x801BAA80;
	KPADHook = 0x80197A08;
	GXDrawHook = 0x8016EACC;
	GXFlushHook = 0x8016E60C;
	OSSleepHook = 0x801AAAF4;
	AXNextFrameHook = 0x80126500;

	/* Common Classes and Functions */
	SystemManager = 0x80381C80;
	Racedata = 0x809B8F68;
	Raceinfo = 0x809B8F70;
	KMPdata = 0x809B8F28;
	ArchiveRoot = 0x809B8F78;
	PlayerHolder = 0x809BD110;
	KartParam = 0x809BD130;
	DriverParam = 0x809BD134;
	DriverManager = 0x809BF0B4;
	Menudata = 0x809BD508;
	RKNetController = 0x809BD918;
	RKNetItemHandler = 0x809BD950;
	RKNetPacketManager = 0x809BD790;
	ItemHolder = 0x809BEE20;
	ItemStructs = 0x809BEEB0;
	ItemStructsEX = 0x809BE750;
	ScreenHUD = 0x809BFDC0;
	DisableInterrupts = 0x801A650C;
	RestoreInterrupts = 0x801A6534;
	GetTime = 0x801AACBC;
	GXDrawDone = 0x8016EA10;
	BeginFrame = 0x8020FD84;
	PlayerModels = 0x809BE740;

	/* Math Functions */
	cos = 0x8001aa30;
	sin = 0x8001af38;
	tan = 0x8001b004;
	atan = 0x800851b0;
	atan2 = 0x80085320;
	acos = 0x8001b07c;
	pow = 0x8001b090;
	sqrt = 0x8001b094;
	rd_atan2 = 0x8001b084;

	PlayerGetControllerHolder = 0x80589BD0;
	getPlayerById = 0x805898DC;
	getPlayerPosition = 0x805899E8;

	NETSHA1Init = 0x801D2454;
	NETSHA1Update = 0x801D24A4;
	NETSHA1GetDigest = 0x801D2558;

	SetPaneColor = 0x807E2674;
	SetTextSrc = 0x805C11E0;
	SetMatText = 0x8060C89C;

	playerCount = 0x809BF0B0;
	isOnlineRace = 0x809BF0B1;

	CalcRandom = 0x800ACFB0;
	canItemBeGotten = 0x80790BDC;

	ptmf_test = 0x80020884;
	ptmf_scall = 0x800208F0;

	SubtractTimers = 0x808423FC;

	/* 1st Place Crown on Minimap */
	CrownMinimapHook = 0x807E1BE4;

	/* 30 FPS */
	ThirtyFPSHook1 = 0x800099FC;
	ThirtyFPSHook2 = 0x8000926B;
	ThirtyFPSHook3 = 0x8000906F;
	ThirtyFPSHook4 = 0x80516B20;
	ThirtyFPSHook5 = 0x80516EC8;
	ThirtyFPSHook6 = 0x80516EB7;

	/* 30 Second Time Limit */
	ThirtySecs = 0x80539752;

	/* All Items Can Land */
	AICLUnk1 = 0x8079D6B8;
	AICLUnk2 = 0x8078DD24;
	NoItemLandingPoof = 0x80787EE4;
	ItemLandMega = 0x808B0D98;
	ItemLandFeather = 0x808B0DB0;
	ItemLandGolden = 0x808B0DC8;
	ItemLandBill = 0x808B0DD4;

	/* Allow looking backwards during respawn */
	RespawnLookBack = 0x80597254;

	/* Allow looking backwards during the countdown */
	CountdownLookBack = 0x80597224;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x80659EE4;

	/* Anti Lag/Late Start Online */
	AntiLagStartHook = 0x8052E8E8;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x80091234;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A43FF;
	ItemWindowCTR = 0x808A4342;
	MapCharaCTR = 0x808a3dc6;

	/* Banana/Blue/Bomb Spinout Modifier */
	BananaDamage = 0x8056E338;
	BlueSpinoutDmg = 0x8056E373;
	BombSpinoutDmg = 0x8056E38B;

	/* Blue Flag */
	BlueFlagHook = 0x807e611c;
	setPaneVisible = 0x8060d12c;
	BalloonCTR = 0x808a4606;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A10EC;
	BlueShellSpeed2 = 0x808A114C;

	/* Bomb Lag Fix */
	NoFakeBomb = 0x8056D840;
	NoDmgChange = 0x80565BE8;
	
	/* Bullet Bill Exhaust Animation Fix */
	BillAnimationFixHook = 0x805B0970;
	EffectPointer = 0x809BDA10;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B1138;
	CannonLandingFixHook = 0x80571CF8;
	CannonSpeed = 0x8057E8A0;
	CannonSpeed2 = 0x8057E8AC;
	BulletBillPosition = 0x805B1CE4;

	/* Camera Distance Modifier */
	CustomFOV = 0x8088DBE4;

	/* Cannon Fixes */
	CannonOffroadFix = 0x8057E2C4;
	CannonTCFix = 0x8057E34C;

	/* Change Camera Perspective after Race */
	CameraPersp = 0x80597910;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x805FD1A4;
	CreateScreen = 0x805F1E54;
	PushButton_HandleClick = 0x805B66B4;
	PushButton_Vtable = 0x808B2EF0;
	ChangeCharsHook2 = 0x805F1F74;
	ChangeCharsHook3 = 0x805FD21C;

	/* Clear Exhaust Pipe Boost Particle After Damage */
	ClearExhaustHook = 0x80563138;

	/* Conditional Out of Bounds */
	ConditionalOutofBoundsHook = 0x8056CA24;

	/* Crazy Eight */
	CrazyEightEnableCircling = 0x808A0ED0;
	ItemAssignerCall = 0x80788A3C;
	ItemAssignerCall2 = 0x807ADA34;
	ItemAssignerStackFixHook = 0x8078CDF8;
	ItemAssignerHook2 = 0x8078CE1C;
	ItemAssignerHook3 = 0x8078CE20;
	ItemAssignerHook4 = 0x8078CEA8;
	ItemAssignerHook5 = 0x8078CEC4;
	ItemAssignerStackFix2Hook = 0x8078CF0C;
	ItemUsageFixHook = 0x8078B878;
	ItemUsageFixHook2 = 0x8078B9E8;
	DestroyItem = 0x8079D6F4;

	/* Credits Button */
	CreditsButton = 0x80831CB7;

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

	/* DC Bug Fix */
	DCFix = 0x8053A178;
	
	/* DC Prevention from laggy players */
	DCPrevention = 0x80651264;

	/* Disable Bob-omb Backspam */
	NoBackBombs = 0x8079ba6c;

	/* Disable Item Poof */
	NoItemPoof = 0x8078D5B4;
	NoItemPoof2Hook = 0x80798A48;
	NoItemPoof3Hook = 0x80798A58;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80711A54;

	/* Disable Title Demo Movie */
	DisableTitleDemoMovie = 0x806F59BC;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807EA79F;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80834AD0;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x808A1058;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x80788964;

	/* Dynamic Item Sizing */
	DynamicSizingHook = 0x80781C34;
	DynamicSizingHook2 = 0x807C2CE0;
	DynamicSizingHook3 = 0x80795C38;
	DynamicSizingHook4 = 0x80796010;
	DynamicSizingHook7 = 0x80794F10;
	BombVisualSizeHook = 0x8079B650;
	BombVisualSizeHook2 = 0x8079D0B0;
	BombSizeHook2 = 0x8079B784;
	BombSizeHook3 = 0x8079C670;
	BlueVisualSizeHook = 0x807A35BC;
	BlueSizeHook2 = 0x807A36DC;
	BlueExplosionFunc = 0x807A32B0;

	/* Emitted Bob-ombs Explode (Idle Fix) */
	BombIdleFixHook = 0x8079E164;

	/* Enhanced Race/Battle Pause Menu */
	CreateTTPause1 = 0x805fb7a4;
	CreateTTPause2 = 0x805fb8e8;
	CreateTTPause3 = 0x805fba2c;
	CreateTTPause4 = 0x80602be4;
	CreateTTPause5 = 0x80602abc;
	PreventStoringTTs = 0x80822bb8;
	DisableControllerImage1 = 0x808375d8;
	DisableControllerImage2 = 0x808373a8;
	VSPauseMenuHook = 0x805ddbf8;

	/* Exception Handler */
	ShowExceptions = 0x802A3084;

	/* Fast POW */
	NoPOWDelay = 0x807D9820;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x80384C84;
	FasterMenuHook2 = 0x808901B8;
	FasterMenuHook3 = 0x806047D8;

	/* Faster Score Increase */
	ScoreSkip = 0x807EB1CF;
	NoTransition = 0x8083A510;

	/* Feather Cut Indicators */
	FCIHook1 = 0x8080C278;
	FCIHook2 = 0x8080C298;

	/* Feather Item */
	FeatherUseFunc = 0x808A2D74;
	FeatherOnlineFixHook = 0x8078DD80;
	FeatherFilename = 0x808A2D98;
	FeatherSpeed = 0x808B1364;
	GenerateEVENT = 0x80793214;
	SubtractItem = 0x807ADF1C;
	FeatherInvisWallHook = 0x805AB940;

	/* FIBs Float in Midair when Backspammed */
	AirFIBsHook = 0x8079ea18;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x8089C9D0;
	FastMusicHook = 0x80704928;
	FastMusicHook2 = 0x8070A034;
	FastMusicHook3 = 0x805FF1DC;

	/* Fix Offroad Glitch */
	OffroadRampGlitchFixHook = 0x8057BE18;

	/* Fix Online Players Stuck in Halfpipe */
	HalfPipeFixHook = 0x80585734;

	/* Force Battle Glitch */
	TagDistance = 0x808CEEAC;

	/* Frameskip */
	FrameskipHook1 = 0x8055E750;
	FrameskipHook2 = 0x80009584;
	FrameskipHook3 = 0x800095A4;
	FrameskipHook4 = 0x800095B4;
	FrameskipHook5 = 0x80517228;
	FrameskipHook6 = 0x8064FF78;
	FrameskipHook7 = 0x80001614;
	FrameskipHook8 = 0x80001634;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x80530008;
	RampUpSpeedFixHook = 0x80575150;
	DriftSpeedHook = 0x805776B4;
	DriftSpeedHook2 = 0x805778C0;
	DriftSpeedHook3 = 0x80577D40;
	DriftSpeedHook4 = 0x8057823C;
	DriftSpeedHook5 = 0x805787A0;
	BoostAccelHook = 0x80582690;
	BrakeDriftClassicHook = 0x8051B184;
	BrakeDriftGCNHook = 0x8051BE28;
	BrakeDriftNunchuckHook = 0x80735DE8;
	BrakeDriftWheelHook = 0x807360A4;
	BrakeDriftMainHook = 0x80574588;
	BrakeDriftSoundHook = 0x806F6090;
	BrakeDriftEffBikesHook = 0x80695810;
	BrakeDriftEffKartsHook = 0x80694AC8;
	BrakeDriftEffFunc = 0x8069D550;
	BrakeDriftEffFunc2 = 0x8069D6E0;
	FastFallingHook = 0x8058FF68;
	FastFallingHook2 = 0x80590B68;
	RedSpeedHook = 0x807A026C;

	/* Game Mode - Teams */
	NoItemGlow = 0x807AE85C;
	NoTeamInvincibility = 0x8056D7C0;
	NoTeamInvincibility2 = 0x8056E448;
	NoTeamInvincibility3 = 0x80689E50;
	NoTeamInvincibility4 = 0x807D8630;
	NoTeamInvincibility5 = 0x8056AEE0;
	NoTeamInvincibility6 = 0x80689E94;

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
	MessageButtons = 0x8062C907;
	MessageButtons2Hook = 0x8062B954;
	MessageButtons3Hook = 0x8062B2F0;
	RandomComboPickerHook = 0x8062EC74;
	GetWeightClass = 0x80809F90;
	DriftMenuBackFixHook = 0x8082EB60;
	DriftMenuBackFix2Hook = 0x808B5C5C;
	DriftMenuBackFix2Return = 0x8082F0E4;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808D2690;
	GeoHitTableItemObj = 0x808D26A8;
	GeoHitTableKartHook = 0x80816964;
	GeyserCollFix = 0x8056E577;

	/* Glitch Prevention */
	DisableWallrideHook = 0x805757B4;
	TCGlitchFixHook = 0x807D83C0;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A12E4;

	/* Host Version Check */
	GuestSendHook = 0x800DBC98;
	HostCheckHook = 0x800DC3F8;
	DWCiCheckResvCommand = 0x800DE618;
	HostCheckHelperHook = 0x800DC310;
	Original30 = 0x80272D10;

	/* Hybrid Drift */
	HybridDrift1 = 0x8058E23C;
	HybridDrift3Hook = 0x80577744;
	HybridDrift4Hook = 0x80577B8C;
	HybridDrift5Hook = 0x80572568;
	HybridDrift6Hook = 0x805778A4;
	HybridDrift7 = 0x8058DCEA;
	HybridDrift8 = 0x80598584;
	WiiWheelFix = 0x808C6202;
	WiiWheelFix2 = 0x80735BE4;

	/* Impervious TC */
	ImperviousTCHook = 0x807D74FC;

	/* Inside Drift Bikes */
	KartParamHook = 0x8058B7C4;

	/* Instant DC */
	WiiWheel = 0x80341462;
	InstantDCHook = 0x80539F34;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x808153C8;
	ItemBoxFix = 0x8075A6F8;
	ItemBoxFix2 = 0x8075A82F;
	ItemBoxFix3Hook = 0x8075B624;

	/* Item Textures */
	ItemTexturesHook = 0x8083BEA4;
	ItemRouletteUpdate1Hook = 0x807AB794;
	ItemRouletteUpdate2Hook = 0x807AB9D4;
	ItemRouletteUpdate3Hook = 0x807E50CC;
	OriginalTextures = 0x808A8D00;
	DoubleShroom = 0x808A8EE7;

	/* KCP Map */
	KCPMapHook = 0x807e0c34;
	KCPMapHook1 = 0x807e0e38;
	CtrlRace2dMapObject_vt = 0x808cead0; 
	CtrlRace2dMapObject_initSelf = 0x807e1380;
	LayoutUIControl_construct = 0x8060c378;
	UIControl_insertChild = 0x8060be58;
	ControlLoader_load = 0x805ba2cc;
	TranslateCoordinates = 0x807d02c4;
	Map2DRenderer = 0x809bf750; 

	/* Lap Counter */
	ColorFixHook = 0x807E54D8;
	PositionFixHook = 0x807E5554;

	/* License Unlocker */
	LicenseUnlocker = 0x80544438;

	/* MK7 Shock Squishing */
	SquishCheckHook = 0x8056AEFC;
	SquishFunc = 0x8056554B;

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
	MegaFunc = 0x8057A2B0;
	BillFunc = 0x8057F088;
	MegaTCHook2 = 0x807D7810;

	/* Message Patch */
	MSGPatchHook = 0x805D82E8;
	MSGPatchHook2 = 0x808339B8;
	MSGPatchHook3 = 0x80842F90;
	TitleCTR = 0x808916C9;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807E18B4;

	/* Motion-Sensor Bombs */
	BombTimer = 0x8079CBEA;
	BombTimer2 = 0x8079BABE;

	/* Newbie Helper */
	RespawnHelperHook = 0x8056EFD8;
	RespawnHelperHook2 = 0x805733BC;
	RespawnHelperHook3 = 0x8057B498;
	InstaDraftHook = 0x80580ABC;
	
	/* No Bullet Bill Cancel When Touching Bottom of Rainbow Road */
	NoBillCancelRR = 0x805B0E18;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807ABB70;

	/* No Character Voices */
	NoCharVoiceHook = 0x8070E764;
	
	/* No Disconnect */
	NoDC1 = 0x8051CF94;
	NoDC2 = 0x80539758;
	NoDC3 = 0x80539A30;
	NoDC4 = 0x80539B78;
	NoDC5 = 0x80539BE8;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80563414;
	NoRespawnInv = 0x805632CE;
	StarInBullet = 0x80579A0E;
	ShroomInBullet = 0x80578B7E;
	StarWhenHit = 0x80579A40;
	ShroomWhenHit = 0x80578BEC;

	/* No Lightning Flash */
	NoLightningFlash = 0x80549C74;

	/* No Multi Channel Track Music */
	NoMultiChannelHook = 0x806F5BC4;
	NoMultiChannelHook2 = 0x800A4E78;
	FirstCall = 0x80711720;

	/* No Music */
	NoMusicHook = 0x8009126C;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x80832F73;
	RaceCountFix2 = 0x808334F0;
	RaceCountFix3 = 0x808334F8;
	RaceCountFix4 = 0x80858478;
	RaceCountFix5 = 0x80858558;

	/* Online Stuff */
	ForceCCHook = 0x806594C8;
	FroomRaceCount = 0x8064D463;
	FroomRaceCount2 = 0x8061C20B;

	/* POW Yourself in 1st */
	POWSelfHook = 0x807D9884;

	/* Patch.szs */
	SZSCount = 0x80525D17;
	PatchSZSHook = 0x80525EE4;
	FilenameEndings = 0x808AEAD8;
	DefaultFileEnding = 0x8088B9A0;

	/* Pause Menu Fix */
	PauseMenuScreenHook = 0x805FB7B8;
	PauseMenuScreenHook2 = 0x805FB8FC;

	/* Payload Hook */
	RelHook = 0x801A6C90;

	/* Play VS Race Alone */
	NoCPU = 0x80832C00;

	/* Points Modifier */
	PointsModifierHook = 0x8052A0F0;

	/* Prediction Removal */
	PredictionRemoval = 0x8088D610;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807ADBD0;

	/* Red Shell Target Modifier */
	TargetWhileRespawn = 0x8058AA72;
	TargetWhileHit = 0x8058AABF;
	TargetPositionHook = 0x807A4E40;

	/* Remove Bloom and Depth of Field */
	NoBloomHook = 0x805A66B4;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807AB617;
	RemoveFakeShroom = 0x807ABA24;

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

	/* Set Default Drift Type */
	DefaultDriftType = 0x80540E30;

	/* Shells Never Break */
	ShellHitCount = 0x807A74B4;
	ShellHitCount2 = 0x807A4008;

	/* Show Time Difference */
	TimeDiffPatchHook = 0x80842124;
	TimeDiffApplyHook = 0x80834828;

	/* Show Timers */
	TimerShow = 0x8061CF40;

	/* Show Times After Race */
	ShowTimesVS = 0x8085A28C;
	ShowTimesWW = 0x8085ADD0;
	TimesFunc = 0x807EB334;
	TimePrintHook = 0x807EB3F8;

	/* Silent Controller Changing */
	NoControllerDC = 0x805EAF5C;

	/* Speedometer */
	SpeedoTextParseNop = 0x805C1214;
	SpeedoTextParse = 0x805C1250;
	SpeedoParseSkip = 0x805C12E8;
	SpeedoNoPauseHook = 0x807E1CC8;

	/* Starting Lap Modifier */
	LapCount1 = 0x8052DD5F;
	LapCount2 = 0x8052EB63;
	LapCount3 = 0x8052F7FB;
	LapCount4 = 0x80530067;
	LapCount5 = 0x80530193;
	LakituBoardHook = 0x8071F90C;

	/* Super Miniturbo Multiplier */
	SMTMultiplier = 0x808B1410;
	SMTMinimum = 0x808B1406;

	/* Time Limit Modifier */
	TimeLimit = 0x80539E7C;

	/* Track Identifier */
	TrackIdentifierHook = 0x8050F94C;
	TrackIdentifierDeleteHook = 0x8050E2F4;
	ITPHHook = 0x8050F7F0;
	ITPTHook = 0x8050F6D0;
	CKPTHook = 0x8050F234;
	AREAHook = 0x8050EEEC;
	JGPTHook = 0x8050ECB8;
	CKPHHook = 0x8050F378;

	/* Transformation Music */
	TransfMusicHook = 0x807082B8;

	/* Trickable Cannons */
	TrickableCannonHook = 0x8057E38C;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807AB700;
	SpecialItemHook = 0x807910DC;
	ItemAmountHook = 0x807ADEF8;

	/* Ultra UnCut */
	CKPTCheck = 0x805305D0;

	/* Un-Beancorner */
	UnBeanCornerHook = 0x805699b4;

	/* Use Items in Cannon */
	ItemsCannon1 = 0x8078ef7c;
	ItemsCannon2 = 0x8078eb94;
	ItemsCannon3 = 0x8078ec28;

	/* VS Menu Skip */
	VSMenuSkipHook = 0x80857FB4;
	VSMenuSkipHook2 = 0x8063BE20;
	VSMenuSkip3 = 0x805FC3A8;
	VSMenuSkip4 = 0x805FF83F;
	VSMenuReturnHook = 0x808586A4;
	VSMenuReturn = 0x80830524;
	VSMenuReturnHook2 = 0x808585D0;
	VSMenuReturn2Func = 0x80820028;
	VSMenuSkipMulti = 0x805DEA6B;
	NoGhostLoading = 0x805F0328;

	/* Wiilink */
	WL_Code_Text_Hook = 0x800EDFF8;
	WL_Code_Data_Hook = 0x800EDDE4;
	WL_Auth_Response_Hook = 0x800EE304;
	WL_Domain_Hook = 0x80276A25;
	WL_URL_Hook = 0x802760EC;
	WL_Skip_DNS = 0x800D1478;

	/* Anti-Wiimmfi */
	Anti_Wiimmfi_1 = 0x800EE300;
	Anti_Wiimmfi_2 = 0x800ECA0C;
	Anti_Wiimmfi_3 = 0x80005EFC;

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
	WiimmfiURLs = 0x802760C4;

	/* Woodbox Modifier */
	WoodRespawn = 0x808CA6A8;
	WoodProb = 0x8077B300;
	BushFunc = 0x8077705C;
}
