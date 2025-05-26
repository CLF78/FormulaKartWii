#include "common.h"
#include "menudata.h"

char VehicleRestrict;
u32 CalcRandom();
u32 GetWeightClass(u32 character);

void RandomComboPickerC(Menudata98* mdata) {
    // Take splitscreen into account
    for (int i = 0; i < mdata->localPlayerCount; i++) {

        // Get character excluding Miis
        u32 character = CalcRandom() % 0x18;

        // Get weight class
        u32 weightClass = GetWeightClass(character);

        // Use branchless method
        bool isBike;

        // Get if kart or bike
        if (VehicleRestrict == 1 || VehicleRestrict == 2)
            isBike = VehicleRestrict - 1;
        else
            isBike = CalcRandom() & 1;

        // Get random vehicle
        u32 vehicle = (CalcRandom() % 6 * 3) + (0x12 * isBike) + weightClass;

        // Store them
        mdata->charData[i].character = character;
        mdata->charData[i].vehicle = vehicle;

        // Reset character and vehicle in Racedata to prevent showing the wrong character on course select
        mdata->prevCharacters[i] = -1;
        mdata->prevVehicles[i] = -1;
    }
}
