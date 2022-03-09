.include "asm_setup.S"

.extern GameMode
.global MSGPatch, MSGPatch2, MSGPatch3

# Original instruction
MSGPatch:
addi r5, r1, 0x8

# Get first character of BMG name
lbz r4, 0x8(r5)

# Check for StaffRoll
cmpwi r4, 'S'
beq staffRollBmg

# Check for Menu
cmpwi r4, 'M'
beq menuBmg

# Check for Race
cmpwi r4, 'R'
bnelr+

# Race BMG
li r4, 'L'
stb r4, 0x8(r5)
blr

# Staffroll BMG
staffRollBmg:
li r4, 'e'
stb r4, 0x10(r5)
blr

# Menu BMG
menuBmg:
li r4, 'a'
stb r4, 0x9(r5)
blr

# Store BMG ID of Game Mode
MSGPatch2:
lis r5, GameMode@ha
lbz r5, GameMode@l(r5)
addi r5, r5, 1436
stw r5, 0x80(r1)

# Original instruction
addi r5, r1, 0x58
blr

# Store BMG ID of Game Mode
MSGPatch3:
lis r5, GameMode@ha
lbz r5, GameMode@l(r5)
addi r5, r5, 1436
stw r5, 0x78(r1)

# Modified original instruction
li r4, 0x5A1
blr
