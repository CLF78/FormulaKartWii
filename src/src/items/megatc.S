.include "asm_setup.S"

.extern ItemHolder, MegaTCHook, MegaTCHook2, MegaFunc, BillFunc, TCGlitchFixHook
.global MegaTC, MegaTC2, TCGlitchFix

# Get player id
MegaTC:
lwz r3, 0(r3)
lwz r3, 0(r3)
lbz r3, 0x10(r3)

# Call newbie helper function
bl NewbieHelper

# Restore r3
mr r3, r31

# Activate mega (cr0+gt was already set in the asm, no need to repeat compares here)
bgt bullet
bl MegaFunc
b end

# Activate bullet
bullet:
li r4, 0xFF
bl BillFunc

end:
b MegaTCHook+4

# Original instruction
MegaTC2:
lwz r3, 0x1A0(r28)

# Get active tc count
lis r4, ItemHolder@ha
lwz r4, ItemHolder@l(r4)
lwz r5, 0x250(r4)
mtctr r5

# Get tc object array
lwz r5, 0x244(r4)
subi r5, r5, 4

# Check if the tc is the same as the one we're hooking in
loop:
lwzu r4, 0x4(r5)
cmpw r4, r28
beq skip

# Check if the tc's associated player is the same as the one we're checking
lwz r4, 0x1A0(r4)
cmpw r4, r3
beq exitLoop

# Continue loop
skip:
bdnz+ loop

# No other tcs found, resume function execution
b MegaTCHook2+4

# Another tc was found, do not remove the tc flag
exitLoop:
b MegaTCHook2+0xC

# Original instruction
TCGlitchFix:
mulli r0, r0, 0x248

# Get active tc count (plus 1 because the tc was already removed)
lwz r5, 0x250(r4)
addi r5, r5, 1
mtctr r5

# Get tc object array
lwz r5, 0x244(r4)
subi r5, r5, 4

# Get associated player
lwz r6, 0x1A0(r3)

# Check if the tc is the same as the one we're hooking in
loop2:
lwzu r7, 0x4(r5)
cmpw r7, r3
beq skip2

# Check if the tc's associated player is the same as the one we're checking
lwz r7, 0x1A0(r7)
cmpw r7, r6
beq exitLoop2

# Continue loop
skip2:
bdnz+ loop2

# No other tcs found, drop tc flag
lwz r6, 0(r6)
lwz r6, 0x4(r6)
lwz r7, 0xC(r6)
rlwinm r7, r7, 0, 3, 1
stw r7, 0xC(r6)

# Resume function execution
exitLoop2:
b TCGlitchFixHook+4
