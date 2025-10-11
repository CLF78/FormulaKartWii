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
extern u8 ItemPool[19];
extern u8 NewbieItemPool[8];

bool NewbieHelper(u32 pid);
u32 CalcRandom();
bool canItemBeGotten(u32 item);

u32 AmountRandomizer(u32 item, u32 pid) {
    bool newbie;

    if (pid == 0xC || Racedata->main.scenarios[0].players[pid].playerType != PLAYER_REAL_LOCAL)
        newbie = false;
    else
        newbie = NewbieHelper(pid) && BetterItems;

    u32 rand = CalcRandom() % 100;
    u32 amount = 1;
    u32 doubleChance = ItemChances[newbie][item][0];
    u32 tripleChance = ItemChances[newbie][item][1];

    if (rand >= doubleChance) {
        amount++;
        if (rand >= tripleChance)
            amount++;
    }

    // If it's a CPU getting a blue shell, set its quantity to 1
    if (Racedata->main.scenarios[0].players[pid].playerType != PLAYER_REAL_LOCAL && item == 0x07) amount = 1;

    if (pid != 0xC) {
        ItemAmounts[0][pid] = ItemAmounts[1][pid];
        ItemAmounts[1][pid] = amount;
    }
	
    return amount;
}

u32 UltimateRandomOld(ItemSlotData *slot, u32 itemBoxSetting, u32 position, bool isHuman, bool unused, ItemHolderPlayer* player) {

    // Get Newbie Helper
    bool isNewbie = NewbieHelper(player->pid);
    bool isValid = false;
    u32 regularOptions = 19;
    u32 newbieOptions = 9;

    // Set default item as the Mushroom
    u32 item = 0x04;

    // Until an invalid item isn't determined, randomise new ones
    while (!isValid) {
		
        // Assume the item is valid
        isValid = true;
		
        // Check if Newbie Helper is enabled (CPUs aren't supposed to get better items)
        if (isNewbie && isHuman) {

            // For lapped players, the pool is of 9 items from 0x07 to 0x0F excluding 0x0C and including 0x04
            item = (CalcRandom() % newbieOptions) + 7;

            // If the item is 0x0C, substitute it back with 0x04
            if (item == 0x0C)
                item = 0x04;
        }
        else {
            // For regular players, the pool is of 15 items from 0x00 to 0x0F, with the items from 0x00 to 0x03 repeated once and excluding 0x05
            item = CalcRandom() % regularOptions;

            // If the item is 0x05 or over, shift it up by 1
            if (item >= 0x05 && item <= 0x0E)
                item += 1;

            // If the item is over 0x0F, make it repeat the items from 0x00 to 0x03 by shifting them down by 15
            else if (item >= 0x0F)
                item -= 15;
        }

        // Once we have found our item, check if it is available
        
		// Reroll the item if it's a blue shell for a CPU in first place
        if (item == 0x07 && !isHuman && position == 1) isValid = false;

        // Reroll the item if it's a feather for a CPU
        if (item == 0x0C && !isHuman) isValid = false;

        // Reroll the item if it's a POW block for a CPU in first place
        if (item == 0x0D && !isHuman && position == 1) isValid = false;

        // Reroll the item if it's a blue shell and the cooldown is still running
        if (item == 0x07 && slot->blueTimer) isValid = false;

        // Reroll the item if it's a shock and the cooldown is still running
        if (item == 0x08 && slot->shockTimer) isValid = false;

        // Reroll the item if it's a POW block and the cooldown is still running
        if (item == 0x0D && slot->powTimer) isValid = false;

        // Reroll the item if it's a shock and the item is held by another player
        if (item == 0x08 && !canItemBeGotten(item)) isValid = false;

        // Reroll the item if it's a POW block and the item is held by another player
        if (item == 0x0D && !canItemBeGotten(item)) isValid = false;

        // If all the checks passed, then the item is legit!
        
    }

    return item;

}

u32 UltimateRandom(ItemSlotData *slot, u32 itemBoxSetting, u32 position, bool isHuman, bool unused, ItemHolderPlayer* player) {

    // Get Newbie Helper
    bool isNewbieActive = NewbieHelper(player->pid) && BetterItems && isHuman;

	u8 pool[19];
	u8 poolSize = 19;
    
	if (isNewbieActive) {

		// Get the Newbie Helper item pool
		poolSize = 8;
		for (u8 i = 0; i < poolSize; i++) pool[i] = NewbieItemPool[i];
		pool[7] = ExtraItem;	// Set the selected extra item

		// Remove Lightning if it's held by another player or the cooldown is still running
		if (!canItemBeGotten(0x08) || slot->shockTimer) {
			pool[1] = 0xFF;
			poolSize--;
		}

		// Remove POW Block if it's the selected extra item and it's held by another player or the cooldown is still running
		if (pool[7] == 0x0D && (!canItemBeGotten(0x0D) || slot->powTimer)) {
			pool[7] = 0xFF;
			poolSize--;
		}

		// Remove Blue Shell if it's the selected extra item and the cooldown is still running
		if (pool[7] == 0x07 && slot->blueTimer) {
			pool[7] = 0xFF;
			poolSize--;
		}

	}
	else {
		
		// Get the regular item pool
		for (u8 i = 0; i < poolSize; i++) pool[i] = ItemPool[i];

		// CPU item replacements
		if (!isHuman) {

			// Replace Feather with Mushroom for CPUs
			pool[11] = 0x04;
			
			// If the CPU is in first place replace Blue Shell with Bob-omb
			if (position == 1) pool[6] = 0x06;

		}

		// Remove Blue Shell if the cooldown is still running
		if (slot->blueTimer) {
			pool[6] = 0xFF;
			poolSize--;
		}

		// Remove Lightning if it's held by another player or the cooldown is still running
		if (!canItemBeGotten(0x08) || slot->shockTimer) {
			pool[7] = 0xFF;
			poolSize--;
		}

		// Remove POW Block if it's held by another player, the cooldown is still running or if the CPU is in first place
		if (!canItemBeGotten(0x0D) || slot->powTimer || (!isHuman && position == 1)) {
			pool[12] = 0xFF;
			poolSize--;
		}
	}

	// Randomize the item from the available pool
	u8 rand = CalcRandom() % poolSize;
	u8 selected = -1;
	for (u8 i = 0; i <= rand; i++) {
		selected++;
		if (pool[selected] == 0xFF) selected++;	// If the item was removed from the pool, skip it
	}
	if (pool[selected] > 0x0F) return 0x04;	// Fallback to Mushroom if something went wrong
	return pool[selected];

}
