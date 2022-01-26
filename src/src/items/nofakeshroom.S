.include "asm_setup.S"

.global NoFakeShroom

# Set condition register 0 to the correct value (cror cr0+eq, cr0+eq, cr7+eq)
NoFakeShroom:
cmpwi r0, 8
cmpwi cr7, r0, 0xD
cror 2, 2, 30
blr
