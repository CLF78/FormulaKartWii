#include "common.h"

// This function loads all the codes that FKW uses after StaticR has loaded
void loadCodes() {

    // These values will be used as filler throughout the function
    u8 tempVal8;
    u16 tempVal16;
    u32 tempVal32;

    // Exception Handler (by Star)
    directWrite32(ShowExceptions, 0);

    // WiiLink Code Patches (ported by Palapeli)
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

    // Wiimmfi Login Region Changer (by Atlas)
    directWriteString(LoginRegion, "120045");

    // VS Matchmaking Region Patch (by Leseratte)
    directWrite32(VSRegion, 0x38A04E4D);
    directWrite32(VSRegion2, 0x38E04E4D);
    directWrite32(VSRegion3, 0x38E04E4D);
    directWrite32(VSRegion4, 0x3880004D);

    // 30 Seconds Time Limit Modifier (by CLF78)
    directWrite16(ThirtySecs, 0x2A30);

    // All Items Can Land (by MrBean and CLF78)
    directWriteNop(AICLUnk1);
    directWrite32(AICLUnk2, 0x38600000);
    directWrite32(NoItemLandingPoof, 0x39800001);
    extern void* AllItemsCanLand;
    tempVal32 = (u32)&AllItemsCanLand;
    directWrite32(ItemLandMega, tempVal32);
    directWrite32(ItemLandGolden, tempVal32+8);
    directWrite32(ItemLandFeather, tempVal32+16);
    directWrite32(ItemLandBill, tempVal32+24);

    // Blue Flag + BRCTR redirect (by stealthsteeler)
    directWrite8(BalloonCTR, 'e');

    // Banana Spinout Modifier (Skullface)
    directWrite32(BananaDamage, 0x38600001);

    // Blue Shell and Bomb Spinout Modifier (CLF78)
    tempVal8 = 1;
    directWrite8(BlueSpinoutDmg, tempVal8);
    directWrite8(BombSpinoutDmg, tempVal8);

    // Blue Shell Speed Modifier (mdmwii)
    tempVal8 = 0x44;
    directWrite8(BlueShellSpeed, tempVal8);
    directWrite8(BlueShellSpeed2, tempVal8);

    // Bomb/Blue Explosion Lag Fix (by MrBean and CLF78)
    tempVal16 = 0x4800;
    directWrite16(NoFakeBomb, tempVal16);
    directWrite16(NoDmgChange, tempVal16);

    // BRCTR Redirector (by CLF78, chase_icon by 13w02a)
    directWrite8(LapNumberCTR, 'f');
    directWrite8(ItemWindowCTR, 's');
    directWrite8(ChaseIconCTR, 'f');
    //directWrite8(MapCharaCTR, 'f');

    // Bullet Bill Exhaust Fire Animation Fix (by stealthsteeler)
	directWriteBranch(BillAnimationFixHook, BillAnimationFix, true);

    // Bullet Bill Speed Modifier (by davidevgen, CLF78 and Ismy)
    directWrite16(BulletBillSpeed, 0x435C);
    directWriteBranch(CannonLandingFixHook, CannonLandingFix, true);
    directWriteBranch(CannonSpeed, CannonSpeedMultiplier, false);
    directWriteBranch(CannonSpeed2, CannonSpeedMultiplier2, true);
    directWrite16(BulletBillPosition, tempVal16);

    // Chase Icon Fix (by Marioiscool246)
    directWriteBranch(ChaseIconHook, ChaseIconFix, false);

    // Cannon Fixes (by Ismy)
    directWriteNop(CannonOffroadFix);
    directWriteNop(CannonTCFix);

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

    // Custom Region Line Colors (by me)
    directWriteBranch(LocalIDHook, LocalRegionID, false);
    directWriteNopOffset(LocalIDHook, 0x1C);
    directWriteBranch(USERIDHook, USERRegionID, false);
    directWriteBranch(LineColorHook, LineColors, true);

    // Clear Exhaust Pipe Boost Particle After Damage (by Ro)
    directWriteBranch(ClearExhaustHook, ClearExhaust, true);

    // DC Bug Fix (by Seeky and CLF78)
    directWrite32(DCFix, 0x4800003C);

    // DC Prevention from laggy players (by Kevin)
    // directWriteNop(DCPrevention);

    // Default Drift Type Modifier (by CLF78)
    directWrite32(DefaultDriftType, 0x38600001);

    // Disable Item Poof (by CLF78 and tZ)
    directWriteNop(NoItemPoof);
    directWriteBranch(NoItemPoof2Hook, NoItemPoof2, false);
    directWriteBranch(NoItemPoof3Hook, NoItemPoof3, true);

    // Don't Hide Position After Race (by MrBean)
    directWrite8(NoHidePos, 0);

    // Draggable Blue Shells (by MrBean)
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

    // Fix Offroad Ramp Glitch (by vabold)
    directWriteBranch(OffroadRampGlitchFixHook, OffroadRampGlitchFix, true);

    // Fix Online Players Stuck in Halfpipe (by Ro)
    directWriteBranch(HalfPipeFixHook, HalfPipeFix, true);

    // Fix TC Glitch (by CLF78)
    directWriteBranch(TCGlitchFixHook, TCGlitchFix, false);

    // Fix Wallriding (by CLF78)
    // directWriteBranch(DisableWallrideHook, DisableWallride, true);

    // GeoHit Patches (by CLF78 and Ismy)
    tempVal8 = 'N';
    directWrite8(GeoHitTableItem, tempVal8);
    directWrite8(GeoHitTableItemObj, tempVal8);
    directWriteBranch(GeoHitTableKartHook, GeoHitTableKartFix, true);
    directWrite8(GeyserCollFix, 9);

    // Green Shell Speed Modifier (by davidevgen)
    directWrite16(GreenShellSpeed, 0x4320);

    // Host Version Check (by CLF78 & Seeky)
    directWriteBranch(GuestSendHook, GuestSend, false);
    directWriteBranch(HostCheckHook, HostCheck, false);
    directWriteBranch(HostCheckHelperHook, HostCheckHelper, true);
    directWrite8(Version, 0xc0 | 12);

    // Impervious TC (by CLF78)
    directWrite32(ImperviousTCHook, 0x48000038);

    // Inside Drift Bikes (by Seeky)
    //directWriteBranch(KartParamHook, DriftOverride, true);

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

    // Kart Status Stacker (by Ro)
    directWriteBranch(StarStackHook, StarStacker1, true);
    directWriteBranchOffset(StarStackHook, 0xC, StarStacker2, true);
    directWrite32Offset(StarStackHook, 0x18, 0xA883018A);
    directWrite32(StarStack2, 0xA8DC0278);
    directWrite32Offset(StarStack2, 0x1C, 0xA8DC0278);
    directWriteBranch(MegaStackHook, MegaStacker, true);
    directWriteBranch(BulletStackHook, BulletStacker1, true);
    directWriteBranchOffset(BulletStackHook, 0x8D8, BulletStacker2, true);
    directWriteBranchOffset(BulletStackHook, 0x152C, BulletStacker3, true);
    //directWriteBranch(ShockStackHook1, ShockStacker1, true);
    //directWriteBranch(ShockStackHook2, ShockStacker2, true); // Doesn't work online as of now
    directWriteBranch(ShroomStackHook, ShroomStacker, true);
    directWrite32Offset(ShroomStackHook, 0xEC, 0xA87E0110);
   
    // Lap Counter (by TheLordScruffy and CLF78)
    directWriteBranch(ColorFixHook, ColorFix, false);
    directWriteBranch(PositionFixHook1, PositionFix1, true);
    directWriteBranch(PositionFixHook2, PositionFix2, true);


    // Map Highlighter (by CLF78)
    //directWriteBranch(MapHighlighterHook, MapHighlighter, true);

    // Max Item Limit Modifier (by CLF78)
    directWriteBranch(ItemLimitSetup, ItemLimitMod, true);

    // Mega Flips Cars (by JoshuaMK)
    directWrite8(MegaFlip, 1);

    // Mega Mushroom Size Multiplier (by CLF78 and TheLordScruffy)
    directWriteBranch(MegaSizeHook, MegaSizeMod, true);
    directWriteBranch(FOVChange, FOVFix, true);

    // Mega Thundercloud (by tZ)
    directWriteBranch(MegaTCHook, MegaTC, false);
    directWriteBranch(MegaTCHook2, MegaTC2, false);
    directWrite8(TCFileName1, 'f');
    directWrite8Offset(TCFileName1, 0x8, 'f');
    directWrite8(TCFileName2, 'f');

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
    directWrite8(SquishFunc, 0);                            // Remove stun
    directWrite32Offset(SquishFunc, 0x41, 0x48000024);      // Keep item
    directWrite32Offset(SquishFunc, 0x7D, 0x48000018);      // Remove respawn

    // Motion-Sensor Bombs (by Hamster)
    tempVal16 = 0x7FFF;
    directWrite16(BombTimer, tempVal16);
    directWrite16(BombTimer2, tempVal16);

    // Newbie Helper (by Seeky, CLF78 and davidevgen)
    // Instant Respawn (by Seeky, CLF78 and davidevgen)
    // Instant Draft (by stealthsteeler, Ismy and Volderbeek)
    directWriteBranch(RespawnHelperHook, RespawnHelper, false);
    directWriteBranch(RespawnHelperHook2, RespawnHelper2, false);
    directWriteBranch(RespawnHelperHook3, RespawnHelper3, false);
    directWriteBranch(InstaDraftHook, InstaDraft, false);
	directWriteBranch(StarHelperHook1, StarHelper1, false);
    directWriteBranch(StarHelperHook2, StarHelper2, false);
    directWriteNopOffset(StarHelperHook2, 0x18);
	directWriteBranch(MegaHelperHook, MegaHelper, false);

	// No Bullet Bill Cancel When Touching Bottom of Rainbow Road (by Ro)
	directWriteNop(NoBillCancelRR)

    // No Bullet Bill Icon (by Anarion)
    directWriteBlr(NoBBIcon);

    // No Disconnect (by Bully)
    directWrite32(NoDC1, 0x38000000);
    //directWrite32(NoDC2, 0x38000000); Causes the end of race timer to not countdown
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

    // Patch.szs (by CLF78)
    directWrite8(SZSCount, 3);
    directWrite8Offset(SZSCount, 0x80, 4);
    directWriteBranch(PatchSZSHook, PatchSZS, false);
    directWriteBranchOffset(PatchSZSHook, 0xC4, PatchSZS2, false);
    #ifdef REGION_K
    directWrite8(CommonFix, 'j');
    #endif

    // Patch Effects (by Melg, 13w02a)
    directWriteBranch(EffectCreate, EffectCreateHook, true);
    directWriteBranch(EffectDestroy, EffectDestroyHook, true);
    directWriteBranch(EffectLoad, EffectLoadHook, true);
    directWriteString(UMTStrings, "rk_driftSpark3L_Spark00");
    directWriteStringOffset(UMTStrings, 0x18, "rk_driftSpark3L_Spark01");
    directWriteStringOffset(UMTStrings, 0x30, "rk_driftSpark3R_Spark00");
    directWriteStringOffset(UMTStrings, 0x48, "rk_driftSpark3R_Spark01");
    directWriteStringOffset(UMTStrings, 0x60, "rk_purpleTurbo");
    directWriteStringOffset(UMTStrings, 0x70, "rk_driftSpark2L_Spark00");
    directWriteStringOffset(UMTStrings, 0x88, "rk_driftSpark2L_Spark01");
    directWriteStringOffset(UMTStrings, 0xA0, "rk_driftSpark2R_Spark00");
    directWriteStringOffset(UMTStrings, 0xB8, "rk_driftSpark2R_Spark01");
    directWrite32Offset(UMTEffectPointer, 0x4, 0x80001540);
    directWrite32Offset(UMTEffectPointer, 0x8, 0x80001558);
    directWrite32Offset(UMTEffectPointer, 0xC, 0x80001570);
    directWrite32Offset(UMTEffectPointer, 0x10, 0x80001588);
    directWrite32Offset(UMTEffectPointer, 0x14, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x18, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x1C, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x20, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x2C, 0x80001528);
    directWrite32Offset(UMTEffectPointer, 0x110, 0x800015B0);
    directWrite32Offset(UMTEffectPointer, 0x114, 0x800015C8);
    directWrite32Offset(UMTEffectPointer, 0x118, 0x800015E0);
    directWrite32Offset(UMTEffectPointer, 0x11C, 0x800015F8);
    directWrite32Offset(UMTEffectPointer, 0x120, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x124, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x128, 0x800015A0);
    directWrite32Offset(UMTEffectPointer, 0x12C, 0x800015A0);
    directWriteBranchOffset(UMTEffectPointer, 0x28, EffectBCTRLfuckoff, false);

    // Pause Menu Fix (by CLF78)
    directWriteBranch(PauseMenuScreenHook, PauseMenuScreen, true);
    directWriteBranch(PauseMenuScreenHook2, PauseMenuScreen, true);

    // POW Yourself in 1st (by CLF78)
    directWriteBranch(POWSelfHook, POWSelf, false);

    // Prediction Removal (by stebler)
    directWrite32(PredictionRemoval, 0x3F800000);

    // Prevent Shock/POW Drop (by CLF78)
    directWriteBranch(DropFunc, NoDrop, true);

    // Random FIB Colors (by 13w02a)
    directWrite8(FIBString, 'c');
    directWrite8Offset(FIBString, 0x2D, 'c');
    directWriteBranch(FIBFunc, FIBColors, false)

    // Red Shell Curve Time Desync Fix (by Marioiscool246)
    directWriteBranch(RedCurveHook, RedCurveTime, true);

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

    // Speed Modifier (by MrBean35000vr, Melg)
    directWriteBranch(SpeedMod1, SpeedModHook1, false);
    directWriteBranch(SpeedMod2, SpeedModHook2, true);
    directWriteBranch(SpeedMod3, SpeedModHook3, true);
    directWriteBranch(SpeedMod4, SpeedModHook4, false);
    directWriteBranch(SpeedMod5, SpeedModHook5, true);
    directWriteBranch(SpeedMod6, SpeedModHook6, true);
    directWriteBranch(SpeedMod7, SpeedModHook7, true);
    directWriteBranch(SpeedMod8, SpeedModHook8, true);
    directWriteBranch(SpeedMod9, SpeedModHook9, true);
    directWriteBranch(SpeedMod10, SpeedModHook10, true);
    directWriteBranch(SpeedMod11, SpeedModHook11, true);
    directWriteBranch(SpeedMod12, SpeedModHook12, true);
    directWriteBranch(SpeedBuff, SpeedBuffHook, true);

    // Super Miniturbo Multiplier (by CLF78)
    //directWrite16(SMTMultiplier, 0x40A0);
    //directWrite16(SMTMinimum, 0x87);

    // Super Miniturbos on Outward Bikes (by _tZ, 13w02a)
    directWriteBranch(OutwardSMT, SMTCreateSparks, false);
    directWriteBranchOffset(OutwardSMT, 0xA4, SMTCreateSparks, false);
    directWriteBranchOffset(OutwardSMT, 0x250, SMTDestroySparks, false);
    directWriteBranchOffset(OutwardSMT, 0x29C, SMTDestroySparks, false);
    directWriteBranch(BikeMTFunc, KartMTFunc, false);

    // Starting Lap Modifier (by CLF78 and Ismy, edited by 13w02a)
    tempVal8 = 69;
    directWriteBranch(LapCount1, LapHook1, true);
    directWriteBranch(LapCount2, LapHook2, false);
    directWriteBranch(LapCount3, LapHook1, true);
    directWriteBranch(LapCount4, LapHook3, true);
    directWriteBranch(LapCount5, LapHook4, true);
    directWriteBranchOffset(LapCount3, 0x4C, FinishTimes, true);
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

    // Time Limit Modifier (by MrBean)
    directWriteArray(TimeLimit, NewTimeLimit, 8);

    // Ultra MiniTurbos (by Melg)
    directWrite8Offset(CreateUMT, 0x3, 0x4);
    directWrite8Offset(CreateUMT, 0xD7, 0x1);
    directWrite32Offset(CreateUMT, 0xDC, 0x418200A4);
    directWrite32Offset(CreateUMT, 0x158, 0x48000028);
    directWriteBranchOffset(CreateUMT, 0x180, CreateUMTHook, false);
    directWriteBranch(BuffUMT, BuffUMTHook, true);
    directWrite32Offset(BuffUMT, 0x4, 0x7C601B78);
    directWrite16Offset(BuffUMT, 0x10, 0x4180);
    directWriteBranch(UMTMultiplier, UMTMultHook, false);
    directWriteBranch(DriftStateCheck, DriftStateHook, true)
    directWriteBranch(KartDriftEffectHandler, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x20, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x43C, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x45C, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x88C, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x8E8, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0xB84, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0xBA4, UMTDestroySparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x86C, UMTCreateSparks, true);
    directWriteBranchOffset(KartDriftEffectHandler, 0x8C8, UMTCreateSparks, true);
    directWriteBranch(PatchBoost, UMTBoostSetup, true);
    directWriteNop(BoostMatrix);
    directWriteBranchOffset(BoostMatrix, 0x50, UMTMatrix, true);
    directWriteNopOffset(BoostMatrix, 0x64);
    directWriteBranchOffset(BoostMatrix, 0x104, UMTFade, true);
    directWrite16(UMTSound, 0x40A0);
    directWriteBranchOffset(UMTSound, 0x40, UMTSoundHook, true);

    // Ultra UnCut (by MrBean)
    directWriteBranch(CKPTCheck, UltraUncut, false);

    // Ultimate Item Randomizer (by CLF78 and Ismy)
    directWriteBranch(SharedItemHook, UltimateRandom, true);
    directWriteBranch(ItemAmountHook, ItemAmount, false);
    directWriteBranch(SpecialItemHook, SpecialRandom, true);
    directWriteBranch(WoodProb, WoodboxPatch, true);

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
    directWrite16(GV2Fix, 0x3C0);

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

    // Show Mega Damage For Online Players (by Gearworks)
    directWrite8(ShowOnlinePlayerMegaDmg, 1);

    // Driver Cheer On Star/Mega/Bullet Hits (by Gearworks)
    directWriteBranch(DriverCheerOnSMBHits_Hook1, DriverCheerR30, true);
    directWriteBranch(DriverCheerOnSMBHits_Hook2, DriverCheerR31, true);
    directWriteBranch(DriverCheerOnSMBHits_Hook3, DriverCheerR30, true);
    directWriteBranch(DriverCheerOnSMBHits_Hook4, DriverCheerR31, true);
    directWriteBranch(DriverCheerOnSMBHits_Hook5, DriverCheerR30, true);
    directWriteBranch(DriverCheerOnSMBHits_Hook6, DriverCheerR31, true);

    // Disable Fake Hits From Statuses For Online Players (by Gearworks)
    directWriteBranch(DisableFakeHitsFromStatuses_Hook1, DisableFakeHits, true);
    directWriteBranch(DisableFakeHitsFromStatuses_Hook2, DisableFakeHits, true);
    directWriteBranch(DisableFakeHitsFromStatuses_Hook3, DisableFakeHits, true);
    directWriteBranch(DisableFakeHitsFromStatuses_Hook4, DisableFakeHits, true);
    directWriteBranch(DisableFakeHitsFromStatuses_Hook5, DisableFakeHits, true);
    directWriteBranch(DisableFakeHitsFromStatuses_Hook6, DisableFakeHits, true);

    // Cancel Shrunk Status When Using Star (by Gearworks)
    directWriteBranch(KartStarShrinkCancel_Hook, KartStarShrinkCancel, false);

    // Disable Event Receive Thunder Cloud Pass Radius Check (by Gearworks)
    directWrite32(DisableTCPassRadiusCheck, 0x4800001C);

    // Enable calcRecovery (by Gearworks)
    directWriteBranch(CalcRecoveryHook_Push, CalcRecovery_Push, true);
    directWriteBranch(CalcRecoveryHook_Pop, CalcRecovery_Pop, true);
    directWrite32(CalcRecovery_WriteNegate, 0x7C9C00D0);

    //////////////////
    // Online Stuff //
    //////////////////

    // Force CC (by Star)
    directWriteBranch(ForceCCHook, ForceCC, true);

    // Friend Room Race Count Modifier (by MrBean)
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

    // Change Characters Between Races (by MrBean)
    directWriteBranch(ChangeCharsHook, ChangeCharsSetup, false);
    directWriteBranch(ChangeCharsHook2, ChangeCharsASM, true);
    directWriteBranch(ChangeCharsHook3, ChangeCharsASM2, true);
    directWriteArray(VtablePtr, ChangeCharsData, 0x14);

    // Disable TF Music Reset (by tZ)
    directWrite32(NoTFMusicReset, 0x48000010);

    // Don't Lose VR When Disconnecting (by Bully)
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
    directWriteNopOffset(HybridDrift8Hook, 0xC);
    directWriteBranch(HybridDrift8Hook, HybridDrift8, true);
    directWrite16(WiiWheelFix, 0);
    directWrite16(WiiWheelFix2, 0x4800);
    directWrite32(CameraFix, 0x38600000);

    // Instant DC (by CLF78)
    directWriteBranch(InstantDCHook, InstantDC, true);

    // License Unlocker (by tZ)
    directWrite32(LicenseUnlocker, 0x38600001);

    // Points Modifier (by CLF78)
    directWriteBranch(PointsModifierHook, PointsModifier, true);

    // Silent Controller Changing (by Bully)
    directWriteNop(NoControllerDC);

    // Slot Crash Patcher (by Melg)
    directWriteNop(SLFix);
    directWriteBranchOffset(SLFix, 0x4, SherbetFix, true);
    directWriteNopOffset(SLFix, 0x2E8);
    directWriteBranch(SGBFix, HeyhoFix, true);
    directWrite16Offset(SGBFix, 0xA, 0x0018);
    directWriteBranch(MHFix, RidgeFix, true);
    directWrite16Offset(MHFix, 0xA, 0x0018);
    directWriteBranch(MHMatFix, RidgeMatFix, true);
    directWrite32Offset(MHMatFix, 0x4, 0x2C030001)

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
    if (NoMusic == 1) {
        directWrite32(NoMusicHook, 0x38600000);
    }

    // No Character Voices (by Melg)
    if (NoCharVoice == 1) {
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
        directWriteBranch(TimeDiffPosHook, TimeDiffPos, true);
    }

    // Speedometer (by stebler and CLF78)
    if (Speedometer == 1) {
        directWriteBranch(SpeedoNoPauseHook, SpeedoNoPause, true);
    }

    // Applies the two options above (by CLF78)
    directWriteBranch(TimeDiffApplyHook, TimeDiffApply, true);

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

    ////////////////////
    //     Debug      //
    ////////////////////

    // Item Cycler (by Ro)
    directWriteBranch(ItemCyclerHook, ItemCycler, true);

    sync();
    isync();
}
