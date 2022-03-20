#include "common.h"
#include "dvd.h"
#include "kmpfile.h"
#include "stdlib.h"

extern KMPHeader* AltKMP;
u32 FindContainHeap(void* buffer); // incorrect signature, whatever

void TrackIdentifierLoad(u32 crc, void* ogSection) {
    char buffer[64];
    DVDHandle handle;

    // Print filename in buffer
    snprintf(buffer, 64, "/Race/Course/Patches/%08X.kmp", crc);

    // Open file
    bool fileOpened = DVDOpen(buffer, &handle);

    // Check if file exists
    if (fileOpened) {
        // If so, get its length and allocate it
        void* kmpData = new(handle.length, (void*)(FindContainHeap(ogSection) - 0x38), 32);

        // If allocation failed, bail
        if (kmpData != 0) {

            // Store static instance
            AltKMP = (KMPHeader*)kmpData;

            // Read the file there
            DVDReadPrio(&handle, kmpData, handle.length, 0, 2);
        }

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
