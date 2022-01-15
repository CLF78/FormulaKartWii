.include "asm_setup.S"

.extern PlayerHolder
.global TargetPosition, RedSpeed

# NOTE: The nop instruction skips the check for first place

# Source must be target plus 1
TargetPosition:
addi r3, r25, 1
cmplw r0, r3
beq 0x40
nop

# Get the player who threw the shell
RedSpeed:
lbz r3, 0x6C(r31)
slwi r3, r3, 2

# Get their playerSub10
lis r5, PlayerHolder@ha
lwz r5, PlayerHolder@l(r5)
lwz r5, 0x20(r5)
lwzx r5, r5, r3
lwz r5, 0x44(r5)

# Get their multiplier and multiply speed
lfs f2, 0x10(r5)
fmuls f1, f1, f2

# Original instruction
mr r3, r31
blr
