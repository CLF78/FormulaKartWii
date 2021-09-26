#include "common.h"

// Forward declarations (these strings were made in ASM to prevent random alignment zeroes)
char filename, fatalstring;
loaderFunctions funcs[4];

// ASM Functions
char regionIdentifier();
__attribute__((noreturn)) void runPayload(); // Marked as no-return to prevent use of restgpr

// This function loads all the codes that FKW uses after StaticR has loaded
void readPayload() {

	// Get region
	char region = regionIdentifier();

	// Compose filename
	char buffer[32];
	funcs[region].sprintf(buffer, &filename, funcs[region].letter);

	// Open the file
	DVDHandle fd;
	bool ret = funcs[region].DVDOpen(buffer, &fd);

	// Failsafe
	if (!ret) {
		u32 fataltextcolor = 0xFFFFFFFF;
		u32 fatalbackcolor = 0;
		funcs[region].OSFatal(&fataltextcolor, &fatalbackcolor, &fatalstring);
	}

	// Read the file (destination must be aligned by 32!)
	funcs[region].DVDReadPrio(&fd, (void*)0x808DD400, fd.length, 0, 0);

	// Close it
	funcs[region].DVDClose(&fd);

	// Run the payload
	runPayload();
}

// Initial function. This hooks at the end of init_registers
void start() {

	// Auto Strap Screen Skip (by TheLordScruffy)
	directWrite16(OSLaunchCode, 0x101);

	// Main Hook
	directWriteBranch(RelHook, readPayload, false);

	// 30 FPS (by CLF78)
	if (ThirtyFPS == 1) {
		directWriteBranch(ThirtyFPSHook1, ThirtyFPS1, true);
		directWrite8(ThirtyFPSHook2, 2);
		directWrite8(ThirtyFPSHook3, 2);
	}

	// Flush cache
	sync();
	isync();
}
