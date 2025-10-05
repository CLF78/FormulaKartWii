#include "common.h"

// This function loads all the codes that FKW uses after StaticR has loaded
void loadCodes() {

	// These values will be used as filler throughout the function
	u8 tempVal8;
	u16 tempVal16;
	u32 tempVal32;

	// Exception Handler (by Star)
	directWrite32(ShowExceptions, 0);
	
	// WiiLink Code Patches (by The WiiLink Team, ported by Palapeli and Ismy)
	#ifdef REGION_P
	directWriteArray(WL_Code_Text_Hook, WL_Code_Text_P, 0x58);
	directWriteArray(WL_Code_Data_Hook, WL_Code_Data_P, 0x4C);
	#elif REGION_E
	directWriteArray(WL_Code_Text_Hook, WL_Code_Text_E, 0x58);
	directWriteArray(WL_Code_Data_Hook, WL_Code_Data_E, 0x4C);
	#elif REGION_J
	directWriteArray(WL_Code_Text_Hook, WL_Code_Text_J, 0x58);
	directWriteArray(WL_Code_Data_Hook, WL_Code_Data_J, 0x4C);
	#elif REGION_K
	directWriteArray(WL_Code_Text_Hook, WL_Code_Text_K, 0x58);
	directWriteArray(WL_Code_Data_Hook, WL_Code_Data_K, 0x4C);
	#endif
	
	// WiiLink Auth response
	directWriteArray(WL_Auth_Response_Hook, WL_Auth_Response, 0x8);
	
	// WiiLink String Patches
	directWriteArray(WL_Domain_Hook, WL_Domain, 0x11);
	directWriteArray(WL_URL_Hook, WL_URL, 0x18);
	
	// WiiLink Skip DNS request caching
	directWrite32(WL_Skip_DNS, 0x480001F4);
	
	// Anti-Wiimmfi
	directWrite32(Anti_Wiimmfi_1, 0x2C030000);
	directWrite32(Anti_Wiimmfi_2, 0x7C7E1B78);
	directWrite32(Anti_Wiimmfi_3, 0x00004E4D);
	
	/*
	// Wiimmfi Code Patches (by Leseratte)
	directWriteNop(WiimmfiPatch1);
	directWrite32(WiimmfiPatch2, 0x3BC00000);
	directWriteBranch(WiimmfiPatch3, WiimmfiASM1, false);
	directWriteBranch(WiimmfiPatch4, WiimmfiASM2, false);

	// Wiimmfi String Patches (by Seeky)
	directWriteString(WiimmfiVersionString, "LE-CODE GCT v1 ");
	directWriteString(WiimmfiURLs, "://ca.nas.wiimmfi.de/ca");
	directWriteStringOffset(WiimmfiURLs, 0x28, "://naswii.wiimmfi.de/ac");
	directWriteStringOffset(WiimmfiURLs, 0xA8, "://naswii.wiimmfi.de/pr");

	#ifdef REGION_P
	directWriteStringOffset(WiimmfiURLs, 0x50, "main.nas.wiimmfi.de/pp");
	#elif REGION_E
	directWriteStringOffset(WiimmfiURLs, 0x50, "main.nas.wiimmfi.de/pe");
	#elif REGION_J
	directWriteStringOffset(WiimmfiURLs, 0x50, "main.nas.wiimmfi.de/pj");
	#elif REGION_K
	directWriteStringOffset(WiimmfiURLs, 0x50, "main.nas.wiimmfi.de/pk");
	#endif

	directWriteStringOffset(WiimmfiURLs, 0x964, "wiimmfi.de"); // Available
	directWriteStringOffset(WiimmfiURLs, 0x10D4, "wiimmfi.de"); // GPCM
	directWriteStringOffset(WiimmfiURLs, 0x1AEC, "wiimmfi.de"); // GPSP
	directWriteStringOffset(WiimmfiURLs, 0x2C8D, "wiimmfi.de"); // Master
	directWriteStringOffset(WiimmfiURLs, 0x38A7, "wiimmfi.de"); // Natneg
	directWriteStringOffset(WiimmfiURLs, 0x38C3, "wiimmfi.de");
	directWriteStringOffset(WiimmfiURLs, 0x38DF, "wiimmfi.de");
	directWriteStringOffset(WiimmfiURLs, 0x3A2F, "wiimmfi.de"); // MS
	directWriteStringOffset(WiimmfiURLs, 0x3AB3, "wiimmfi.de"); // SAKE
	*/
	
	// Login Region Changer (by Atlas)
	directWriteString(LoginRegion, "120045");
	
	// VS Matchmaking Region Patch (by Leseratte)
	directWrite32(VSRegion, 0x38A04E4D);
	directWrite32(VSRegion2, 0x38E04E4D);
	directWrite32(VSRegion3, 0x38E04E4D);
	directWrite32(VSRegion4, 0x3880004D);
	
	// Frameskip (by the Wiimmfi Team)
	directWriteBranch(FrameskipHook1, GetFrameskip1, true);
	directWriteBranch(FrameskipHook2, GetFrameskip2, true);
	directWriteNop(FrameskipHook3);
	directWriteNop(FrameskipHook4);
	directWrite32(FrameskipHook5, 0x480000DC);
	directWriteNop(FrameskipHook6);
	directWrite32(FrameskipHook7, 0x000F7709);
	directWrite32(FrameskipHook8, 0x00000006);

	// 1st Place Crown on Minimap (by Ro)
	directWriteBranch(CrownMinimapHook, CrownMinimap, true);

	// 30 Seconds Time Limit Modifier (by CLF78)
	directWrite16(ThirtySecs, 0x2A30);

	// All Items Can Land (by MrBean35000vr and CLF78)
	directWriteNop(AICLUnk1);
	directWrite32(AICLUnk2, 0x38600000);
	directWrite32(NoItemLandingPoof, 0x39800001);
	extern void* AllItemsCanLand;
	tempVal32 = (u32)&AllItemsCanLand;
	directWrite32(ItemLandMega, tempVal32);
	directWrite32(ItemLandGolden, tempVal32+8);
	directWrite32(ItemLandFeather, tempVal32+16);
	directWrite32(ItemLandBill, tempVal32+24);

	// Allow looking backwards during respawn (by Ro)
	directWriteNop(RespawnLookBack);

	// Allow looking backwards during the countdown (by Gaberboo)
	directWrite32(CountdownLookBack, 0x38800001);

	// Banana Spinout Modifier (by Skullface)
	directWrite32(BananaDamage, 0x38600001);

	// Blue Flag + BRCTR redirect (by stealthsteeler)
	directWrite8(BalloonCTR, 'e');
	directWriteBranch(BlueFlagHook, BlueFlagInject, false);

	// Blue Shell and Bomb Spinout Modifier (CLF78)
	tempVal8 = 1;
	directWrite8(BlueSpinoutDmg, tempVal8);
	directWrite8(BombSpinoutDmg, tempVal8);

	// Blue Shell Speed Modifier (mdmwii)
	tempVal8 = 0x44;
	directWrite8(BlueShellSpeed, tempVal8);
	directWrite8(BlueShellSpeed2, tempVal8);

	// Bomb/Blue Explosion Lag Fix (by MrBean35000vr and CLF78)
	tempVal16 = 0x4800;
	directWrite16(NoFakeBomb, tempVal16);
	directWrite16(NoDmgChange, tempVal16);

	// BRCTR Redirector (by CLF78)
	directWrite8(LapNumberCTR, 'f');
	directWrite8(ItemWindowCTR, 's');
	directWrite8(MapCharaCTR, 't');
	
	// Bullet Bill Exhaust Fire Animation Fix (by stealthsteeler)
	directWriteBranch(BillAnimationFixHook, BillAnimationFix, true);

	// Bullet Bill Speed Modifier (by davidevgen, CLF78 and Ismy)
	directWrite16(BulletBillSpeed, 0x435C);
	directWriteBranch(CannonLandingFixHook, CannonLandingFix, true);
	directWriteBranch(CannonSpeed, CannonSpeedMultiplier, false);
	directWriteBranch(CannonSpeed2, CannonSpeedMultiplier2, true);
	directWrite16(BulletBillPosition, tempVal16);

	// Cannon Fixes (by Ismy)
	directWriteNop(CannonOffroadFix);
	directWriteNop(CannonTCFix);
	
	// Change Camera Perspective after Race (by Ro)
	directWrite32(CameraPersp, 0x38600001);

	// Conditional Out of Bounds (by Riidefi)
	directWriteBranch(ConditionalOutofBoundsHook, ConditionalOutofBounds, true);

	// Crazy Eight (by CLF78)
	// directWrite32(CrazyEightEnableCircling, 0);
	// directWriteArray(ItemAssignerStackFixHook, ItemAssignerStackFix, 0xC);
	// directWriteBranch(ItemAssignerHook2, ItemAssigner2, false);
	// directWriteArray(ItemAssignerHook3, ItemAssigner3, 0x18);
	// directWriteBranch(ItemAssignerHook4, ItemAssigner4, false);
	// directWrite32Offset(ItemAssignerHook4, 0x4081FF68, 0x10);
	// directWriteBranch(ItemAssignerHook5, ItemAssigner5, false);
	// directWriteArray(ItemAssignerStackFix2Hook, ItemAssignerStackFix2, 0xC);
	// directWriteBranch(ItemUsageFixHook, ItemUsageFix, true);
	// directWrite32(ItemUsageFixHook2, 0x807F0004);
	// directWriteBranch(SubtractItem, SubtractItemFixFunc, false);

	// Credits Button (by CLF78)
	directWrite8(CreditsButton, 0x3B);

	// Clear Exhaust Pipe Boost Particle After Damage (by Ro)
	directWriteBranch(ClearExhaustHook, ClearExhaust, true);

	// DC Bug Fix (by Seeky and CLF78)
	directWrite32(DCFix, 0x4800003C);

	// DC Prevention from laggy players (by Kevin)
	// directWriteNop(DCPrevention);

	// Default Drift Type Modifier (by CLF78)
	directWrite32(DefaultDriftType, 0x38600001);

	// Disable Bob-omb Backspam (by stealthsteeler)
	directWrite32(NoBackBombs, 0x48000060);

	// Disable Item Poof (by CLF78 and _tZ)
	directWriteNop(NoItemPoof);
	directWriteBranch(NoItemPoof2Hook, NoItemPoof2, false);
	directWriteBranch(NoItemPoof3Hook, NoItemPoof3, true);

	// Disable Title Demo Movie (by Diamond)
	directWrite16(DisableTitleDemoMovie, 0x4800);

	// Don't Hide Position After Race (by MrBean35000vr)
	directWrite8(NoHidePos, 0);

	// Draggable Blue Shells (by MrBean35000vr)
	directWrite32(BlueShellDrag, 0);

	// Duplicated Item Auto-Trail (by CLF78)
	directWriteBranch(AutoTrailHook, ItemTrail, true);

	// Dynamic Item Sizing (by CLF78)
	directWriteBranch(DynamicSizingHook, DynamicSizing, false);
	directWriteBranch(DynamicSizingHook2, DynamicSizing2, true);
	directWriteBranch(DynamicSizingHook3, DynamicSizing3Helper, false);
	directWriteBranchOffset(DynamicSizingHook3, 0x48, DynamicSizing3, false);
	directWriteBranch(DynamicSizingHook4, DynamicSizing4, true);
	directWriteBranchOffset(DynamicSizingHook4, 0x1C8, DynamicSizing5, false);
	directWriteNopOffset(DynamicSizingHook4, 0x1D4);
	directWriteBranchOffset(DynamicSizingHook4, 0x3E4, DynamicSizing6, false);
	directWriteBranch(DynamicSizingHook7, DynamicSizing7, true);
	directWriteBranch(BombVisualSizeHook, BombVisualSize, true);
	directWriteBranchOffset(BombVisualSizeHook, 0xA4, BombSize, true);
	directWriteBranch(BombVisualSizeHook2, BombVisualSize2, true);
	directWriteBranch(BombSizeHook2, BombSize2, true);
	directWriteBranch(BombSizeHook3, BombSize3, true);
	directWriteBranch(BlueVisualSizeHook, BlueVisualSize, true);
	directWriteBranchOffset(BlueVisualSizeHook, 0xBC, BlueSize, true);
	directWriteBranch(BlueSizeHook2, BlueSize2, true);

	// Emitted Bob-ombs Explode (Idle Fix) (by Ro)
	directWriteBranch(BombIdleFixHook, BombIdleFix, true);

	// Enhanced Race/Battle Pause Menu (by Ro)
	directWrite32(CreateTTPause1, 0x38800019);
	directWrite32(CreateTTPause2, 0x38800019);
	directWrite32(CreateTTPause3, 0x38800019);
	directWrite32(CreateTTPause4, 0x38600019);
	directWrite32(CreateTTPause5, 0x38600019);
	directWriteNop(PreventStoringTTs);
	directWrite32(DisableControllerImage1, 0x48000808);
	directWrite32(DisableControllerImage2, 0x48000040);
	directWriteBranch(VSPauseMenuHook, VSPauseMenu, true);

	// Fast POW (by mdmwii and Ro)
	directWriteArray(NoPOWDelay, POWDelay, 8);

	// Faster Score Increase (by CLF78)
	directWrite8(ScoreSkip, 1);
	directWriteBranch(NoTransition, NoTransitionASM, true);

	// Feather Cut Indicators (by CLF78 and Ismy)
	directWriteBranch(FCIHook1, FeatherCutIndicator, true);
	directWrite32(FCIHook2, 0x80810028);

	// Feather Item (by CLF78 and stebler)
	extern void* FeatherFunc;
	tempVal32 = (u32)&FeatherFunc;
	directWrite32(FeatherUseFunc, tempVal32);
	directWriteBranch(FeatherOnlineFixHook, FeatherOnlineFix, true);
	directWriteArray(FeatherSpeed, FeatherSpeeds, 0xC);
	directWrite8(FeatherFilename, 'c');
	directWriteBranch(FeatherInvisWallHook, FeatherInvisWall, true);

	// Gradually Faster Music (by CLF78 and Ismy)
	directWriteBranch(FastMusicHook, FinalLapCheck, true);
	directWriteBranch(FastMusicHook2, PitchReset, true);
	directWriteBranch(FastMusicHook3, PitchReset2, false);
	
	// FIBs Float in Midair when Backspammed (by Ro and stealthsteeler)
	directWriteBranch(AirFIBsHook, AirFIBs, true);

	// Fix Offroad Ramp Glitch (by vabold)
	directWriteBranch(OffroadRampGlitchFixHook, OffroadRampGlitchFix, true);

	// Fix Online Players Stuck in Halfpipe (by Ro)
	directWriteBranch(HalfPipeFixHook, HalfPipeFix, true);

	// Fix TC Glitch (by CLF78)
	directWriteBranch(TCGlitchFixHook, TCGlitchFix, false);

	// Fix Wallriding (by CLF78)
	directWriteBranch(DisableWallrideHook, DisableWallride, true);

	// GeoHit Patches (by CLF78 and Ismy)
	tempVal8 = 'N';
	directWrite8(GeoHitTableItem, tempVal8);
	directWrite8(GeoHitTableItemObj, tempVal8);
	directWriteBranch(GeoHitTableKartHook, GeoHitTableKartFix, true);
	directWrite8(GeyserCollFix, 9);

	// Green Shell Speed Modifier (by davidevgen)
	directWrite16(GreenShellSpeed, 0x4320);

	// Host Version Check (by CLF78 and Seeky)
	directWriteBranch(GuestSendHook, GuestSend, false);
	directWriteBranch(HostCheckHook, HostCheck, false);
	directWriteBranch(HostCheckHelperHook, HostCheckHelper, true);
	directWrite8(Version, 255);

	// Impervious TC (by CLF78)
	directWrite32(ImperviousTCHook, 0x48000038);

	// Inside Drift Bikes (by Seeky)
	directWriteBranch(KartParamHook, DriftOverride, true);

	// Instant Item Boxes (by Anarion and CLF78)
	directWriteNop(InstantItemBoxes);
	directWrite32(ItemBoxFix, 0x48000064);
	directWrite8(ItemBoxFix2, 0x2);
	directWriteBranch(ItemBoxFix3Hook, ItemBoxFix3, false);

	// Item Textures (by CLF78)
	directWriteBranch(ItemTexturesHook, ItemTextures, false);
	directWriteBranch(ItemRouletteUpdate1Hook, ItemRouletteUpdate1, false);
	directWriteBranch(ItemRouletteUpdate2Hook, ItemRouletteUpdate2, false);
	directWriteBranchOffset(ItemRouletteUpdate2Hook, 0xF4, ItemRouletteUpdate5, false);
	directWriteBranch(ItemRouletteUpdate3Hook, ItemRouletteUpdate3, true);
	directWriteBranchOffset(ItemRouletteUpdate3Hook, 0x64, ItemRouletteUpdate4, true);

	// Lap Counter (by TheLordScruffy and CLF78)
	directWriteBranch(ColorFixHook, ColorFix, false);
	directWriteBranch(PositionFixHook, PositionFix, true);

	// Map Highlighter (by CLF78)
	//directWriteBranch(MapHighlighterHook, MapHighlighter, true);

	// Max Item Limit Modifier (by CLF78)
	directWriteBranch(ItemLimitSetup, ItemLimitMod, true);

	// Mega Flips Cars (by JoshuaMK)
	directWrite8(MegaFlip, 1);

	// Mega Mushroom Size Multiplier (by CLF78 and TheLordScruffy)
	directWriteBranch(MegaSizeHook, MegaSizeMod, true);
	directWriteBranch(FOVChange, FOVFix, true);

	// Mega Thundercloud (by _tZ)
	directWriteBranch(MegaTCHook, MegaTC, false);
	directWriteBranch(MegaTCHook2, MegaTC2, false);

	// Message Patches (by CLF78 and Kevin)
	directWriteBranch(MSGPatchHook, MSGPatch, true);
	directWriteBranch(MSGPatchHook2, MSGPatch2, true);
	directWriteBranch(MSGPatchHook3, MSGPatch3, true);
	directWrite8(TitleCTR, 'L');
	directWrite8Offset(TitleCTR, 0x55, 'L');

	// MK7 Shock Squishing (by CLF78)
	directWriteBranch(SquishCheckHook, SquishCheck, true);
	directWriteBranchOffset(SquishCheckHook, 0x6E0, SquishDmg, true);
	directWriteBranchOffset(SquishCheckHook, 0x870, SquishDmg2, true);
	directWrite8(SquishFunc, 0);							// Remove stun
	directWrite32Offset(SquishFunc, 0x41, 0x48000024);	  // Keep item
	directWrite32Offset(SquishFunc, 0x7D, 0x48000018);	  // Remove respawn

	// Motion-Sensor Bombs (by Hamster35000vr)
	tempVal16 = 0x7FFF;
	directWrite16(BombTimer, tempVal16);
	directWrite16(BombTimer2, tempVal16);

	// Newbie Helper (by Seeky, CLF78 and davidevgen)
	// Instant Respawn (by Seeky, CLF78 and davidevgen)
	directWriteBranch(RespawnHelperHook, RespawnHelper, false);
	directWriteBranch(RespawnHelperHook2, RespawnHelper2, false);
	directWriteBranch(RespawnHelperHook3, RespawnHelper3, false);

	// Instant Draft (by stealthsteeler, Ismy and Volderbeek)
	directWriteBranch(InstaDraftHook, InstaDraft, false);
	
	// No Bullet Bill Cancel When Touching Bottom of Rainbow Road (by Ro)
	directWriteNop(NoBillCancelRR);
	
	// No Bullet Bill Icon (by Anarion)
	directWriteBlr(NoBBIcon);

	// No Disconnect (by BullyWiiPlaza)
	directWrite32(NoDC1, 0x38000000);
	// directWrite32(NoDC2, 0x38000000); Causes the end of race timer to not countdown
	directWrite32(NoDC3, 0x38000000);
	directWrite32(NoDC4, 0x38000000);
	directWrite32(NoDC5, 0x38000000);

	// No Invincibility Frames (by CLF78)
	directWriteBranch(NoInvFramesHook, NoInvFrames, true);
	directWrite8(NoRespawnInv, 0x20);
	directWrite8(StarInBullet, 0);
	directWrite8(ShroomInBullet, 0);
	directWriteNop(StarWhenHit);
	directWriteNop(ShroomWhenHit);

	// No Multi Channel Track Music (by CLF78)
	directWriteBranch(NoMultiChannelHook, NoMultiChannel, false);
	directWriteBranch(NoMultiChannelHook2, NoMultiChannel2, true);

	// OoB Bill Bike Fix (by stealthsteeler and Ismy)
	extern void* OoBOGFunction;
	tempVal32 = (u32)&OoBOGFunction;
	directWrite32(OoBLocalPlayerVT, tempVal32);
	directWrite32(OoBLocalCPUVT, tempVal32);
	directWrite32(OoBOnlinePlayerVT, tempVal32);

	// Patch.szs (by CLF78)
	directWrite8(SZSCount, 4);
	directWriteBranch(PatchSZSHook, PatchSZS, false);
	#ifdef REGION_K
	directWrite8(CommonFix, 'j');
	#endif

	// Pause Menu Fix (by CLF78)
	directWriteBranch(PauseMenuScreenHook, PauseMenuScreen, true);
	directWriteBranch(PauseMenuScreenHook2, PauseMenuScreen, true);

	// POW Yourself in 1st (by CLF78)
	directWriteBranch(POWSelfHook, POWSelf, false);

	// Prediction Removal (by stebler)
	directWrite32(PredictionRemoval, 0x3F800000);

	// Prevent Shock/POW Drop (by CLF78)
	directWriteBranch(DropFunc, NoDrop, true);

	// Red Shell Target Modifier (by CLF78)
	directWrite8(TargetWhileRespawn, 0x20);
	directWrite8(TargetWhileHit, 0x18);
	directWriteArray(TargetPositionHook, TargetPosition, 0x10);

	// Remove Mushroom Bug (by Vega and CLF78)
	directWrite8(RemoveShroomBug, 0);
	directWriteBranch(RemoveFakeShroom, NoFakeShroom, true);

	// Shells Never Break (by CLF78)
	directWrite16(ShellHitCount, 0x4800);
	directWrite16(ShellHitCount2, 0x4800);

	// Show Times After Race (by Melg and CLF78)
	directWriteNop(ShowTimesVS);
	directWriteBranch(ShowTimesWW, TimesFunc, true);
	directWriteBranch(TimePrintHook, TimePrint, true);
	directWriteNop(SpeedoTextParseNop);
	directWriteBranch(SpeedoTextParse, SpeedoTextParseASM, true);

	// Show Voting Timer (by CLF78)
	directWriteNop(TimerShow);

	// Super Miniturbo Multiplier (by CLF78)
	directWrite16(SMTMultiplier, 0x40A0);
	directWrite16(SMTMinimum, 0x87);

	// Starting Lap Modifier (by CLF78 and Ismy)
	tempVal8 = 50;
	directWrite8(LapCount1, tempVal8);
	directWrite8(LapCount2, tempVal8);
	directWrite8(LapCount3, tempVal8);
	directWrite8(LapCount4, tempVal8);
	directWrite8(LapCount5, tempVal8);
	directWriteBranchOffset(LapCount3, 0x49, FinishTimes, true);
	directWrite16(LakituBoardHook, 0x4800);
	directWriteBranchOffset(LakituBoardHook, 0x18, LakituBoard, true);

	// Track Identifier + Patch Loader (by CLF78)
	directWriteBranch(TrackIdentifierHook, TrackIdentifier, false);
	directWriteBranch(TrackIdentifierDeleteHook, TrackIdentifierDelete, false);
	directWriteBranch(ITPHHook, AltKMP1, true);
	directWriteBranch(ITPTHook, AltKMP1, true);
	directWriteBranch(CKPTHook, AltKMP1, true);
	directWriteBranch(AREAHook, AltKMP1, true);
	directWriteBranch(JGPTHook, AltKMP1, true);
	directWriteBranch(CKPHHook, AltKMP2, true);

	// Trickable Cannons (by Ro)
	directWriteBranch(TrickableCannonHook, TrickableCannon, true);

	// Time Limit Modifier (by MrBean35000vr)
	directWriteArray(TimeLimit, NewTimeLimit, 8);

	// Ultra UnCut (by MrBean35000vr)
	directWriteBranch(CKPTCheck, UltraUncut, false);

	// Ultimate Item Randomizer (by CLF78 and Ismy)
	directWriteBranch(SharedItemHook, UltimateRandom, true);
	directWriteBranch(ItemAmountHook, ItemAmount, false);
	directWriteBranch(SpecialItemHook, SpecialRandom, true);
	directWriteBranch(WoodProb, WoodboxPatch, true);

	// Un-Beancorner (by JoshuaMK)
	directWriteBranch(UnBeanCornerHook, UnBeanCorner, true);

	// Use Items in Cannon (by Ro)
	directWriteNop(ItemsCannon1);
	directWriteNop(ItemsCannon2);
	directWriteNop(ItemsCannon3);

	// Woodbox Respawn Modifier (by Atlas)
	directWrite32(WoodRespawn, 150);

	// Cycle Fix - Coconut Mall (by CLF78 and Ismy)
	directWriteBranch(EscalatorFixHook, EscalatorFix, true);
	directWriteBranch(PiantaFixHook, PiantaFix, true);

	// Cycle Fix - Dry Dry Ruins (by CLF78 and Ismy)
	directWriteBranch(PillarFixHook, PillarFix, true);
	directWriteBranch(SandpitFixHook, SandpitFix, true);
	directWrite8(SandpitFix2, 0x90);
	directWrite8(SandpitFix3, 0x80);

	// Cycle Fix - Ghost Valley 2 (by CLF78 and Ismy)
	directWrite16(GV2Fix, 0x1E0);

	// Cycle Fix - Grumble Volcano (by CLF78 and Ismy)
	directWrite16(RockFix, 0x3C0);
	directWriteBranch(RockFix2Hook, RockFix2, true);
	directWriteBranch(GeyserFixHook, GeyserFix, true);

	// Cycle Fix - Toad's Factory (by CLF78 and Ismy)
	directWriteBranch(ConveyorFixHook, ConveyorFix, true);

	// Game Modes - Generic (by CLF78, Ismy, Seeky, TheLordScruffy and Nameless)
	extern void DriftMenuBackFix2();
	directWriteBranch(SceneSwapHook, GameModeSelector, true);
	directWriteBranch(HostFlagsHook, HostFlags, false);
	directWriteBranch(GuestFlagsHook, GuestFlags, false);
	directWriteArray(BattleFixHook, BattleFix, 8);
	directWrite32(BattleFixHook2, 0x48000044);
	directWriteBranch(FlagResetHook, FlagReset, false);
	directWriteBranch(FlagResetHook2, FlagReset, false);
	directWriteBranch(FlagResetHook3, FlagReset, false);
	directWriteBranch(FlagResetHook4, FlagReset, false);
	directWriteBranch(FlagResetHook5, FlagReset, false);
	directWriteBranch(AlwaysWinVoteHook, VotePatch, true);
	directWriteBranch(TimerManagerHook, GameModeMaster, false);
	directWriteBranch(VehicleRestrictionHook, VehicleRestriction, true);
	directWrite8(MessageButtons, 0x6E);
	directWriteArray(MessageButtons2Hook, MessageButtons2, 8);
	directWriteBranch(MessageButtons3Hook, MessageButtons3, false);
	directWriteBranch(RandomComboPickerHook, RandomComboPicker, false);
	directWriteBranch(DriftMenuBackFixHook, DriftMenuBackFix, true);
	directWrite32(DriftMenuBackFix2Hook, (u32)&DriftMenuBackFix2);

	// Offline Race Count Modifier (by JoshuaMK and CLF78)
	directWrite8(RaceCountFix1, 15);
	directWrite32(RaceCountFix2, 0x381F0001);
	directWriteNop(RaceCountFix3);
	directWrite16(RaceCountFix4, 0x4800);
	directWriteBranch(RaceCountFix5, RaceCountFix, true);

	// Game Mode - Ramp Up (by CLF78, Ismy and stebler)
	directWriteBranch(RampUpHook, RampUp, false);
	directWriteBranch(RampUpSpeedFixHook, RampUpSpeedFix, false);
	directWriteBranch(DriftSpeedHook, DriftSpeed1, true);
	directWriteBranch(DriftSpeedHook2, DriftSpeed2, true);
	directWriteBranch(DriftSpeedHook3, DriftSpeed3, true);
	directWriteBranch(DriftSpeedHook4, DriftSpeed4, false);
	directWriteBranch(DriftSpeedHook5, DriftSpeed5, false);
	directWriteBranch(BoostAccelHook, BoostAccel, false);
	directWriteBranchOffset(BoostAccelHook, 0x70, BoostAccel, false);
	directWriteBranch(BrakeDriftClassicHook, BrakeDriftClassic, true);
	directWriteBranch(BrakeDriftGCNHook, BrakeDriftGCN, true);
	directWriteBranch(BrakeDriftNunchuckHook, BrakeDriftNunchuck, true);
	directWriteBranch(BrakeDriftWheelHook, BrakeDriftWheel, true);
	directWriteBranch(BrakeDriftMainHook, BrakeDriftMain, false);
	directWriteBranch(BrakeDriftSoundHook, BrakeDriftSound, false);
	directWriteBranch(BrakeDriftEffBikesHook, BrakeDriftEffBikes, false);
	directWriteBranch(BrakeDriftEffKartsHook, BrakeDriftEffKarts, false);
	directWriteBranch(FastFallingHook, FastFalling, false);
	directWriteBranch(FastFallingHook2, FastFalling2, false);
	directWriteBranch(RedSpeedHook, RedSpeed, true);

	// Game Mode - Teams (by CLF78, Ismy and Chippy)
	directWrite32(NoItemGlow, 0x38000000);
	tempVal16 = 0x4800;
	directWrite16(NoTeamInvincibility, tempVal16);
	directWrite16(NoTeamInvincibility2, tempVal16);
	directWrite16(NoTeamInvincibility3, tempVal16);
	directWriteNop(NoTeamInvincibility4);
	directWrite32(NoTeamInvincibility5, 0x7F600051);
	directWrite16(NoTeamInvincibility6, tempVal16);

	//////////////////
	// Online Stuff //
	//////////////////

	// Anti Lag/Late Start Online (by davidevgen, MrBean35000vr and Ro)
	directWriteBranch(AntiLagStartHook, AntiLagStart, true);

	// Force CC (by Star)
	directWriteBranch(ForceCCHook, ForceCC, true);

	// Friend Room Race Count Modifier (by MrBean35000vr)
	directWrite8(FroomRaceCount, 0);
	directWrite8(FroomRaceCount2, 0);

	// Remove Worldwide Button (by Chadderz)
	directWrite8(NoWWButton, 5);
	directWriteNop(NoWWButton2);
	directWriteNop(NoWWButton3);
	directWrite32(NoWWButton4, 0x48000010);
	directWrite8(NoWWButton5, 1);
	tempVal16 = 0x484;
	directWrite16(NoWWButton6, tempVal16);
	directWrite16(NoWWButton7, tempVal16);
	tempVal16 = 0x10D7;
	directWrite16(NoWWButton8, tempVal16);
	directWrite16(NoWWButton9, tempVal16);

	////////////
	// Extras //
	////////////

	// Automatic BRSAR Patching (by Elias)
	directWriteBranch(AutoBRSARHook, AutoBRSAR, true);

	// Change Characters Between Races (by MrBean35000vr)
	directWriteBranch(ChangeCharsHook, ChangeCharsSetup, false);
	directWriteBranch(ChangeCharsHook2, ChangeCharsASM, true);
	directWriteBranch(ChangeCharsHook3, ChangeCharsASM2, true);
	directWriteArray(VtablePtr, ChangeCharsData, 0x14);

	// Disable TF Music Reset (by _tZ)
	directWrite32(NoTFMusicReset, 0x48000010);

	// Don't Lose VR When Disconnecting (by BullyWiiPlaza)
	directWriteNop(NoVRLoss);

	// Hybrid Drift (by Ismy and CLF78)
	directWriteNop(HybridDrift1);
	directWriteBranchOffset(HybridDrift1, 0x48, HybridDrift2, true);
	directWriteBranch(HybridDrift3Hook, HybridDrift3, true);
	directWriteBranchOffset(HybridDrift3Hook, 0x70, HybridDrift4, true);
	directWriteBranch(HybridDrift4Hook, HybridDrift4, false);
	directWriteBranch(HybridDrift5Hook, HybridDrift5, true);
	directWriteBranchOffset(HybridDrift5Hook, 0x540, HybridDrift5, true);
	directWriteBranch(HybridDrift6Hook, HybridDrift6, true);
	directWrite8(HybridDrift7, 0x20);
	directWrite32(HybridDrift8, 0x38600000);
	directWrite16(WiiWheelFix, 0);
	directWrite16(WiiWheelFix2, 0x4800);

	// Instant DC (by CLF78)
	directWriteBranch(InstantDCHook, InstantDC, true);

	// License Unlocker (by _tZ)
	directWrite32(LicenseUnlocker, 0x38600001);

	// Points Modifier (by CLF78)
	directWriteBranch(PointsModifierHook, PointsModifier, true);

	// Silent Controller Changing (by BullyWiiPlaza)
	directWriteNop(NoControllerDC);

	// VS Menu Skip (by TheLordScruffy and CLF78)
	directWriteBranch(VSMenuSkipHook, VSMenuSkip, true);
	directWriteBranch(VSMenuSkipHook2, VSMenuSkip2, true);
	directWriteNop(VSMenuSkip3);
	directWriteBranch(VSMenuReturnHook, VSMenuReturn, false);
	tempVal8 = 0x72;
	directWrite8(VSMenuSkip4, tempVal8);
	directWrite8(VSMenuSkipMulti, tempVal8);
	directWriteBranch(VSMenuReturnHook2, VSMenuReturn2, true);
	directWriteBlr(NoGhostLoading);

	////////////////////
	// Custom Options //
	////////////////////

	// Faster Menu Navigation (by east)
	if (FasterMenu == 1) {
		tempVal32 = 0;
		directWrite32(FasterMenuHook, tempVal32);
		directWrite32(FasterMenuHook2, tempVal32);
		directWrite32(FasterMenuHook3, 0x38000000);
	}

	// Mii Heads on Minimap (by JoshuaMK and CLF78)
	if (MiiHeads == 1) {
		directWriteBranch(MiiHeadsHook, MiiHeadsPatch, true);
	}

	// No Music (by CosmoCortney)
	if (NoMusic != 1 && NoMusic != 2) {
		directWrite32(NoMusicHook, 0x38600000);
	}

	// No Character Voices (by Melg)
	if (NoCharVoice != 1) {
		directWrite32(NoCharVoiceHook, 0x38600001);
	}

	// Force Battle Glitch (by XeR)
	if (BtGlitch == 1) {
		directWrite32(TagDistance, 0x47927C00);
	}

	// Show Time Difference (by Melg and CLF78)
	if (TimeDiff == 1 || TimeDiff == 2) {
		directWriteBranch(TimeDiffPatchHook, TimeDiffPatch, true);
		directWrite8Offset(TimeDiffPatchHook, 0xB, 1);
		directWriteBranchOffset(TimeDiffPatchHook, 0x4C, TimeDiffPatch2, false);
	}

	// Applies the two options above (by CLF78)
	directWriteBranch(TimeDiffApplyHook, TimeDiffApply, true);

	// Speedometer (by stebler and CLF78)
	if (Speedometer == 1) {
		directWriteBranch(SpeedoNoPauseHook, SpeedoNoPause, true);
	}

	// Transformation Music (by Anarion)
	if (TransfMusic != 1) {
		directWrite32(TransfMusicHook, 0x38000003);
	}

	// 30 FPS (by CLF78)
	if (ThirtyFPS == 1) {
		directWrite32(ThirtyFPSHook4, 0x3BE00002);
		directWriteNop(ThirtyFPSHook5);
		directWrite8(ThirtyFPSHook6, 2);
	}

	// KCP Map (by stealthsteeler)
	if (KCPMap == 1) {
		directWriteBranch(KCPMapHook, KCPMapInject, false);
		directWriteBranch(KCPMapHook1, KCPMapInject1, false);
	}
	
	// No Lightning Flash (by Ro)
	if (LightFlash != 1) {
		directWrite32(NoLightningFlash, 0x4E800020);
	}
	
	// Remove Bloom and Depth of Field (by Gearworks)
	if (RemoveBloom != 1) {
		directWriteBranch(NoBloomHook, NoBloom, true);
	}
	
	// Camera Distance Modifier (by davidevgen)
	u16 FOV;
	switch(FOVSetting) {
		case 1:
			FOV = 0x3EE0;
			break;
		case 2:
			FOV = 0x3EC0;
			break;
		case 3:
			FOV = 0x3F20;
			break;
		case 4:
			FOV = 0x3F40;
			break;
		default:
			FOV = 0x3F00;
	}
	directWrite16(CustomFOV, FOV);

	sync();
	isync();
}
