.include "asm_setup.S"

.extern Racedata, Menudata
.global VSPauseMenu

# Check if in Time Trials, if so, end the code
VSPauseMenu:
lwz r3, Menudata@l (r6)
lwz r12, Racedata@l (r6)
lwz r0, 0x1760 (r12)
cmpwi r0, 2
beq end

# Check if caller section is Change Character, if it is, fix the redirect and decrement race count by one
cmpwi r4, 0x49
bne continue
li r4, 0x48
b decreaseRaceNum 

# Check if caller section is Change Course, if not, end the code
continue:
cmpwi r4, 0x4A
bne end

# Change section to VS Cup Select
li r4, 0x4B

# Check if VS, if it is, decrement race count by one
cmpwi r0, 1
beq decreaseRaceNum

# Not VS, so it's Battle, set to Battle Cup Select instead
li r4, 0x4C

# Decrement race count by one because Change Course and Change Character sections increment it by one, so if you are in race number 1 and change course/character, it'll go to race 2, so decrement it to keep it the same
decreaseRaceNum:
lwz r6, 0x98 (r3)
lwz r31, 0x60 (r6)
subi r31, r31, 1
stw r31, 0x60 (r6)

# Set course intro camera, it is set before changing course/character so it needs to be manually set
li r31, 5
stw r31, 0x1764 (r12)

# END THE CODEEEEEE (And restore r31)
end:
mr r31, r5
blr
