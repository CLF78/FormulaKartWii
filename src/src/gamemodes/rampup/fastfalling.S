.include "asm_setup.S"

.extern PlayerGetControllerHolder, FastFallingHook, FastFallingHook2
.global FastFalling, FastFalling2

###########################
# Fast Falling Subroutine #
###########################

# Get controllerHolder -> currentInputState.stickY
FastFallSub:
lfs f2, 0x34(r3)

# stickY *= (stickY <= 0.0) ? 0.0 : 2.0
fabs f3, f2
fadds f2, f2, f3

# gravitySpeed = (stickY * 0.3) + 1.0
lis r3, FastFallingFloats@ha
lfs f3, FastFallingFloats@l(r3)
lfs f4, FastFallingFloats@l+4(r3)
fmadds f2, f2, f3, f4
fmuls f0, f0, f2
blr

##################################
# Fast Falling - Vehicle Gravity #
##################################

# Original instruction
FastFalling:
lfs f0, 0x4C(r31)

# Get playerSub1c
lwz r3, 0x1C(r29)

# Check if player is in a jump pad
lwz r11, 0x4(r3)
rlwinm. r11, r11, 2, 31, 31
beq+ rampUp

# Check if player is in a Feather
lwz r11, 0x78(r3)
cmpwi r11, 7
beq checkFastFall

# Get ramp up flag
rampUp:
lwz r11, 0(r29)
bl GetRampUp
beq end

# Get airtime
checkFastFall:
lwz r4, 0x1C(r3)

# Check if airtime < 2
cmpwi r4, 1
ble end

# Check hopping thing
lbz r8, 0x96(r3)
cmpwi r8, 1
bne doFastFall

# Check if airtime < 19
cmpwi r4, 18
ble end

# Get the player's controllerHolder
doFastFall:
mr r3, r29
bl PlayerGetControllerHolder

# Apply physics
bl FastFallSub

# Restore clobbered registers
end:
mr r3, r30
lwz r4, 0x4(r3)
b FastFallingHook+4

################################
# Fast Falling - Wheel Gravity #
################################

# Original instruction
FastFalling2:
lfs f0, 0x4C(r29)

# Get playerSub1c
lwz r3, 0x1C(r28)

# Check if player is in a jump pad
lwz r11, 0x4(r3)
rlwinm. r11, r11, 2, 31, 31
beq+ rampUp2

# Check if the jump pad type is the Feather
lwz r11, 0x78(r3)
cmpwi r11, 7
beq checkFastFall2

# Get ramp up flag
rampUp2:
lwz r11, 0(r28)
bl GetRampUp
beq end2

# Get airtime
checkFastFall2:
lwz r4, 0x1C(r3)

# Check if airtime is 0
cmpwi r4, 0
bne notFirstFrame

# Assume thing is 0
li r8, 0

# Check if player is hopping
lwz r12, 0x4(r12)
rlwinm. r12, r12, 0, 24, 24
beq notPressingHopButton

# Set thing to 1
li r8, 1

# Store thing
notPressingHopButton:
stb r8, 0x96(r3)

# Check if airtime < 2
notFirstFrame:
cmpwi r4, 1
ble end2

# Check if thing is 1
lbz r8, 0x96(r3)
cmpwi r8, 1
bne doFastFall2

# Check if airtime < 19
cmpwi r4, 18
ble end2

# Get the player's controllerHolder
doFastFall2:
lwz r3, 0x18(r3)
bl PlayerGetControllerHolder

# Apply physics
bl FastFallSub

# Return
end2:
b FastFallingHook2+4

FastFallingFloats:
.float 0.3, 1.0
