#include "common.h"

typedef struct {
    unsigned char unk[0x18];
    unsigned char pid;
} ItemHolderPlayer;

typedef struct {
    unsigned char unk[0x34];
    unsigned int shockTimer, blueTimer, blooperTimer, powTimer;
} ItemSlotData;

extern unsigned char ItemChances[2][19][2];
extern unsigned char ItemAmounts[2][12];

bool NewbieHelper(unsigned int pid);
unsigned int CalcRandom();
bool canItemBeGotten(unsigned int item);

unsigned int AmountRandomizer(unsigned int item, unsigned int pid) {
	bool newbie;

	if (pid == 0xC)
		newbie = false;
	else
		newbie = NewbieHelper(pid);

    unsigned int rand = CalcRandom() % 100;
    unsigned int amount = 1;
	unsigned int doubleChance = ItemChances[newbie][item][0];
	unsigned int tripleChance = ItemChances[newbie][item][1];

	if (rand >= doubleChance) {
		amount++;
		if (rand >= tripleChance)
			amount++;
	}

	if (pid != 0xC)
		ItemAmounts[1][pid] = amount;

	return amount;
}

unsigned int UltimateRandom(ItemSlotData *slot, unsigned int itemBoxSetting, unsigned int position, bool isHuman, bool unused, ItemHolderPlayer* player) {
	bool newbie = NewbieHelper(player->pid);
	unsigned int modulo = 20;
    unsigned int increment = 0;
	if (newbie && isHuman) {
		modulo = 10;
        increment = 7;
    }

	while (true) {
        unsigned int item = ((CalcRandom() % modulo) % 16) + increment;
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
