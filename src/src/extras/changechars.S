.include "asm_setup.S"

.extern CreateScreen, ChangeCharsHook, PushButton_HandleClick, PushButton_Vtable
.extern ScenePtr, CupSelPtr, CharSelPtr, VRPtr, VtablePtr, DCScreenPtr
.global ChangeCharsSetup, ChangeCharsASM, ChangeCharsASM2, ChangeCharsASM3, ChangeCharsData

#################
# Setup Screens #
#################

# Create character select screen
ChangeCharsSetup:
mr r3, r31
li r4, 0x6B
bl CreateScreen

# Create vehicle select screen
mr r3, r31
li r4, 0x6C
bl CreateScreen

# Create drift select screen
mr r3, r31
li r4, 0x6D
bl CreateScreen

# Original instruction
mr r3, r31
b ChangeCharsHook+4

#################
# Screen Hook 1 #
#################

# Null pointer check
ChangeCharsASM:
lis r31, VRPtr@ha
lwz r11, VRPtr@l(r31)
cmpwi r11, 0
beq end

# Check that the screen is the same as the one we're looking for
lwz r11, CupSelPtr@l(r31)
cmpw r11, r30
bne+ end

# Get character select screen and move it over the vr screen
lwz r30, CharSelPtr@l(r31)
stw r11, VRPtr@l(r31)

# Reload character select screen in r11
lwz r11, CharSelPtr@l(r31)

# Get scene pointer
lwz r12, ScenePtr@l(r31)

# Get timer screen -> timer struct
lwz r12, 0x248(r12)
addi r12, r12, 0x6C

# Store timer to character select screen
stw r12, 0x90C(r11)
stw r12, 0x848(r11)

# Could be button flag?
lis r5, 0x100
stw r5, 0xD4(r11)

# Load vehicle select screen
lwz r11, ScenePtr@l(r31)
lwz r11, 0x1B8(r11)

# Store timer to this screen as well
stw r12, 0x6F0(r11)

# Do the same thing for the drift select screen
lwz r11, ScenePtr@l(r31)
lwz r11, 0x1BC(r11)
stw r12, 0x6C4(r11)

# Original instruction
end:
rlwinm r0, r6, 2, 0, 29
blr

#################
# Screen Hook 2 #
#################

# Original instruction
ChangeCharsASM2:
mr r3, r31

# Load 0x8000
lis r12, ScenePtr@ha

# Store pointer to scene
stw r3, ScenePtr@l(r12)

# Store pointer to cup select screen
lwz r11, 0x1C0(r3)
stw r11, CupSelPtr@l(r12)

# Store pointer to character select screen
lwz r11, 0x1B4(r3)
stw r11, CharSelPtr@l(r12)

# Load vr screen -> childInfo -> parent
lwz r11, 0x24C(r3)
lwz r11, 0x24(r11)
lwz r11, 0x8(r11)

# Change instance of drift select screen to the one in the EVA
ori r10, r12, VtablePtr@l
stw r10, 0x1BC(r11)

# Store pointer to disconnection screen
lwz r11, 0x224(r11)
stw r11, DCScreenPtr@l(r12)

# Return
blr

#############
# Weird ASM #
#############

# WTF!
ChangeCharsASM3:
li r12, 1
lis r11, VRPtr@ha
stw r12, VRPtr@l(r11)
b PushButton_HandleClick

########
# Data #
########

ChangeCharsData:
.long PushButton_Vtable, 0, 0, 0xFFFFFFFF, ChangeCharsASM3
