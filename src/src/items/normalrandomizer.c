#include "common.h"
#include "racedata.h"

typedef struct {
    u8 unk[0x18];
    u8 pid;
} ItemHolderPlayer;

typedef struct {
    u8 unk[0x34];
    u32 shockTimer, blueTimer, blooperTimer, powTimer;
} ItemSlotData;

extern u8 ItemChances[2][19][2];
extern u8 ItemAmounts[2][12];

bool NewbieHelper(u32 pid);
u32 CalcRandom();
bool canItemBeGotten(u32 item);

u32 AmountRandomizer(u32 item, u32 pid) {
    bool newbie;

    if (pid == 0xC || Racedata->main.scenarios[0].players[pid].playerType != PLAYER_REAL_LOCAL)
        newbie = false;
    else
        newbie = NewbieHelper(pid);

    u32 rand = CalcRandom() % 100;
    u32 amount = 1;
    u32 doubleChance = ItemChances[newbie][item][0];
    u32 tripleChance = ItemChances[newbie][item][1];

    if (rand >= doubleChance) {
        amount++;
        if (rand >= tripleChance)
            amount++;
    }

    if (pid != 0xC) {
        ItemAmounts[0][pid] = ItemAmounts[1][pid];
        ItemAmounts[1][pid] = amount;
    }

    return amount;
}

u32 UltimateRandom(ItemSlotData *slot, u32 itemBoxSetting, u32 position, bool isHuman, bool unused, ItemHolderPlayer* player) {
    bool newbie = NewbieHelper(player->pid);
    u32 modulo = 20;
    u32 increment = 0;
    if (newbie && isHuman) {
        modulo = 10;
        increment = 7;
    }

    while (true) {
        u32 item = ((CalcRandom() % modulo) % 16) + increment;
        if (item == 0x5)
            continue;
        else if (item == 0xC) {
            if (!isHuman || newbie)
                continue;
        }
        else if (item == 0x10)
            item = 4;

        else if (item == 0x7) {
            if (slot->blueTimer || (!isHuman && position == 1))
                continue;
        }
        else if (item == 0x8) {
            if (slot->shockTimer || !canItemBeGotten(item))
                continue;
        }
        else if (item == 0xD) {
            if (slot->powTimer || !canItemBeGotten(item) || (!isHuman && position == 1))
                continue;
        }
        return item;
    }
}
