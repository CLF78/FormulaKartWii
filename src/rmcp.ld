SECTIONS {
	/* Base Functions */
	DVDOpen = 0x8015E2BC;
	DVDReadPrio = 0x8015E834;
	DVDClose = 0x8015E568;
	sprintf = 0x80011A2C;
	snprintf = 0x80011938;
	swprintf = 0x80017814;
	OSReport = 0x801A25D0;
	OSFatal = 0x801A4EC4;
	CalcCRC32 = 0x801D1CA0;
	new = 0x80229DD8;
	delete = 0x80229E14;

	/* Codehandler Hooks */
	VIHook = 0x801BAB20;
	KPADHook = 0x80197AA8;
	GXDrawHook = 0x8016EB6C;
	GXFlushHook = 0x8016E6AC;
	OSSleepHook = 0x801AAAA0;
	AXNextFrameHook = 0x801265A0;

	/* Common Classes and Functions */
	SystemManager = 0x80386000;
	Racedata = 0x809BD728;
	Raceinfo = 0x809BD730;
	KMPdata = 0x809BD6E8;
	ArchiveRoot = 0x809BD738;
	PlayerHolder = 0x809C18F8;
	KartParam = 0x809C1918;
	DriverParam = 0x809C191C;
	Menudata = 0x809C1E38;
	RKNetController = 0x809C20D8;
	RKNetItemHandler = 0x809C20F8;
	ItemHolder = 0x809C3618;
	ItemStructs = 0x809C36B8;
	ItemStructsEX = 0x809C2F48;
	ScreenHUD = 0x809C4680;

	/* Math Functions */
	cos = 0x8001b590;
	sin = 0x8001ba98;
	tan = 0x8001bb64;
	atan = 0x80085250;
	atan2 = 0x800853c0;
	acos = 0x8001bbdc;
	pow = 0x8001bbf0;
	sqrt = 0x8001bbf4;
	rd_atan2 = 0x8001bbe4;

	PlayerGetControllerHolder = 0x805903F4;
	getPlayerById = 0x80590100;
	getPlayerPosition = 0x8059020C;

	NETSHA1Init = 0x801D24F4;
	NETSHA1Update = 0x801D2544;
	NETSHA1GetDigest = 0x801D25F8;

	SetPaneColor = 0x807EBF20;
	SetTextSrc = 0x805CDD00;
	SetMatText = 0x8063DCBC;

	playerCount = 0x809C38B8;
	isOnlineRace = 0x809C38B9;

	CalcRandom = 0x800AD050;
	canItemBeGotten = 0x80799BE8;

	ptmf_test = 0x800213E4;
	ptmf_scall = 0x80021450;

	SubtractTimers = 0x807EE860;

	/* 30 FPS */
	ThirtyFPSHook1 = 0x80009A3C;
	ThirtyFPSHook2 = 0x800092AB;
	ThirtyFPSHook3 = 0x800090AF;
	ThirtyFPSHook4 = 0x8051AF94;
	ThirtyFPSHook5 = 0x8051B33C;
	ThirtyFPSHook6 = 0x8051B32B;

	/* 30 Second Time Limit */
	ThirtySecs = 0x8053EC8E;

	/* All Items Can Land */
	AICLUnk1 = 0x807A66C4;
	AICLUnk2 = 0x80796D30;
	NoItemLandingPoof = 0x80790EF0;
	ItemLandMega = 0x808B54D0;
	ItemLandFeather = 0x808B54E8;
	ItemLandGolden = 0x808B5500;
	ItemLandBill = 0x808B550C;

	/* Always Win Track Vote */
	AlwaysWinVoteHook = 0x80661E20;

	/* Automatic BRSAR Patch */
	AutoBRSARHook = 0x800912D4;

	/* BRCTR Redirector */
	LapNumberCTR = 0x808A9CC7;
	ItemWindowCTR = 0x808A9C0A;
	MapCharaCTR = 0x808A94E6;

	/* Banana/Blue/Bomb Spinout Modifier */
	BananaDamage = 0x80573188;
	BlueSpinoutDmg = 0x805731C3;
	BombSpinoutDmg = 0x805731DB;

	/* Blue Shell Speed */
	BlueShellSpeed = 0x808A5BC4;
	BlueShellSpeed2 = 0x808A5C24;

	/* Bomb Lag Fix */
	NoFakeBomb = 0x80572690;
	NoDmgChange = 0x80569F68;
	
	/* Bullet Bill Exhaust Animation Fix */
	BillAnimationFixHook = 0x8059B988;
	EffectPointer = 0x809C21D0;

	/* Bullet Bill Speed Modifier */
	BulletBillSpeed = 0x808B59F8;
	CannonLandingFixHook = 0x8057855C;
	CannonSpeed = 0x805850C4;
	CannonSpeed2 = 0x805850D0;
	BulletBillPosition = 0x8059CCFC;

	/* Change Characters Between Races */
	ChangeCharsHook = 0x8062E058;
	CreateScreen = 0x80622D08;
	PushButton_HandleClick = 0x805BE358;
	PushButton_Vtable = 0x808B77B8;
	ChangeCharsHook2 = 0x80622E28;
	ChangeCharsHook3 = 0x8062E0D0;
	
	/* Conditional Out of Bounds */
	ConditionalOutofBoundsHook = 0x80571874;

	/* Crazy Eight */
	CrazyEightEnableCircling = 0x808A5970;
	ItemAssignerCall = 0x80791A48;
	ItemAssignerCall2 = 0x807BC494;
	ItemAssignerStackFixHook = 0x80795E04;
	ItemAssignerHook2 = 0x80795E28;
	ItemAssignerHook3 = 0x80795E2C;
	ItemAssignerHook4 = 0x80795EB4;
	ItemAssignerHook5 = 0x80795ED0;
	ItemAssignerStackFix2Hook = 0x80795F18;
	ItemUsageFixHook = 0x80794884;
	ItemUsageFixHook2 = 0x807949F4;
	DestroyItem = 0x807A6700;

	/* Credits Button */
	CreditsButton = 0x808512CB;

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

	/* DC Bug Fix */
	DCFix = 0x8053F6B4;
	
	/* DC Prevention from laggy players */
	DCPrevention = 0x806556EC;

	/* Disable Item Poof */
	NoItemPoof = 0x807965C0;
	NoItemPoof2Hook = 0x807A1A54;
	NoItemPoof3Hook = 0x807A1A64;

	/* Disable TF Music Reset */
	NoTFMusicReset = 0x80719920;

	/* Don't Hide Position After Race */
	NoHidePos = 0x807F4DC7;

	/* Don't Lose VR When Disconnecting */
	NoVRLoss = 0x80856560;

	/* Draggable Blue Shells */
	BlueShellDrag = 0x808A5B30;

	/* Duplicated Item Auto-Trail */
	AutoTrailHook = 0x80791970;

	/* Dynamic Item Sizing */
	DynamicSizingHook = 0x80786064;
	DynamicSizingHook2 = 0x807D1740;
	DynamicSizingHook3 = 0x8079EC44;
	DynamicSizingHook4 = 0x8079F01C;
	DynamicSizingHook7 = 0x8079DF1C;
	BombVisualSizeHook = 0x807A465C;
	BombVisualSizeHook2 = 0x807A60BC;
	BombSizeHook2 = 0x807A4790;
	BombSizeHook3 = 0x807A567C;
	BlueVisualSizeHook = 0x807AE264;
	BlueSizeHook2 = 0x807AE384;
	BlueExplosionFunc = 0x807ADF58;

	/* Exception Handler */
	ShowExceptions = 0x802A7404;

	/* Fast POW */
	NoPOWDelay = 0x807B1DCC;

	/* Faster Menu Navigation */
	FasterMenuHook = 0x8038900C;
	FasterMenuHook2 = 0x80896830;
	FasterMenuHook3 = 0x80635670;

	/* Faster Score Increase */
	ScoreSkip = 0x807F57F7;
	NoTransition = 0x8085BFA0;

	/* Feather Cut Indicators */
	FCIHook1 = 0x8081FD8C;
	FCIHook2 = 0x8081FDAC;

	/* Feather Item */
	FeatherUseFunc = 0x808A5894;
	FeatherOnlineFixHook = 0x80796D8C;
	FeatherFilename = 0x808A58B8;
	FeatherSpeed = 0x808B5C24;
	GenerateEVENT = 0x8079C220;
	SubtractItem = 0x807BC97C;
	FeatherInvisWallHook = 0x805B6868;

	/* Final Lap Music Trigger Modifier */
	MusicPitch = 0x808A10D8;
	FastMusicHook = 0x8070B2CC;
	FastMusicHook2 = 0x80711AD8;
	FastMusicHook3 = 0x80630090;

	/* Force Battle Glitch */
	TagDistance = 0x808D3E14;

	/* Game Mode - Ramp Up */
	RampUpHook = 0x80534B50;
	RampUpSpeedFixHook = 0x8057B9B4;
	DriftSpeedHook = 0x8057DF18;
	DriftSpeedHook2 = 0x8057E124;
	DriftSpeedHook3 = 0x8057E5A4;
	DriftSpeedHook4 = 0x8057EAA0;
	DriftSpeedHook5 = 0x8057F004;
	BoostAccelHook = 0x80588EB4;
	BrakeDriftClassicHook = 0x8051F5F8;
	BrakeDriftGCNHook = 0x8052029C;
	BrakeDriftNunchuckHook = 0x80745CB4;
	BrakeDriftWheelHook = 0x80745F70;
	BrakeDriftMainHook = 0x8057ADEC;
	BrakeDriftSoundHook = 0x806FAFF8;
	BrakeDriftEffBikesHook = 0x80699C98;
	BrakeDriftEffKartsHook = 0x80698F50;
	BrakeDriftEffFunc = 0x806A19D8;
	BrakeDriftEffFunc2 = 0x806A1B68;
	FastFallingHook = 0x8059678C;
	FastFallingHook2 = 0x8059738C;
	RedSpeedHook = 0x807AAF14;

	/* Game Mode - Teams */
	NoItemGlow = 0x807BD2BC;
	NoTeamInvincibility = 0x80572610;
	NoTeamInvincibility2 = 0x80573298;
	NoTeamInvincibility3 = 0x8068E2D8;
	NoTeamInvincibility4 = 0x807B0BDC;
	NoTeamInvincibility5 = 0x8056FD30;
	NoTeamInvincibility6 = 0x8068E31C;

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
	TimerManagerHook = 0x80535C7C;
	VehicleRestrictionHook = 0x808455A4;
	MessageButtons = 0x805DC3EB;
	MessageButtons2Hook = 0x805DB3E0;
	MessageButtons3Hook = 0x805DAD7C;
	RandomComboPickerHook = 0x805DE758;
	GetWeightClass = 0x8081CD3C;
	DriftMenuBackFixHook = 0x8084E174;
	DriftMenuBackFix2Hook = 0x808BC08C;
	DriftMenuBackFix2Return = 0x8084E6F8;

	/* GeoHit Patches */
	GeoHitTableItem = 0x808D8070;
	GeoHitTableItemObj = 0x808D8088;
	GeoHitTableKartHook = 0x8082A478;
	GeyserCollFix = 0x805733C7;

	/* Glitch Prevention */
	DisableWallrideHook = 0x8057C018;
	TCGlitchFixHook = 0x807B096C;

	/* Green Shell Speed Modifier */
	GreenShellSpeed = 0x808A5DBC;

	/* Highlight 1st Place */
	MapHighlighterHook = 0x807EB9D0;

	/* Host Version Check */
	GuestSendHook = 0x800DBD38;
	HostCheckHook = 0x800DC498;
	DWCiCheckResvCommand = 0x800DE6B8;
	HostCheckHelperHook = 0x800DC3B0;
	Original30 = 0x80277050;

	/* Hybrid Drift */
	HybridDrift1 = 0x80594A60;
	HybridDrift3Hook = 0x8057DFA8;
	HybridDrift4Hook = 0x8057E3F0;
	HybridDrift5Hook = 0x80578DCC;
	HybridDrift6Hook = 0x8057E108;
	HybridDrift7 = 0x8059450E;
	HybridDrift8 = 0x805A35BC;
	WiiWheelFix = 0x808CB70A;
	WiiWheelFix2 = 0x80745AB0;

	/* Impervious TC */
	ImperviousTCHook = 0x807AFAA8;

	/* Inside Drift Bikes */
	KartParamHook = 0x80591FE8;

	/* Instant DC */
	WiiWheel = 0x803457E2;
	InstantDCHook = 0x8053F470;

	/* Instant Item Boxes */
	InstantItemBoxes = 0x80828EDC;
	ItemBoxFix = 0x8076CDE0;
	ItemBoxFix2 = 0x8076CF17;
	ItemBoxFix3Hook = 0x8076DD0C;

	/* Item Textures */
	ItemTexturesHook = 0x80860AF0;
	ItemRouletteUpdate1Hook = 0x807BA1F4;
	ItemRouletteUpdate2Hook = 0x807BA434;
	ItemRouletteUpdate3Hook = 0x807EF3DC;
	OriginalTextures = 0x808AF7C0;
	DoubleShroom = 0x808AF9A7;

	/* KCP Map */
	KCPMapHook = 0x807ea4e0;
	KCPMapHook1 = 0x807ea6e4;
	CtrlRace2dMapObject_vt = 0x808d3900;
	CtrlRace2dMapObject_initSelf = 0x807eac2c;
	LayoutUIControl_construct = 0x8063d798;
	UIControl_insertChild = 0x8063d278;
	ControlLoader_load = 0x805c2c60;
	TranslateCoordinates = 0x807e08e4;
	Map2DRenderer = 0x809c3f58;

	/* Lap Counter */
	ColorFixHook = 0x807EF7E8;
	PositionFixHook = 0x807EF864;

	/* License Unlocker */
	LicenseUnlocker = 0x80549974;

	/* MK7 Shock Squishing */
	SquishCheckHook = 0x8056FD4C;
	SquishFunc = 0x805698CB;

	/* Max Item Limit Modifier */
	ItemLimitSetup = 0x80790C08;
	ItemLimits = 0x809C2F4C;

	/* Mega Flips Cars */
	MegaFlip = 0x8082AC03;

	/* Mega Mushroom Size Multiplier */
	MegaSizeHook = 0x80592128;
	FOVChange = 0x805793B8;

	/* Mega Thundercloud */
	MegaTCHook = 0x80580630;
	MegaFunc = 0x80580B14;
	BillFunc = 0x805858AC;
	MegaTCHook2 = 0x807AFDBC;

	/* Message Patch */
	MSGPatchHook = 0x805F8BCC;
	MSGPatchHook2 = 0x80855448;
	MSGPatchHook3 = 0x807F8B58;
	TitleCTR = 0x80898A91;

	/* Mii Heads on Minimap */
	MiiHeadsHook = 0x807EB160;

	/* Motion-Sensor Bombs */
	BombTimer = 0x807A5BF6;
	BombTimer2 = 0x807A4ACA;

	/* Newbie Helper */
	RespawnHelperHook = 0x80573E28;
	RespawnHelperHook2 = 0x80579C20;
	RespawnHelperHook3 = 0x80581CFC;
	InstaDraftHook = 0x805872E0;
	
	/* No Bullet Bill Cancel When Touching Bottom of Rainbow Road */
	NoBillCancelRR = 0x8059BE30;

	/* No Bullet Bill Icon */
	NoBBIcon = 0x807BA5D0;

	/* No Character Voices */
	NoCharVoiceHook = 0x80716208;
	
	/* No Disconnect */
	NoDC1 = 0x80521408;
	NoDC2 = 0x8053EC94;
	NoDC3 = 0x8053EF6C;
	NoDC4 = 0x8053F0B4;
	NoDC5 = 0x8053F124;

	/* No Invincibility Frames */
	NoInvFramesHook = 0x80567794;
	NoRespawnInv = 0x8056764E;
	StarInBullet = 0x80580272;
	ShroomInBullet = 0x8057F3E2;
	StarWhenHit = 0x805802A4;
	ShroomWhenHit = 0x8057F450;

	/* No Multi Channel Track Music */
	NoMultiChannelHook = 0x806FAB2C;
	NoMultiChannelHook2 = 0x800A4F18;
	FirstCall = 0x807195EC;

	/* No Music */
	NoMusicHook = 0x8009130C;

	/* Offline Race Count Modifier */
	RaceCountFix1 = 0x808534BB;
	RaceCountFix2 = 0x80853A38;
	RaceCountFix3 = 0x80853A40;
	RaceCountFix4 = 0x808528F0;
	RaceCountFix5 = 0x808529D0;

	/* Online Stuff */
	ForceCCHook = 0x80661404;
	FroomRaceCount = 0x806460BB;
	FroomRaceCount2 = 0x8064F51F;

	/* POW Yourself in 1st */
	POWSelfHook = 0x807B1E30;

	/* Patch.szs */
	SZSCount = 0x8052A18B;
	PatchSZSHook = 0x8052A358;
	FilenameEndings = 0x808B3188;
	DefaultFileEnding = 0x8088FE00;

	/* Pause Menu Fix */
	PauseMenuScreenHook = 0x8062C66C;
	PauseMenuScreenHook2 = 0x8062C7B0;

	/* Payload Hook */
	RelHook = 0x801A6D30;

	/* Play VS Race Alone */
	NoCPU = 0x80853148;

	/* Points Modifier */
	PointsModifierHook = 0x8052EC38;

	/* Prediction Removal */
	PredictionRemoval = 0x80891B28;

	/* Prevent Shock/POW Drop */
	DropFunc = 0x807BC630;

	/* Red Shell Target Modifier */
	TargetWhileRespawn = 0x80591296;
	TargetWhileHit = 0x805912E3;
	TargetPositionHook = 0x807B38A0;

	/* Remove Mushroom Bug */
	RemoveShroomBug = 0x807BA077;
	RemoveFakeShroom = 0x807BA484;

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

	/* Set Default Drift Type */
	DefaultDriftType = 0x8054636C;

	/* Shells Never Break */
	ShellHitCount = 0x807B5F14;
	ShellHitCount2 = 0x807AECB0;

	/* Show Time Difference */
	TimeDiffPatchHook = 0x807EE588;
	TimeDiffApplyHook = 0x808562B8;

	/* Show Timers */
	TimerShow = 0x80650254;

	/* Show Times After Race */
	ShowTimesVS = 0x8085C91C;
	ShowTimesWW = 0x8085D460;
	TimesFunc = 0x807F595C;
	TimePrintHook = 0x807F5A20;

	/* Silent Controller Changing */
	NoControllerDC = 0x8061AF98;

	/* Speedometer */
	SpeedoTextParseNop = 0x805CDD34;
	SpeedoTextParse = 0x805CDD70;
	SpeedoParseSkip = 0x805CDE08;
	SpeedoNoPauseHook = 0x807EB574;

	/* Starting Lap Modifier */
	LapCount1 = 0x805328A7;
	LapCount2 = 0x805336AB;
	LapCount3 = 0x80534343;
	LapCount4 = 0x80534BAF;
	LapCount5 = 0x80534CDB;
	LakituBoardHook = 0x80723D3C;

	/* Super Miniturbo Multiplier */
	SMTMultiplier = 0x808B5CD0;
	SMTMinimum = 0x808B5CC6;

	/* Time Limit Modifier */
	TimeLimit = 0x8053F3B8;

	/* Track Identifier */
	TrackIdentifierHook = 0x80513DC0;
	TrackIdentifierDeleteHook = 0x80512768;
	ITPHHook = 0x80513C64;
	ITPTHook = 0x80513B44;
	CKPTHook = 0x805136A8;
	AREAHook = 0x80513360;
	JGPTHook = 0x8051312C;
	CKPHHook = 0x805137EC;

	/* Ultimate Item Randomizer */
	SharedItemHook = 0x807BA160;
	SpecialItemHook = 0x8079A0E8;
	ItemAmountHook = 0x807BC958;

	/* Ultra UnCut */
	CKPTCheck = 0x80535118;

	/* VS Multi Menu Skip */
	VSMenuReturnHook = 0x80852B1C;
	VSMenuReturnNormFunc = 0x8084FB38;
	VSMenuReturnHook2 = 0x80852A48;
	VSMenuReturn2Func = 0x80837F20;
    VSMenuReturn2NormFunc = 0x80837B4C;
	VSMenuSkipMulti = 0x8060334B;
    VSMenuSkipOGInstr = 0x808B0000;
	NoGhostLoading = 0x806211DC;

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
	WiimmfiURLs = 0x8027A404;

	/* Woodbox Modifier */
	WoodRespawn = 0x808D1290;
	WoodProb = 0x8076EE28;
	BushFunc = 0x80767328;
}
