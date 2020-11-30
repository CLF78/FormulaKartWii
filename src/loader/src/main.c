#include <stdint.h>
#include <stdbool.h>
#include "include.h"

#define MEM1HI (0x817F0520 - CODESPACE)

void loadGCT() {
	// Byte after the gameId is the disc number but this is mkw specific so it doesnt matter
	char buffer[32];
	sprintf(buffer, "/codes/%s.gct", &gameId);

	DVDHandle fd;

	// Open the file
	bool ret = DVDOpen(buffer, &fd);
	if (ret == false)
		return;

	// Get the aligned file length
	uint32_t length = fd.length + 0x1f & 0xffffffe0;

	// Failsafe
	if (length > CODESPACE) {
		DVDClose(&fd);
		return;
	}

	// Temporarily move MEM1 back so we can load the file with no issues
	OSSetMEM1ArenaHi(0x817f0520);
	DVDReadPrio(&fd, (void*)MEM1HI, fd.length, 0, 0);

	// Set it back
	OSSetMEM1ArenaHi(MEM1HI);
	return;
}

void afterStaticRLoad() {
	directWrite((uint32_t*)_autoException, 0);
}

// This hooks at the end of _init_registers
void _start() {
	// Move MEM1HI so stuff gets created properly
	directWrite((uint32_t*)0x80003110, MEM1HI);

	// Create loadGCT branch at end of __init_cpp_exceptions
	directBranchEx(&_init_cpp_exceptionsHook, loadGCT, false);

	// Actually load the codes
	directBranchEx(&_hook, file_start, false);

	// Make exception appear automatically
	directBranchEx(&_afterStaticRLoad, afterStaticRLoad, false);
}
