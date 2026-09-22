.include "asm_setup.S"

.global DriftSelectPageBack, MultiDriftSelectPageBack, ModelRendererFix, ModelRendererFix2, RerollFlagReset
.extern DriftSelectPageBackOg, RandomCombos, ModelRendererFixHook, resetRandomComboPrevVehicles

//Flags here instead of EVA (I dont like it)

//3 for no, 2 for yes 
//saves 2 insctructions
DelayAnimFlag:
.byte 3
RandomComboReroll:
.byte 0 
.align 4

ModelRendererFix2:
li r5, 2

//check if random combos are on
lis r12, RandomCombos@ha
lbz r12, RandomCombos@l (r12)
cmpwi r12, 1
bne setState2

//check for delay
lis r11, DelayAnimFlag@ha
lbz r12, DelayAnimFlag@l (r11)
cmpwi r12, 2
bne setState2

//switchstate
li r5, 3
stb r5, DelayAnimFlag@l (r11)

setState2:
b ModelRendererFixHook2+4

ModelRendererFix:
li r5, 3

//check if random combos are on
lis r12, RandomCombos@ha
lbz r12, RandomCombos@l (r12)
cmpwi r12, 1
bne setState

//delay switchstate by one frame
li r5, 2
lis r12, DelayAnimFlag@ha
stb r5, DelayAnimFlag@l (r12)

setState:
b ModelRendererFixHook+4

DriftSelectPageBack:
//check if random combos are on
lis r5, RandomCombos@ha
lbz r4, RandomCombos@l (r5)
cmpwi r4, 1
bne normal

//check if rerolled already
lis r5, RandomComboReroll@ha
lbz r4, RandomComboReroll@l (r5)
cmpwi r4, 1
beq end

//set the reroll flag and hide the back button
li r4, 1
stb r4, RandomComboReroll@l (r5)
stb r4, 0xD4(r3)

//replace the target page with CharacterSelect to reroll
li r4, 0x6B
stw r4, 0x3ec (r3)

normal:
b DriftSelectPageBackOg

MultiDriftSelectPageBack:
//check if hudid 0
cmpwi r4, 0
bne multinormal

//check if random combos are on
lis r6, RandomCombos@ha
lbz r12, RandomCombos@l (r6)
cmpwi r12, 1
bne multinormal

//check if rerolled already
lis r5, RandomComboReroll@ha
lbz r12, RandomComboReroll@l (r6)
cmpwi r12, 1
beq end

//set the reroll flag and hide the back button
li r12, 1
stb r12, RandomComboReroll@l (r6)
stb r12, 0xD4(r3)

//replace the target page with CharacterSelect to reroll
li r12, 0x6B
stw r12, 0x3ec (r3)

multinormal:
b MultiDriftSelectPageBackOg

end:
blr

RerollFlagReset:
#reset reroll
li r11, 0
lis r12, RandomComboReroll@ha
stb r11, RandomComboReroll@l (r12)

#reset excluded vehicles
bl resetRandomComboPrevVehicles

#restore registers
mr r3, r29
li r4, 0x6b
b RerollFlagResetHook+4
