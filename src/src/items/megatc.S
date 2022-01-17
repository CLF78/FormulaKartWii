.include "asm_setup.S"

.extern ItemHolder, MegaTCHook2
.global MegaTC2

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
