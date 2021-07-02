#include "common.h"

// Forward declarations
char filename, fatalstring;
void runPayload();

// This function loads all the codes that FKW uses after StaticR has loaded
void readPayload() {

	// Compose filename
	char buffer[32];
	sprintf(buffer, &filename, gameRegion);

	// Open the file
	DVDHandle fd;
	bool ret = DVDOpen(buffer, &fd);

	// Failsafe
	if (!ret) {
		u32 fataltextcolor = 0xFFFFFFFF;
		u32 fatalbackcolor = 0;
		OSFatal(&fataltextcolor, &fatalbackcolor, &fatalstring);
	}

	// Read the file (destination must be aligned by 32!)
	DVDReadPrio(&fd, (void*)0x808DD400, fd.length, 0, 0);

	// Close it
	DVDClose(&fd);

	// Run the payload
	runPayload();
}

// Initial function. This hooks at the end of init_registers
void start() {

	// Codehandler Annihilator (by CLF78)

	#ifndef DEBUG
	directWriteBlr(VIHook);
	directWriteBlr(KPADHook);
	directWriteBlr(GXDrawHook);
	directWriteBlr(GXFlushHook);
	directWriteBlr(OSSleepHook);
	directWriteBlr(AXNextFrameHook);
	memset((void*)0x80001800, 0, 0x1800);
	_directWriteBlr((void*)0x800018A8);
	#endif

	// Auto Strap Screen Skip (by TheLordScruffy)
	directWrite16(OSLaunchCode, 0x101);

	// Main Hook
	directWriteBranchEx(RelHook, readPayload, false);

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
