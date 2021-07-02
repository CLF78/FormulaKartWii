.include "asm_setup.S"

.extern SetPaneColor, ColorFixHook
.global ColorFix, PositionFix

#############
# Color Fix #
#############

# First call
ColorFix:
mr r3, r28
bl trick

.string "lap_lefft"
.align 2

trick:
mflr r4
li r5, 1
bl SetPaneColor

# Second call
mr r3, r28
bl trick2

.string "lap_riighter"
.align 2

trick2:
mflr r4
li r5, 1
bl SetPaneColor

# Original instruction
mr r3, r28
b ColorFixHook+4

################
# Position Fix #
################

# Original instruction
PositionFix:
mr r3, r30

# Check if lap is 2
cmpwi r0, 0xCF
bne+ not2
lis r5, 0xC2B4
b store

# Check if lap is 10
not2:
cmpwi r0, 0xD7
bne+ not10
lis r5, 0xC2E6
b store

# Check if lap is 20
not10:
cmpwi r0, 0xE1
bnelr+
lis r5, 0xC307

# Get root pane
store:
lwz r4, 0xBC(r3)

# Go through the linked list in order to find our pane
lwz r4, 0x14(r4)
lwz r4, 0x14(r4)

# Store the value
stw r5, 0x28(r4)
blr
