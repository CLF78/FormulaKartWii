.include "asm_setup.S"

.global NoFakeShroom, NoFakeShroom2

###########
# Patch 1 #
###########

# Assume replacement to be 0
NoFakeShroom:
li r3, 0

# Original instruction
lwz r0, 0x20(r31)

# Due to the possibility of having two Shock/POWs at once, do the replacement for those items
cmpwi r0, 8
beq doReplacement
cmpwi r0, 0xD
bnelr+

doReplacement:
li r3, 1
blr

###########
# Patch 2 #
###########

NoFakeShroom2:
cmpwi r3, 1
bne+ 20
li r0, 5