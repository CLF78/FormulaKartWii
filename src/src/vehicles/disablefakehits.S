.include "asm_setup.S"

.global DisableFakeHits

DisableFakeHits:
lwz r12, 0xC(r3) # default instruction

lwz r4, 0(r3)
lwz r4, 4(r4)
lwz r4, 0x14(r4)
rlwinm. r4, r4, 0,28,28 # check isNetRecv flag
beqlr

# skip accident function call
mflr r4
addi r4, r4, 0x24
mtlr r4

li r3, 0 # return accident failed

blr