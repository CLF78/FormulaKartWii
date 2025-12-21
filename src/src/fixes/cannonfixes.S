.include "asm_setup.S"

.global CannonStarFix

############
# Star Fix #
############

CannonStarFix:
andi. r11, r0, 0x80
andis. r12, r0, 0x8000
or. r0, r11, r12
blr
