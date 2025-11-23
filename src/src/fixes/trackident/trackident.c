#include "common.h"
#include "dvd.h"
#include "kmpfile.h"
#include "stdlib.h"

extern KMPHeader* AltKMP;
extern u32 ENPTCRC; 
extern void* endOfFile;
u32 FindContainHeap(void* buffer); // incorrect signature, whatever

void TrackIdentifierLoad(u32 crc) {
    char buffer[64];
    DVDHandle handle;

    //save crc32 for online track check
    ENPTCRC = crc;

    // Print filename in buffer
    snprintf(buffer, 64, "/Race/Course/Patches/%08X.kmp", crc);

    // Open file
    bool fileOpened = DVDOpen(buffer, &handle);

    // Check if file exists
    if (fileOpened) {

		// Store static instance
        AltKMP = (KMPHeader*)&endOfFile;

        // Read the file there
        DVDReadPrio(&handle, &endOfFile, OSRoundUp32B(handle.length), 0, 2);

        // Close the file
        DVDClose(&handle);
    }
}

u32* GetAltKMPSection(u32* originalSection, u32 magic) {
    if (AltKMP == 0)
        return originalSection;

    for (int i = 0; i < AltKMP->numSections; i++) {
        u32* currSection = (u32*)((u32)AltKMP + AltKMP->headerLength + AltKMP->sectionOffsets[i]);
        if (*currSection == magic)
            return currSection;
    }

    return originalSection;
}

void TrackIdentifierDelete() {
    AltKMP = 0;
}
