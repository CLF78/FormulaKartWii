.include "asm_setup.S"

.extern SetPaneColor, ColorFixHook
.global ColorFix, PositionFix1, PositionFix2

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

# Third call
mr r3, r28
bl trick3

.string "lap_leffter"
.align 2

trick3:
mflr r4
li r5, 1
bl SetPaneColor

# Fourth call
mr r3, r28
bl trick4

.string "lap_riightest"
.align 2

trick4:
mflr r4
li r5, 1
bl SetPaneColor

# Original instruction
mr r3, r28
b ColorFixHook+4

##################
# Position Fix 1 #
##################

# Original instruction
PositionFix1:
mr r3, r30

# Check if lap is 2
cmpwi r0, 2
bne+ not2
lis r5, 0xC234
b store

# Check if lap is 10
not2:
cmpwi r0, 10
bne+ not10
lis r5, 0xC28C
b store

# Check if lap is 20
not10:
cmpwi r0, 20
bne+ not20
lis r5, 0xC2B4
b store

# Check if lap is 100
not20:
cmpwi r0, 100
bnelr+
lis r5, 0xC2E6

# Get root pane
store:
lwz r4, 0xBC(r3)

# Go through the linked list in order to find RootPane
lwz r4, 0x14(r4)
lwz r4, 0x0(r4)

# Store the value
stw r5, 0x1044(r4)
blr

##################
# Position Fix 2 #
##################

# Original instruction
PositionFix2:
stb r0, 0x198(r28)

# Check if lap count is < 100
lwz r12, 0x68(r5)
cmpwi r12, 0x64
bgelr

# Get root pane
lwz r30, 0xBC(r28)

# Go through the linked list in order to find RootPane and store the floats
lwz r30, 0x14(r30)
lwz r30, 0x0(r30)
lis r29, 0xC234
stw r29, 0x100(r30)
lis r12, 0x4305
ori r12, r12, 0x1D65
stw r12, 0xC1C(r30)
lis r12, 0x431B
ori r12, r12, 0x8000
stw r12, 0xE30(r30)
blr