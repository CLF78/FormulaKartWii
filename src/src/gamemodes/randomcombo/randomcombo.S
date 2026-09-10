.include "asm_setup.S"

.global DriftSelectPageBack, MultiDriftSelectPageBack, ModelRendererFix
.extern DriftSelectPageBackOg, RandomCombos, RandomComboReroll, ModelRendererFixHook

ModelRendererFix:
li r5, 3
lis r12, RandomCombos@ha
lbz r12, RandomCombos@l (r12)
cmpwi r12, 1
bne setState
li r5, 2
setState:
b ModelRendererFixHook+4

DriftSelectPageBack:
//check if random combos are on
lis r5, RandomCombos@ha
lbz r4, RandomCombos@l (r5)
cmpwi r4, 1
bne normal

//check if rerolled already
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
