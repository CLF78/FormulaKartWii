#include "common.h"
#include "dvd.h"
#include "stdlib.h"

extern void* AltKMP;

void TrackIdentifierLoad(u32 crc) {
	char buffer[64];
	DVDHandle handle;

	// Print filename in buffer
	snprintf(buffer, 64, "/Race/Course/Patches/%08X.kmp", crc);

	// Open file
	bool fileOpened = DVDOpen(buffer, &handle);

	// Check if file exists
	if (fileOpened) {
		// If so, get its length and allocate it
		void* kmpData = new(handle.length);

		// Store static instance
		AltKMP = kmpData;

		// Read the file there
		DVDReadPrio(&handle, kmpData, handle.length, 0, 2);

		// Close the file
		DVDClose(&handle);
	}
}
