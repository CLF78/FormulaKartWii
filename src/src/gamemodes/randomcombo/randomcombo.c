#include "common.h"
#include "menudata.h"

char VehicleRestrict;
char RandomCombos;
void *DriverButton_VT;
_MenuData* Menudata;

u32 CalcRandom();
u32 GetWeightClass(u32 character);

void* GetButtonDriver(void* ctrlMenuCharSelect, u32 characterId);
void* GetButtonMachine(KartSelectPage* kartSelectPage, u32 kartId);

void MenuButtonSelect(void* button, u32 hudid);
void MenuButtonPress(void* button, u32 hudid, u32 unk);
void PageCheckActions(Page* page);
void MultiKartSelectOnButtonClick(MultiKartSelectPage* multiKartSelectPage, KartSelectControl* UIControl, u32 hudSlotId);

static u32 RandomComboPrevVehicles[2] = {-1};

void resetRandomComboPrevVehicles(){
    RandomComboPrevVehicles[0] = -1;
    RandomComboPrevVehicles[1] = -1;
}

void PressButtonHelper(Page* page, void* button, u32 hudid) {
    //select the button and call page check actions so it updates
    MenuButtonSelect(button, hudid);
    PageCheckActions(page);

    //press the button, deactivating the page
    MenuButtonPress(button, hudid, -1);
}

void CharSelectPageAfterInAnim(CharacterSelectPage* charSelectPage){
    if (!RandomCombos) { return; }

    for (u32 i = 0; i < Menudata->menudata98->localPlayerCount; i++) {
        // Get character excluding Miis
        u32 character = CalcRandom() % 0x18;

        // Get corresponding button
        void *button = GetButtonDriver(&charSelectPage->ctrlMenuCharSelect, character);

        // Select and Press that button
        PressButtonHelper(&charSelectPage->base, button, i);
    }
}

void KartSelectPageAfterInAnim(KartSelectPage* kartSelectPage){
    if (!RandomCombos) { return; }

    // Get weight class
    u32 weightClass = GetWeightClass(Menudata->menudata98->prevCharacters[0]);

    // Use branchless method
    bool isBike;

    // Get if kart or bike
    if (VehicleRestrict == 1 || VehicleRestrict == 2)
        isBike = VehicleRestrict - 1;
    else
        isBike = CalcRandom() & 1;

    // Get random vehicle
    u32 vehicle = (CalcRandom() % 6 * 3) + (0x12 * isBike) + weightClass;
    while (RandomComboPrevVehicles[0] == vehicle) {
        vehicle = (CalcRandom() % 6 * 3) + (0x12 * isBike) + weightClass;
    }
    RandomComboPrevVehicles[0] = vehicle;

    // Get corresponding button
    void *button = GetButtonMachine(kartSelectPage, vehicle);

    // Select that button and press that button
    PressButtonHelper(&kartSelectPage->base, button, 0);
}

void MultiKartSelectPageAfterInAnim(MultiKartSelectPage* multiKartSelectPage){
    if (!RandomCombos) { return; }

    for (u32 i = 0; i < Menudata->menudata98->localPlayerCount; i++) {

        /// Get weight class
        u32 weightClass = GetWeightClass(Menudata->menudata98->prevCharacters[i]);

        // Use branchless method
        bool isBike;

        // Get if kart or bike
        if (VehicleRestrict == 1 || VehicleRestrict == 2)
            isBike = VehicleRestrict - 1;
        else
            isBike = CalcRandom() & 1;

        // Get random vehicle
        u32 vehicle = (CalcRandom() % 6 * 3) + (0x12 * isBike) + weightClass;
        while (RandomComboPrevVehicles[i] == vehicle) {
            vehicle = (CalcRandom() % 6 * 3) + (0x12 * isBike) + weightClass;
        }
        RandomComboPrevVehicles[i] = vehicle;

        // convert vehicle to optionId branchless
        u32 optionId = (vehicle/*- weightClass*/) / 3 - ((VehicleRestrict == 2) * 6);

        // Get corresponding button
        KartSelectControl *button = &multiKartSelectPage->selects[i];
        button->optionId = optionId;

        // "Select" and Press that button
        button->anim->vt->animate(button->anim,optionId,1);
        MultiKartSelectOnButtonClick(multiKartSelectPage, button, i);
    }
}
