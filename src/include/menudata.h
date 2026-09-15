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
