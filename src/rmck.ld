SECTIONS {
	/* Base Functions */
	DVDOpen = 0x8015E334;
	DVDReadPrio = 0x8015E8AC;
	DVDClose = 0x8015E5E0;
	sprintf = 0x80011A94;
	snprintf = 0x800119A0;
	swprintf = 0x8001787C;
	OSReport = 0x801A292C;
	OSFatal = 0x801A5220;
	CalcCRC32 = 0x801D1FFC;
	new = 0x8022A14C;
	new2 = 0x8022A140;
	new_a = 0x8022A164;
	delete = 0x8022A188;
	delete_a = 0x8022A254;

	/* Codehandler Hooks */
	VIHook = 0x801BAE7C;
	KPADHook = 0x80197E04;
	GXDrawHook = 0x8016EC08;
	GXFlushHook = 0x8016E748;
	OSSleepHook = 0x801AAEF0;
	AXNextFrameHook = 0x80126618;

	/* Common Classes and Functions */
	SystemManager = 0x80374020;
	KMPinfo = 0x809ABD28;
	Racedata = 0x809ABD68;
	Raceinfo = 0x809ABD70;
	ArchiveRoot = 0x809ABD78;
	PlayerHolder = 0x809AFF38;
	KartParam = 0x809AFF58;
	DriverParam = 0x809AFF5C;
	Menudata = 0x809B0478;
	RKNetController = 0x809B0718;
	RKNetItemHandler = 0x809B0738;
	ItemHolder = 0x809B1C58;
	ItemStructs = 0x809B1CF8;
	ItemStructsEX = 0x809B1588;
	ScreenHUD = 0x809B2CC0;

	/* Math Functions */
	cos = 0x8001b5f8;
	sin = 0x8001bb00;
	tan = 0x8001bbcc;
	atan = 0x800852b0;
	atan2 = 0x80085420;
	acos = 0x8001bc44;
	pow = 0x8001bc58;
	sqrt = 0x8001bc5c;
	rd_atan2 = 0x8001bc4c;

	PlayerGetControllerHolder = 0x8057E44C;
	getPlayerById = 0x8057E158;
	getPlayerPosition = 0x8057E264;

	/* Button Conditionals */
	GCNButton = 0x80336200;

	NETSHA1Init = 0x801D2850;
	NETSHA1Update = 0x801D28A0;
	NETSHA1GetDigest = 0x801D2954;

	SetPaneColor = 0x807DA2E0;
	SetTextSrc = 0x805BBCC0;
	SetMatText = 0x8062BFD4;

	playerCount = 0x809B13F8;
	isOnlineRace = 0x809B13F9;

	CalcRandom = 0x800AD0B0;
	canItemBeGotten = 0x80787FA8;

	UtilRandom = 0x800F2F58;

	ptmf_test = 0x8002144C;
	ptmf_scall = 0x800214B8;

	SubtractTimers = 0x807DCC20;

	/* 30 FPS */
	ThirtyFPSHook1 = 0x80009B44;
	ThirtyFPSHook2 = 0x800093FB;
	ThirtyFPSHook3 = 0x800091FF;
	ThirtyFPSHook4 = 0x80508FB4;
	ThirtyFPSHook5 = 0x8050935C;
	ThirtyFPSHook6 = 0x8050934B;

	/* 30 Second Time Limit */
	ThirtySecs = 0x8052CCE6;

	/* All Items Can Land */
	AICLUnk1 = 0x80794A84;
	AICLUnk2 = 0x807850F0;
	NoItemLandingPoof = 0x8077F2B0;
	ItemLandMega = 0x808A3948;
	ItemLandFeather = 0x808A3960;
	ItemLandGolden = 0x808A3978;
	ItemLandBill = 0x808A3984;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x80650138;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x80091334;

	/* BRCTR Redirector */
	LapNumberCTR = 0x80898127;
	ItemWindowCTR = 0x8089806A;
	ChaseIconCTR = 0x8089844F;

	/* Banana/Blue/Bomb Spinout Modifier */
	BananaDamage = 0x805611E0;
	BlueSpinoutDmg = 0x8056121B;
	BombSpinoutDmg = 0x80561233;

	/* Blue Flag */
	BlueFlagHook = 0x807deb04;
	setPaneVisible = 0x8062c864;
	BalloonCTR = 0x8089838e;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x80894024;
	BlueShellSpeed2 = 0x80894084;

	/* Bomb Lag Fix */
	NoFakeBomb = 0x805606E8;
	NoDmgChange = 0x80557FC0;

	/* Bullet Bill Exhaust Animation Fix */
	BillAnimationFixHook = 0x805899E0;
	EffectPointer = 0x809B0810;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808A3E70;
	CannonLandingFixHook = 0x805665B4;
	CannonSpeed = 0x8057311C;
	CannonSpeed2 = 0x80573128;
	BulletBillPosition = 0x8058AD54;

	/* CalcRecovery */
	CalcRecoveryHook_Push = 0x8078A488;
	CalcRecovery_WriteNegate = 0x8078A508;
	CalcRecoveryHook_Pop = 0x8078A524;

	/* Cancel Shrunk Status When Using Star */
	KartStarShrinkCancel_Hook = 0x8056E3A0;
	KartShrinkEnd = 0x8056EADC;

	/* Cannon Fixes */
	CannonOffroadFix = 0x80572B40;
	CannonTCFix = 0x80572BC8;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8061C450;
	CreateScreen = 0x80611100;
	PushButton_HandleClick = 0x805AC3B0;
	PushButton_Vtable = 0x808A5C30;
	ChangeCharsHook2 = 0x80611220;
	ChangeCharsHook3 = 0x8061C4C8;

	/* Chase Icon Fix */
	ChaseIconHook = 0x807E1A98;
	DrawShit = 0x80554078;
	ChasePointer = 0x809AFEA8;

	/* Clear Exhaust Pipe Boost Particle After Damage */
	ClearExhaustHook = 0x80555510;

	/* Conditional Out of Bounds */
	ConditionalOutofBoundsHook = 0x8055F8CC;

	/* Crazy Eight */
	CrazyEightEnableCircling = 0x80893DD0;
	ItemAssignerCall = 0x8077FE08;
	ItemAssignerCall2 = 0x807AA854;
	ItemAssignerStackFixHook = 0x807841C4;
	ItemAssignerHook2 = 0x807841E8;
	ItemAssignerHook3 = 0x807841EC;
	ItemAssignerHook4 = 0x80784274;
	ItemAssignerHook5 = 0x80784290;
	ItemAssignerStackFix2Hook = 0x807842D8;
	ItemUsageFixHook = 0x80782C44;
	ItemUsageFixHook2 = 0x80782DB4;
	DestroyItem = 0x80794AC0;

	/* Credits Button */
	CreditsButton = 0x8083F68B;

	/* Region Line Color Changer */
	LocalIDHook = 0x8063F6E4;
	USERIDHook = 0x80651488;
	LineColorHook = 0x807DE7EC;

	/* Cycle Fixes - Coconut Mall */
	EscalatorFixHook = 0x807EED84;
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

	/* DC Bug Fix */
	DCFix = 0x8052D70C;
	
	/* DC Prevention from laggy players */
	DCPrevention = 0x80643A04;

	/* Disable Event Receive Thunder Cloud Pass Radius Check */
	DisableTCPassRadiusCheck = 0x8079FB00;

	/* Disable Fake Hits From Statuses For Online Players */
	DisableFakeHitsFromStatuses_Hook1 = 0x8055DF24;
	DisableFakeHitsFromStatuses_Hook2 = 0x8055DFB0;
	DisableFakeHitsFromStatuses_Hook3 = 0x8055E0E4;
	DisableFakeHitsFromStatuses_Hook4 = 0x8055E280;
	DisableFakeHitsFromStatuses_Hook5 = 0x8055E47C;
	DisableFakeHitsFromStatuses_Hook6 = 0x8055E60C;

	/* Disable Item Poof */
	NoItemPoof = 0x80784980;
	NoItemPoof2Hook = 0x8078FE14;
	NoItemPoof3Hook = 0x8078FE24;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80707CC8;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807E3187;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80844920;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x80893F90;

	/* Driver Cheer On Star/Mega/Bullet Hits */
	DriverCheerOnSMBHits_Hook1 = 0x8055DF54;
	DriverCheerOnSMBHits_Hook2 = 0x8055DFE0;
	DriverCheerOnSMBHits_Hook3 = 0x8055E114;
	DriverCheerOnSMBHits_Hook4 = 0x8055E2B0;
	DriverCheerOnSMBHits_Hook5 = 0x8055E4AC;
	DriverCheerOnSMBHits_Hook6 = 0x8055E63C;
	DriverStartCheerNetRecv = 0x8057BC64;
	DriverNetSendCheer = 0x8057F880;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x8077FD30;

	/* Dynamic Item Sizing */
	DynamicSizingHook = 0x80774424;
	DynamicSizingHook2 = 0x807BFB00;
	DynamicSizingHook3 = 0x8078D004;
	DynamicSizingHook4 = 0x8078D3DC;
	DynamicSizingHook7 = 0x8078C2DC;
	BombVisualSizeHook = 0x80792A1C;
	BombVisualSizeHook2 = 0x8079447C;
	BombSizeHook2 = 0x80792B50;
	BombSizeHook3 = 0x80793A3C;
	BlueVisualSizeHook = 0x8079C624;
	BlueSizeHook2 = 0x8079C744;
	BlueExplosionFunc = 0x8079C318;

	/* Exception Handler */
	ShowExceptions = 0x80295404;

	/* Fast POW */
	NoPOWDelay = 0x807A018C;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x8037702C;
	FasterMenuHook2 = 0x80885158;
	FasterMenuHook3 = 0x80623A68;

	/* Faster Score Increase */
	ScoreSkip = 0x807E3BB7;
	NoTransition = 0x8084A360;

	/* Feather Cut Indicators */
	FCIHook1 = 0x8080E14C;
	FCIHook2 = 0x8080E16C;

	/* Feather Item */
	FeatherUseFunc = 0x80893CF4;
	FeatherOnlineFixHook = 0x8078514C;
	FeatherFilename = 0x80893D18;
	FeatherSpeed = 0x808A409C;
	GenerateEVENT = 0x8078A5E0;
	SubtractItem = 0x807AAD3C;
	FeatherInvisWallHook = 0x805A48C0;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x8088F538;
	FastMusicHook = 0x806F9674;
	FastMusicHook2 = 0x806FFE80;
	FastMusicHook3 = 0x8061E488;

	/* Fix Offroad Glitch */
	OffroadRampGlitchFixHook = 0x805706D4;

	/* Fix Online Players Stuck in Halfpipe */
	HalfPipeFixHook = 0x80579FB0;

	/* Force Battle Glitch */
	TagDistance = 0x808C22AC;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x80522BA8;
	RampUpSpeedFixHook = 0x80569A0C;
	DriftSpeedHook = 0x8056BF70;
	DriftSpeedHook2 = 0x8056C17C;
	DriftSpeedHook3 = 0x8056C5FC;
	DriftSpeedHook4 = 0x8056CAF8;
	DriftSpeedHook5 = 0x8056D05C;
	BoostAccelHook = 0x80576F0C;
	BrakeDriftClassicHook = 0x8050D61C;
	BrakeDriftGCNHook = 0x8050E2C0;
	BrakeDriftNunchuckHook = 0x80734074;
	BrakeDriftWheelHook = 0x80734330;
	BrakeDriftMainHook = 0x80568E44;
	BrakeDriftSoundHook = 0x806E93A0;
	BrakeDriftEffBikesHook = 0x80688040;
	BrakeDriftEffKartsHook = 0x806872F8;
	BrakeDriftEffFunc = 0x8068FD80;
	BrakeDriftEffFunc2 = 0x8068FF10;
	FastFallingHook = 0x805847E4;
	FastFallingHook2 = 0x805853E4;
	RedSpeedHook = 0x807992D4;

	/* Game Mode - Teams */
	NoItemGlow = 0x807AB67C;
	NoTeamInvincibility = 0x80560668;
	NoTeamInvincibility2 = 0x805612F0;
	NoTeamInvincibility3 = 0x8067C680;
	NoTeamInvincibility4 = 0x8079EF9C;
	NoTeamInvincibility5 = 0x8055DD88;
	NoTeamInvincibility6 = 0x8067C6C4;

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
	TimerManagerHook = 0x80523CD4;
	VehicleRestrictionHook = 0x80833964;
	MessageButtons = 0x805CA587;
	MessageButtons2Hook = 0x805C957C;
	MessageButtons3Hook = 0x805C8F18;
	RandomComboPickerHook = 0x805CC8F4;
	GetWeightClass = 0x8080B0FC;
	DriftMenuBackFixHook = 0x8083C534;
	DriftMenuBackFix2Hook = 0x808AA4FC;
	DriftMenuBackFix2Return = 0x8083CAB8;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808C6508;
	GeoHitTableItemObj = 0x808C6520;
	GeoHitTableKartHook = 0x80818838;
	GeyserCollFix = 0x8056141F;

	/* Glitch Prevention */
	DisableWallrideHook = 0x8056A070;
	TCGlitchFixHook = 0x8079ED2C;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x8089421C;

	/* Host Version Check */
	GuestSendHook = 0x800DBD98;
	HostCheckHook = 0x800DC4F8;
	DWCiCheckResvCommand = 0x800DE718;
	HostCheckHelperHook = 0x800DC410;
	Original30 = 0x80264E30;

	/* Hybrid Drift */
	HybridDrift1 = 0x80582AB8;
	HybridDrift3Hook = 0x8056C000;
	HybridDrift4Hook = 0x8056C448;
	HybridDrift5Hook = 0x80566E24;
	HybridDrift6Hook = 0x8056C160;
	HybridDrift7 = 0x80582566;
	HybridDrift8Hook = 0x8056C05C;
	WiiWheelFix = 0x808B9BA2;
	WiiWheelFix2 = 0x80733E70;
	CameraFix = 0x80591614;

	/* Impervious TC */
	ImperviousTCHook = 0x8079DE68;

	/* Inside Drift Bikes */
	KartParamHook = 0x80580040;

	/* Instant DC */
	WiiWheel = 0x803337E2;
	InstantDCHook = 0x8052D4C8;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x8081729C;
	ItemBoxFix = 0x8075B1A0;
	ItemBoxFix2 = 0x8075B2D7;
	ItemBoxFix3Hook = 0x8075C0CC;

	/* Item Cycler */
	ItemCyclerHook = 0x807DD258;

	/* Item Textures */
	ItemTexturesHook = 0x8084EEB0;
	ItemRouletteUpdate1Hook = 0x807A85B4;
	ItemRouletteUpdate2Hook = 0x807A87F4;
	ItemRouletteUpdate3Hook = 0x807DD79C;
	OriginalTextures = 0x8089DC20;
	DoubleShroom = 0x8089DE07;

	/* KCP Map */
	KCPMapHook = 0x807d88a0;
	KCPMapHook1 = 0x807d8aa4;
	CtrlRace2dMapObject_vt = 0x808c1d98;
	CtrlRace2dMapObject_initSelf = 0x807d8fec;
	LayoutUIControl_construct = 0x8062bab0;
	UIControl_insertChild = 0x8062b590;
	ControlLoader_load = 0x805b0cc4;
	TranslateCoordinates = 0x807ceca4;
	Map2DRenderer = 0x809b2598;

	/* Kart Status Stacker */
	StarStackHook = 0x8056E314;
	StarStack2 = 0x805599E0;
	StarTimer = 0x3F30;
	MegaStackHook = 0x8056EBA0;
	MegaTimer = 0x3E3C;
	BulletStackHook = 0x805898B0;
	ShockStackHook1 = 0x8056E7F4;
	ShockStackHook2 = 0x8068C350;
	ShroomStackHook = 0x8056D4C0;
	ShroomTimer = 0x3FA0;

	/* Lap Counter */
	ColorFixHook = 0x807DDBA8;
	PositionFixHook1 = 0x807DDC24;
	PositionFixHook2 = 0x807DDAEC;

	/* License Unlocker */
	LicenseUnlocker = 0x805379CC;

	/* MK7 Shock Squishing */
	SquishCheckHook = 0x8055DDA4;
	SquishFunc = 0x80557923;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x8077EFC8;
	ItemLimits = 0x809B158C;

	/* Mega Flips Cars */
	MegaFlip = 0x80818FC3;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x80580180;
	FOVChange = 0x80567410;

	/* Mega Thundercloud */
	MegaTCHook = 0x8056E688;
	TCFileName1 = 0x808942F0;
	TCFileName2 = 0x808943D4;
	MegaFunc = 0x8056EB6C;
	BillFunc = 0x80573904;
	MegaTCHook2 = 0x8079E17C;

	/* Message Patch */
	MSGPatchHook = 0x805E6FEC;
	MSGPatchHook2 = 0x80843808;
	MSGPatchHook3 = 0x807E6F18;
	TitleCTR = 0x80886EC9;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807D9520;

	/* Motion-Sensor Bombs */
	BombTimer = 0x80793FB6;
	BombTimer2 = 0x80792E8A;

	/* Newbie Helper */
	RespawnHelperHook = 0x80561E80;
	RespawnHelperHook2 = 0x80567C78;
	RespawnHelperHook3 = 0x8056FD54;
	InstaDraftHook = 0x80575338;
	StarHelperHook1 = 0x8056E330;
	StarHelperHook2 = 0x805599E4;
	MegaHelperHook = 0x8056EBA4;

	/* No Bullet Bill Cancel When Touching Bottom of Rainbow Road */
	NoBillCancelRR = 0x80589E88;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807A8990;

	/* No Character Voices */
	NoCharVoiceHook = 0x807045B0;
	
	/* No Disconnect */
	NoDC1 = 0x8050F42C;
	NoDC2 = 0x8052CCEC;
	NoDC3 = 0x8052CFC4;
	NoDC4 = 0x8052D10C;
	NoDC5 = 0x8052D17C;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x805557EC;
	NoRespawnInv = 0x805556A6;
	StarInBullet = 0x8056E2CA;
	ShroomInBullet = 0x8056D43A;
	StarWhenHit = 0x8056E2FC;
	ShroomWhenHit = 0x8056D4A8;

	/* No Multi Channel Track Music */
	NoMultiChannelHook = 0x806E8ED4;
	NoMultiChannelHook2 = 0x800A4F78;
	FirstCall = 0x80707994;

	/* No Music */
	NoMusicHook = 0x8009136C;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x8084187B;
	RaceCountFix2 = 0x80841DF8;
	RaceCountFix3 = 0x80841E00;
	RaceCountFix4 = 0x80840CB0;
	RaceCountFix5 = 0x80840D90;

	/* Online Stuff */
	ForceCCHook = 0x8064F71C;
	FroomRaceCount = 0x806343D3;
	FroomRaceCount2 = 0x8063D837;

	/* POW Yourself in 1st */
	POWSelfHook = 0x807A01F0;

	/* Patch.szs */
	SZSCount = 0x8051812F;
	PatchSZSHook = 0x805183B0;
	FilenameEndings = 0x808A15F8;
	DefaultFileEnding = 0x8087E200;
	CommonFix = 0x8089074E;

	/* Patch Effects */
	GetFile = 0x8052F254;
	EffectConstruct = 0x8022600C;
	PlayerEffectConstruct = 0x8067C340;
	EffectDrawer = 0x80669C98;
	EffectBind = 0x8067D3EC;
	EGGEffectConstruct = 0x80223040;
	EffectCreate = 0x8054267C;
	EffectDestroy = 0x805091B8;
	EffectLoad = 0x8067CD6C;
	EffectBCTRL = 0x8067CC30;

	/* Pause Menu Fix */
	PauseMenuScreenHook = 0x8061AA64;
	PauseMenuScreenHook2 = 0x8061ABA8;

	/* Payload Hook */
	RelHook = 0x801A708C;

	/* Play VS Race Alone */
	NoCPU = 0x80841508;

	/* Points Modifier */
	PointsModifierHook = 0x8051CC90;

	/* Prediction Removal */
	PredictionRemoval = 0x8087FF30;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807AA9F0;

	/* Random FIB Colors */
	FIBFunc = 0x80796350;
	FIBString = 0x80893C55;

	/* Red Shell Curve Time Desync Fix */
	RedCurveHook = 0x807A34F8;

	/* Red Shell Target Modifier */
	TargetWhileRespawn = 0x8057F2EE;
	TargetWhileHit = 0x8057F33B;
	TargetPositionHook = 0x807A1C60;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807A8437;
	RemoveFakeShroom = 0x807A8844;

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

	/* Set Default Drift Type */
	DefaultDriftType = 0x805343C4;

	/* Shells Never Break */
	ShellHitCount = 0x807A42D4;
	ShellHitCount2 = 0x8079D070;

	/* Show Mega Damage For Online Players */
	ShowOnlinePlayerMegaDmg = 0x8057B703;

	/* Show Time Difference */
	TimeDiffPatchHook = 0x807DC948;
	TimeDiffApplyHook = 0x80844678;
	TimeDiffPosHook = 0x80846898;

	/* Show Timers */
	TimerShow = 0x8063E56C;

	/* Show Times After Race */
	ShowTimesVS = 0x8084ACDC;
	ShowTimesWW = 0x8084B820;
	TimesFunc = 0x807E3D1C;
	TimePrintHook = 0x807E3DE0;

	/* Silent Controller Changing */
	NoControllerDC = 0x806093B8;

	/* Slot Crash Patches */
	SLFix = 0x8067C370;
	SGBFix = 0x80815DF4;
	MHFix = 0x80815D6C;
	MHMatFix = 0x8077C5AC;
	GetResMdl = 0x8004C2A0;
	GetResMat = 0x8004E950;
	MatPointer = 0x808BFCF8;

	/* Speed Modifier */
	SpeedMod1 = 0x80569A08;
	SpeedMod2 = 0x805665B0;
	SpeedMod3 = 0x80573920;
	SpeedMod4 = 0x805699F8;
	SpeedMod5 = 0x80569C1C;
	SpeedMod6 = 0x80569DD8;
	SpeedMod7 = 0x80569DB4;
	SpeedMod8 = 0x80580204;
	SpeedMod9 = 0x80580214;
	SpeedMod10 = 0x80580224;
	SpeedMod11 = 0x80580234;
	SpeedMod12 = 0x805801E4;
	SpeedBuff = 0x8057D6CC;
	SpeedModFloats = 0x80894220;
	SpeedModHalf = 0x3E6C;

	/* Speedometer */
	SpeedoTextParseNop = 0x805BBCF4;
	SpeedoTextParse = 0x805BBD30;
	SpeedoParseSkip = 0x805BBDC8;
	SpeedoNoPauseHook = 0x807D9934;

	/* Starting Lap Modifier */
	LapCount1 = 0x805208FC;
	LapCount2 = 0x80521700;
	LapCount3 = 0x80522398;
	LapCount4 = 0x80522C04;
	LapCount5 = 0x80522D30;
	LakituBoardHook = 0x807120E4;

	/* Super Miniturbo Multiplier */
	SMTMultiplier = 0x808A4148;
	SMTMinimum = 0x808A413E;

	/* Super Miniturbos on Outward Bikes */
	KartMTFunc = 0x8056CEA8;
	BikeMTFunc = 0x805768E0;
	BikeMTParticles = 0x80681866;
	OutwardSMT = 0x80691308;

	/* Time Limit Modifier */
	TimeLimit = 0x8052D410;

	/* Track Identifier */
	TrackIdentifierHook = 0x80501DE0;
	TrackIdentifierDeleteHook = 0x80500788;
	ITPHHook = 0x80501C84;
	ITPTHook = 0x80501B64;
	CKPTHook = 0x805016C8;
	AREAHook = 0x80501380;
	JGPTHook = 0x8050114C;
	CKPHHook = 0x8050180C;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807A8520;
	SpecialItemHook = 0x807884A8;
	ItemAmountHook = 0x807AAD18;

	/* Ultra MiniTurbos */
	CreateUMT = 0x8056CEB4;
	BuffUMT = 0x80571034;
	UMTMultiplier = 0x805673A4;
	UpdateBoost = 0x80576E7C;
	DriftStateCheck = 0x80686424;
	KartDriftEffectHandler = 0x806865D0;
	CreateEffect = 0x8068597C;
	DestroyEffect = 0x80685B30;
	PatchBoost = 0x806920B0;
	BoostMatrix = 0x8068A348;
	HandleBase = 0x80037650;
	UMTSound = 0x806F7960;
	HoldSound = 0x806F76E0;
	DetailPlay = 0x800A3EE0;
	DetailHold = 0x800A3FF0;

	/* Ultra UnCut */
	CKPTCheck = 0x80523170;

	/* VS Menu Skip */
	VSMenuSkipHook = 0x808407EC;
	VSMenuSkipHook2 = 0x805E9BAC;
	VSMenuSkip3 = 0x8061B654;
	VSMenuSkip4 = 0x8061EAEB;
	VSMenuReturnHook = 0x80840EDC;
	VSMenuReturn = 0x8083DEF8;
	VSMenuReturnHook2 = 0x80840E08;
	VSMenuReturn2Func = 0x808262E0;
	VSMenuSkipMulti = 0x805F176B;
	NoGhostLoading = 0x8060F5D4;

	/* Wiilink */
	WL_Code_Text_Hook = 0x800EE110;
	WL_Code_Data_Hook = 0x800EDEFC;
	WL_Auth_Response_Hook = 0x800EE41C;
	WL_Domain_Hook = 0x80268C15;
	WL_URL_Hook = 0x802682DC;
	WL_Skip_DNS = 0x800D1578;

	/* Anti-Wiimmfi */
	Anti_Wiimmfi_1 = 0x800EE418;
	Anti_Wiimmfi_2 = 0x800ECB24;
	Anti_Wiimmfi_3 = 0x80005EFC;

	/* Wiimmfi */
	WiimmfiPatch1 = 0x800ED8E0;
	WiimmfiPatch2 = 0x800ECB24;
	WiimmfiPatch3 = 0x800EE418;
	WiimmfiPatch4 = 0x801D5258;

	LoginRegion = 0x80372FD0;
	VSRegion = 0x8064195C;
	VSRegion2 = 0x80647524;
	VSRegion3 = 0x80647A3C;
	VSRegion4 = 0x8064834C;

	WiimmfiVersionString = 0x80263E34;
	WiimmfiURLs = 0x802682B4;

	/* Woodbox Modifier */
	WoodRespawn = 0x808BF728;
	WoodProb = 0x8075D1E8;
	BushFunc = 0x807556E8;
}