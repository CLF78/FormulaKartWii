#include "common.h"
#include "exception.h"

// This function loads all the codes that FKW uses after StaticR has loaded
void loadCodes() {

	// These values will be used as filler throughout the function
	u8 tempVal8;
	u16 tempVal16;
	u32 tempVal32;

	// Exception Handler (by Star)
	directWrite32(ShowExceptions, 0);
	directWrite16(ExcDispInfo, (u16)(EXCEPTION_INFO_DEFAULT | EXCEPTION_INFO_GPR));

	// Wiimmfi Code Patches (by Leseratte)
	directWriteNop(WiimmfiPatch1);
	directWrite32(WiimmfiPatch2, 0x3BC00000);
	directWriteBranch(WiimmfiPatch3, WiimmfiASM1, false);
	directWriteBranch(WiimmfiPatch4, WiimmfiASM2, false);

	// An useless version string that Leseratte wants. The space is intentional!
	directWriteString(WiimmfiVersionString, "LE-CODE GCT v1 ");

	// Wiimmfi String Patches (by Seeky)
	directWriteString(NaswiiURL, "://ca.nas.wiimmfi.de/ca");
	directWriteString(NaswiiURL2, "://naswii.wiimmfi.de/ac");
	directWriteString(NaswiiURL3, "://naswii.wiimmfi.de/pr");

	#ifdef REGION_P
	directWriteString(NaswiiURL4, "://main.nas.wiimmfi.de/pp");
	#elif REGION_E
	directWriteString(NaswiiURL4, "://main.nas.wiimmfi.de/pe");
	#elif REGION_J
	directWriteString(NaswiiURL4, "://main.nas.wiimmfi.de/pj");
	#elif REGION_K
	directWriteString(NaswiiURL4, "://main.nas.wiimmfi.de/pk");
	#endif

	directWriteString(AvailableURL, "wiimmfi.de");
	directWriteString(GPCMURL, "wiimmfi.de");
	directWriteString(GPSPURL, "wiimmfi.de");
	directWriteString(MasterURL, "wiimmfi.de");
	directWriteString(NatnegURL, "wiimmfi.de");
	directWriteString(NatnegURL2, "wiimmfi.de");
	directWriteString(NatnegURL3, "wiimmfi.de");
	directWriteString(MSURL, "wiimmfi.de");
	directWriteString(GSURL, "wiimmfi.de");

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

	directWriteArray(NoItemLandingPoof, NoItemLandingPoofASM, 12);

	extern void* AllItemsCanLand;
	tempVal32 = (u32)&AllItemsCanLand;
	directWrite32(ItemLandMega, tempVal32);
	directWrite32(ItemLandGolden, tempVal32+8);
	directWrite32(ItemLandBill, tempVal32+16);

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

	// BRCTR Redirector (by CLF78)
	directWrite8(LapNumberCTR, 'f');
	directWrite8(ItemWindowCTR, 's');

	// Bullet Bill Speed Modifier (by davidevgen, CLF78 and Ismy)
	directWrite16(BulletBillSpeed, 0x435C);

	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wpointer-to-int-cast"
	tempVal8 = (u8)&BulletBillSpeed;
	#pragma GCC diagnostic pop

	directWrite8(CannonLandingFix, tempVal8);
	directWriteBranch(CannonSpeed, CannonSpeedMultiplier, false);
	directWriteBranch(CannonSpeed2, CannonSpeedMultiplier2, true);

	// DC Bug Fix (by Seeky)
	directWrite32(DCFix, 0x38E40032);

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

	// Fast POW (by mdmwii)
	directWrite8(POWTimer, 0x80);

	// Final Lap Music Trigger Modifier (by CLF78)
	directWriteBranch(FastMusicHook, FinalLapCheck, true);
	directWriteBranch(FastMusicHook2, PitchReset, true);
	directWriteBranch(FastMusicHook3, PitchReset2, false);

	// GeoHit Patches (by CLF78 and Ismy)
	tempVal8 = 'N';
	directWrite8(GeoHitTableItem, tempVal8);
	directWrite8(GeoHitTableItemObj, tempVal8);
	directWriteBranch(GeoHitTableKartHook, GeoHitTableKartFix, true);
	directWrite8(GeyserCollFix, 9);

	// Green Shell Speed Modifier (by davidevgen)
	directWrite16(GreenShellSpeed, 0x4320);

	// Impervious TC (by CLF78)
	directWriteBranch(ImperviousTCHook, ImperviousTCFunc, true);
	directWrite32(ImperviousTCHook2, 0x48000038);

	// Inside Drift Bikes (by Seeky)
	directWriteBranch(KartParamHook, DriftOverride, true);

	// Instant Item Boxes (by Anarion)
	directWriteNop(InstantItemBoxes);

	// Item Textures (by CLF78)
	directWriteBranch(ItemTexturesHook, ItemTextures, false);

	// Lap Counter (by TheLordScruffy)
	directWrite32(SetLapCount, 0x38600032);
	directWriteBranch(ColorFixHook, ColorFix, false);

	// Max Item Limit Modifier (by CLF78)
	directWriteBranch(ItemLimitSetup, ItemLimitMod, true);

	// Mega Flips Cars (by JoshuaMK)
	directWrite8(MegaFlip, 1);

	// Mega Mushroom Size Multiplier (by CLF78 and TheLordScruffy)
	directWriteBranch(MegaSizeHook, MegaSizeMod, true);
	directWriteBranch(FOVChange, FOVFix, true);

	// Mega Thundercloud (by tZ)
	directWriteBranch(MegaTCHook, MegaFunc, true);

	// Motion-Sensor Bombs (by Hamster)
	tempVal16 = 0x7FFF;
	directWrite16(BombTimer, tempVal16);
	directWrite16(BombTimer2, tempVal16);

	// No Bullet Bill Icon (by Anarion)
	directWriteBlr(NoBBIcon);

	// No Invincibility Frames (by CLF78)
	directWriteBranch(NoInvFramesHook, NoInvFrames, true);
	directWrite8(NoRespawnInv, 0x20);
	directWrite8(StarInBullet, 0);
	directWrite8(ShroomInBullet, 0);
	directWriteNop(StarWhenHit);
	directWriteNop(ShroomWhenHit);

	// Prevent Shock/POW Drop (by CLF78)
	directWriteBranch(DropFunc, NoDrop, true);

	// Remove Mushroom Bug (by Vega and CLF78)
	directWrite8(RemoveShroomBug, 0);
	directWriteBranch(RemoveFakeShroom, NoFakeShroom, true);
	directWriteArray(RemoveFakeShroom2, NoFakeShroom2, 0xC);
	directWrite32(RemoveFakeShroom3, 0x48000020);

	//////////////////////////////////////
	// Replace Blooper with Triple FIBs //
	//////////////////////////////////////

	// Prevent the Blooper from working
	directWriteBlr(BlooperKiller);

	// Hide the floating Blooper model
	tempVal32 = 0x7F000000;
	directWrite32(BlooperHideModel, tempVal32);
	directWrite32Offset(BlooperHideModel, 8, tempVal32);

	// Change the item's data
	directWriteArray(BlooperItemStruct, BlooperData, 24);

	// Shells Never Break (by CLF78)
	directWrite16(ShellHitCount, 0x4800);
	directWrite16(ShellHitCount2, 0x4800);

	// Show Times After Race (by Melg and CLF78)
	directWriteNop(ShowTimesVS);
	directWriteBranch(ShowTimesWW, TimesFunc, true);
	directWriteBranch(TimePrintHook, TimePrint, true);
	directWriteNop(SpeedoTextParseNop);
	directWriteBranch(SpeedoTextParse, SpeedoTextParseASM, true);

	// Starting Lap Modifier (by CLF78, Ismy and Melg)
	directWriteArray(StartingLapHook, StartingLap, 8);
	directWriteBranch(LapCountFixHook, LapCountFix, true);
	directWriteBranch(JingleFixHook, JingleFix, true);
	tempVal32 = 0x380000FF;
	directWrite32(LastLap, tempVal32);
	directWrite32(LastLapLakitu, tempVal32);
	directWriteBranch(LapSignFixHook, LapSignFix, true);
	directWrite32(LapSignFix2, 0x7FAC0774);
	directWrite16(NoLapFix, 0x4800);
	directWriteBranch(LakituBoardHook, LakituBoard, true);
	directWrite32(LapArrayIncrease, 0x38A0000A);
	directWriteBranch(TimeStoreHook, TimeStore, true);
	directWriteBranch(TimeStoreHook2, TimeStore2, false);
	directWriteBranch(TimeStoreHook3, TimeStore3, false);
	directWriteBranch(FinishTimesHook, FinishTimes, false);

	// Time Limit Modifier (by MrBean)
	directWriteArray(TimeLimit, NewTimeLimit, 8);

	// Ultra UnCut (by MrBean)
	directWriteBranch(CKPTCheck, UltraUncut, true);

	//////////////////////////////
	// Ultimate Item Randomizer //
	//////////////////////////////

	// Itembox Randomizer
	directWriteBranch(SharedItemHook, UltimateRandom, true);

	// Bush/Woodbox/Goomba Randomizer
	directWriteBranch(SpecialItemHook, SpecialRandom, true);

	//////////////////////
	// Woodbox Modifier //
	//////////////////////

	// Update respawn time and height
	directWriteArray(WoodRespawn, WoodboxData, 8);

	// Force probability to 100 (also affects Bushes!)
	directWriteBranch(WoodProb, WoodboxPatch, true);

	// Cycle Fix - Coconut Mall (by CLF78 and Ismy)
	directWriteBranch(EscalatorFixHook, EscalatorFix, true);
	directWriteBranch(PiantaFixHook, PiantaFix, true);

	// Cycle Fix - Dry Dry Ruins (by CLF78 and Ismy)
	directWriteBranch(PillarFixHook, PillarFix, true);
	directWriteBranch(SandpitFixHook, SandpitFix, true);
	directWrite8(SandpitFix2, 0x90);
	directWrite8(SandpitFix3, 0x80);

	////////////////////////////////
	// Cycle Fix - Ghost Valley 2 //
	////////////////////////////////

	// Update the blocks' fall delay
	directWrite16(GV2Fix, 0x3C0);

	// Cycle Fix - Grumble Volcano (by CLF78 and Ismy)
	directWrite16(RockFix, 0x3C0);
	directWriteBranch(RockFix2Hook, RockFix2, true);
	directWriteBranch(GeyserFixHook, GeyserFix, true);

	// Cycle Fix - Toad's Factory (by CLF78 and Ismy)
	directWriteBranch(ConveyorFixHook, ConveyorFix, true);

	//////////////////////////
	// Game Modes - Generic //
	//////////////////////////

	// Swap some specific scenes and set the GameMode byte
	directWriteBranch(SceneSwapHook, GameModeSelector, true);

	// Room message flags (HOST)
	directWriteBranch(HostFlagsHook, HostFlags, false);

	// Room message flags (GUEST)
	directWriteBranch(GuestFlagsHook, GuestFlags, false);

	// Let people choose all vehicles on modes that replace Battle Mode online
	directWriteBranch(BattleFixHook, BattleFix, false);
	directWrite32(BattleFixHook2, 0x48000044);

	// Clear flags when leaving/entering rooms
	directWriteBranch(FlagResetHook, FlagReset, false);
	directWriteBranch(FlagResetHook2, FlagReset, false);
	directWriteBranch(FlagResetHook3, FlagReset, false);
	directWriteBranch(FlagResetHook4, FlagReset, false);
	directWriteBranch(FlagResetHook5, FlagReset, false);

	// Always Win Track Vote option
	directWriteBranch(AlwaysWinVoteHook, VotePatch, true);

	// Hook used both by Sabotage and Takedown
	directWriteBranch(TimerManagerHook, GameModeMaster, false);

	/////////////////////////////////
	// Offline Race Count Modifier //
	/////////////////////////////////

	// Update the number of buttons (we cannot have more than 15 buttons, as it will otherwise overflow in the other settings)
	directWrite8(RaceCountFix1, 15);

	// Write (index+1) to the button, instead of loading from the array
	directWrite32(RaceCountFix2, 0x381F0001);
	directWriteNop(RaceCountFix3);

	// Force default case and again use (index+1) as the value
	directWrite16(RaceCountFix4, 0x4800);
	directWriteBranch(RaceCountFix5, RaceCountFix, true);

	////////////////////////
	// Play VS Race Alone //
	////////////////////////
	directWrite32(NoCPU, 0x38E00004);

	// Game Mode - Ramp Up (by CLF78, Ismy and stebler)
	directWriteBranch(RampUpHook, RampUp, false);
	directWriteBranch(RampUpSpeedFixHook, RampUpSpeedFix, false);
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

	// Game Mode - Teams (by CLF78, Ismy and Chippy)
	directWrite32(NoItemGlow, 0x38000000);
	tempVal16 = 0x4800;
	directWrite16(NoTeamInvincibility, tempVal16);
	directWrite16(NoTeamInvincibility2, tempVal16);
	directWrite16(NoTeamInvincibility3, tempVal16);
	directWriteNop(NoTeamInvincibility4);

	//////////////////
	// Online Stuff //
	//////////////////

	// Force CC
	directWriteBranch(ForceCCHook, ForceCC, true);

	// Friend Room Race Count
	directWrite8(FroomRaceCount, 0);
	directWrite8(FroomRaceCount2, 0);

	/////////////////////////////
	// Remove Worldwide Button //
	/////////////////////////////

	// Decrease button count
	directWrite8(NoWWButton, 5);

	// Skip WW button setup
	directWriteNop(NoWWButton2);
	directWriteNop(NoWWButton3);
	directWrite32(NoWWButton4, 0x48000010);

	// Replace child 1 with a different button
	directWrite8(NoWWButton5, 1);

	// Redirect button handlers to Regional button
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

	// Change Characters Between Races - THIS CODE SUCKS
	directWriteBranch(ChangeCharsHook, ChangeCharsSetup, false);
	directWriteBranch(ChangeCharsHook2, ChangeCharsASM, true);
	directWriteBranch(ChangeCharsHook3, ChangeCharsASM2, true);
	directWriteArray(VtablePtr, ChangeCharsData, 0x14);

	// Disable TF Music Reset
	directWrite32(NoTFMusicReset, 0x48000010);

	// Don't Lose VR When Disconnecting
	directWriteNop(NoVRLoss);

	// Instant DC (by CLF78)
	directWriteBranch(InstantDCHook, InstantDC, true);

	// License Unlocker (by tZ)
	directWrite32(LicenseUnlocker, 0x38600001);

	// Points Modifier (by CLF78)
	directWriteBranch(PointsModifierHook, PointsModifier, true);

	// Silent Controller Changing
	directWriteNop(NoControllerDC);

	////////////////////
	// Custom Options //
	////////////////////

	// Faster Menu Navigation
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

	// No Music
	if (NoMusic == 1) {
		directWrite32(NoMusicHook, 0x38600000);
	}

	// No Character Voices
	if (NoCharVoice == 1) {
		directWrite32(NoCharVoiceHook, 0x38600001);
	}

	// Force Battle Glitch (by XeR)
	if (BtGlitch == 1) {
		directWrite32(TagDistance, 0x47927C00);
	}

	// Show Time Difference (by Melg and CLF78)
	if (TimeDiff == 1 || TimeDiff == 2) {
		directWrite8(GhostFileSkip, 1);
		directWriteBranch(TimeDiffPatchHook, TimeDiffPatch, true);
		directWriteBranch(TimeDiffPatchHook2, TimeDiffPatch2, false);
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

	sync();
	isync();
}
