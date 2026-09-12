#pragma once

#include "common.h"

typedef struct {
    u32 character;
    u32 vehicle;
    u8 starRank;
    u8 pad[3];
} CharacterData;

typedef struct {
    u8 unk[0x124];
    u32 localPlayerCount;
    u32 unk2;
    u32 prevCharacters[4];
    u32 prevVehicles[4];
    u8 unk3[0xD4];
    CharacterData charData[2];
    // incomplete and i don't care
} Menudata98;

typedef struct {
    u8 unk[0x8];
    u32 currentState;
    u8 unk2[0x38];
} Page;

typedef struct {
    u32 Id;
    u32 animDir;
    Page* pages[211];
} Section;

typedef struct {
    Section *currentSection;
    u8 unk[0x94];
    Menudata98 *menudata98;
} _MenuData;

typedef struct {
    u8 unk[0x174];
    u32 curCharacterId;
    u8 unk2[0xB8];
} CtrlMenuCharSelect;

typedef struct {
    Page base;
    u8 unk[0x3EC];
    void* menuInputManager;
    u8 unk2[0x290];
    CtrlMenuCharSelect ctrlMenuCharSelect;
    // incomplete and i don't care
} CharacterSelectPage;

typedef struct {
    Page base;
    u8 unk[0x6B0];
    u32 curKartId;
    u8 unk2[0x314];
} KartSelectPage;

typedef struct someAnimator someAnimator;

typedef struct {
    u8 unk[0x18];
    void (*animate)(someAnimator*, u32, u32);
} someAnimatorVT;

struct someAnimator {
    someAnimatorVT* vt;
};

typedef struct {
    u8 unk[0x204];
    u32 optionId;
    u8 unk2[0xC];
    someAnimator* anim;
    u8 unk3[0x3B0];
} KartSelectControl;

typedef struct {
    u8 unk[0xd90];
    KartSelectControl selects[4];
    // incomplete and i don't care
} MultiKartSelectPage;