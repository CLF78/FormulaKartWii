# Notes: r25 is position, r3 is a pointer to ItemSlotData, r4 is item to be stored
# Other free registers: r5, r6, r7, r8

.set LapDistance, 0x800014B4

# Get a random number using the timebase as a seed
getRandom:
mftbl r4
li r5, 19
divw r5, r4, r5
mulli r5, r5, 19
subf r4, r5, r4
srawi r5, r4, 31
xor r4, r5, r4
subf r4, r5, r4

# Begin timer checks!
cmpwi r4, 7
beq blue

cmpwi r4, 8
beq shock

cmpwi r4, 13
bne+ checkNewbie

# POW timer + position check
pow:
lwz r5, 0x40(r3)
cmpwi r5, 0
bne+ getRandom
cmpwi r25, 1
bne+ end
li r4, 4
b end

# Blue timer check
blue:
lwz r5, 0x38(r3)
cmpwi r5, 0
bne+ getRandom
b end

# Shock timer check
shock:
lwz r5, 0x34(r3)
cmpwi r5, 0
bne+ getRandom
b end

# Checks that newbie helper is enabled
checkNewbie:
lis r6, LapDistance@h
ori r6, r6, LapDistance@l
mtlr r6
blrl

cmpwi r5, 0
beq+ end

cmpwi r4, 1
ble newbie1

cmpwi r4, 3
ble newbie2

cmpwi r4, 12
beq newbie3

cmpwi r4, 16
blt+ end

newbie4:
subi r4, r4, 2

newbie3:
subi r4, r4, 5
b end

newbie2:
addi r4, r4, 7

newbie1:
addi r4, r4, 5

end:
mr r3, r4

#ENDCODE
