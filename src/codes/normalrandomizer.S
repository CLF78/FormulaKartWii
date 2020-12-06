# Notes: r25 is position, r3 is item to be stored, r4 is a pointer to ItemSlotData
# Other free registers: r5, r6, r7

.set NewbieHelper, 0x800001B0

.if (REGION == 'P')
	.set ItemSlotData, 0x809C3670
.elseif (REGION == 'U')
	.set ItemSlotData, 0x809BEE68
.elseif (REGION == 'J')
	.set ItemSlotData, 0x809C26D0
.elseif (REGION == 'K')
	.set ItemSlotData, 0x809B1CB0
.else
    .err
.endif

# Load ItemSlotData
lis r4, ItemSlotData@ha
lwz r4, ItemSlotData@l(r4)

# Get a random number using the timebase as a seed
getRandom:
  mftbl r3
  li r5, 19
  divw r5, r3, r5
  mulli r5, r5, 19
  subf r3, r5, r3
  srawi r5, r3, 31
  xor r3, r5, r3
  subf r3, r5, r3

# Begin timer checks!
cmpwi r3, 7
beq blue

cmpwi r3, 8
beq shock

cmpwi r3, 13
bne+ checkNewbie

# POW timer + position check
pow:
	lwz r5, 0x40(r4)
	cmpwi r5, 0
	bne+ getRandom
	cmpwi r25, 1
	bne+ end
	li r3, 4
	b end

# Blue timer check
blue:
	lwz r5, 0x38(r4)
	cmpwi r5, 0
	bne+ getRandom
	b end

# Shock timer check
shock:
	lwz r5, 0x34(r4)
	cmpwi r5, 0
	bne+ getRandom
	b end

# Checks that newbie helper is enabled
checkNewbie:
	lis r4, NewbieHelper@ha
	lwz r4, NewbieHelper@l(r4)
	cmpwi r4, 0
	beq+ end

	cmpwi r3, 1
	ble newbie1

	cmpwi r3, 3
	ble newbie2

	cmpwi r3, 12
	beq newbie3

	cmpwi r3, 16
	blt+ end

newbie4:
	subi r3, r3, 2

newbie3:
	subi r3, r3, 5
	b end

newbie2:
	addi r3, r3, 7

newbie1:
	addi r3, r3, 5

# Original instruction
end:
	stw r3, 32(r23)

#ENDCODE