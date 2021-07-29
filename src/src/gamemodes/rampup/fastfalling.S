.include "asm_setup.S"

.extern EnableRampUpStuff, PlayerGetControllerHolder, FastFallingHook, FastFallingHook2, FeatherArray
.global FastFalling, FastFalling2

##################################
# Fast Falling - Vehicle Gravity #
##################################

# Original instruction
FastFalling:
lfs f0, 0x4C(r31)

# Get playerPointers
lwz r12, 0(r29)

# Check if player is in a Feather
lwz r11, 0x4(r12)
lwz r11, 0x78(r11)
cmpwi r11, 7
beq doFastFall

# Get player id
lwz r12, 0(r12)
lbz r12, 0x10(r12)

# Check if fast falling is enabled
lis r11, EnableRampUpStuff@h
ori r11, r11, EnableRampUpStuff@l
lbzx r11, r11, r12
cmpwi r11, 1
bne+ return

# Do BL trick
doFastFall:
bl trick

.float 0.3
.float 1.0

trick:
mflr r12

# Save r4
mr r11, r4

# Get playerSub -> playerSub1c -> airtime
lwz r3, 0x1C(r29)
lwz r4, 0x1C(r3)

# Check if airtime < 2
cmpwi r4, 1
ble end

# Check if hopping
lbz r8, 0x96(r3)
cmpwi r8, 1
bne notHopping

# Check if airtime < 19
cmpwi r4, 18
ble end

# Get the player's controllerHolder
notHopping:
lwz r3, 0x18(r3)
bl PlayerGetControllerHolder

# Get controllerHolder -> currentInputState.stickY
lfs f2, 0x34(r3)

# stickY *= (stickY <= 0.0) ? 0.0 : 2.0
fabs f3, f2
fadds f2, f2, f3

# gravitySpeed = (stickY * 0.3) + 1.0
lfs f3, 0(r12)
lfs f4, 0x4(r12)
fmadds f2, f2, f3, f4
fmuls f0, f0, f2

# Restore registers
end:
mr r4, r11
mr r3, r30

return:
b FastFallingHook+4

################################
# Fast Falling - Wheel Gravity #
################################

# Get playerPointers
FastFalling2:
lwz r3, 0(r28)

# Check if player is in a Feather
lwz r12, 0x4(r3)
lwz r12, 0x78(r12)
cmpwi r12, 7

# Get player id
lwz r3, 0(r3)
lbz r3, 0x10(r3)

# Check if fast falling is enabled
lis r12, EnableRampUpStuff@h
ori r12, r12, EnableRampUpStuff@l
lbzx r12, r12, r3
cmpwi r12, 1
bne+ end2

# Do BL trick
doFastFall2:
bl trick2

.float 0.3
.float 1.0

trick2:
mflr r12

# Get playerSub -> playerSub1c -> airtime
lwz r3, 0x1C(r28)
lwz r4, 0x1C(r3)

# Check if airtime is 0
cmpwi r4, 0
bne notFirstFrame

# Store 0 to thing
li r8, 0
stb r8, 0x96(r3)

# Check if player is hopping
lwz r8, 0x4(r3)
rlwinm. r8, r8, 0, 24, 24
beq notPressingHopButton

# Store 1 to thing if so
li r8, 1
stb r8, 0x96(r3)

# Check if airtime < 2
notFirstFrame:
notPressingHopButton:
cmpwi r4, 1
ble end2

# Check if thing is 1
lbz r8, 0x96(r3)
cmpwi r8, 1
bne notHopping2

# Check if airtime < 19
cmpwi r4, 18
ble end2

# Get the player's controllerHolder
notHopping2:
lwz r3, 0x18(r3)
bl PlayerGetControllerHolder

# Get controllerHolder -> currentInputState.stickY
lfs f2, 0x34(r3)

# stickY *= (stickY <= 0.0) ? 0.0 : 2.0
fabs f3, f2
fadds f2, f2, f3

# gravitySpeed = (stickY * 0.3) + 1.0
lfs f3, 0(r12)
lfs f4, 0x4(r12)
fmadds f2, f2, f3, f4
fmuls f0, f0, f2

# Original instruction
end2:
mr r3, r28
b FastFallingHook2+4
