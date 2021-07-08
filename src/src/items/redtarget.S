.include "asm_setup.S"

.global TargetPosition

# NOTE: The nop instruction skips the check for first place

# Source must be target plus 1
TargetPosition:
addi r3, r25, 1
cmplw r0, r3
beq 0x40
nop
