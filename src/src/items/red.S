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
lis r4, PlayerHolder@ha
lwz r4, PlayerHolder@l(r4)
lwz r4, 0x20(r4)
lwzx r4, r4, r3
lwz r4, 0x44(r4)

# Get their multiplier and multiply speed
lfs f2, 0x10(r4)
fmuls f1, f1, f2

# Original instruction
mr r3, r31
blr
