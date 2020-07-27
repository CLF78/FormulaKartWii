#include <stdint.h>
#include <stdbool.h>
#include "include.h"

#define MEM1HI (0x817F0520 - CODESPACE)

void loadGCT() {
	bool codeLoaded;
	char buffer[32];
	// byte after the gameId is the disc number but this is mkw specific so it doesnt matter
	sprintf(buffer, "/codes/%s.gct", &gameId);
	DVDHandle fd;
	bool ret = DVDOpen(buffer, &fd);
	// uh oh
	if (ret == false) {
		codeLoaded = false;
		return;
	}
	// get the aligned file length because this is how the game does it
	uint32_t length = fd.length + 0x1f & 0xffffffe0;
	// failsafe
	if (length > CODESPACE) {
		DVDClose(&fd);
		codeLoaded = false;
		return;
	}
	// temporarily move mem1 back so we can load the file with no issues
	OSSetMEM1ArenaHi(0x817f0520);
	DVDReadPrio(&fd, (void*)MEM1HI, fd.length, 0, 0);
	// now the codes wont be overwritten
	OSSetMEM1ArenaHi(MEM1HI);
	codeLoaded = true; // hooray
	return;
}

void afterStaticRLoad() {
	// make exception appear automatically
	directWrite((uint32_t*)_autoException, 0);
}

void _start() { // hooks at the end of _init_registers
	// move mem1 arena hi so stuff gets created properly
	directWrite((uint32_t*)0x80003110, MEM1HI);
	// create load gct branch at end of __init_cpp_exceptions
	directBranchEx(&_init_cpp_exceptionsHook, loadGCT, false);
	// actually load the codes
	directBranchEx(&_hook, file_start, false);
	// self explanatory
	directBranchEx(&_afterStaticRLoad, afterStaticRLoad, false);
}
