.include "asm_setup.S"

.global NoInvFrames

# Original instruction
NoInvFrames:
lwz r5, 0x1C(r21)

# Get prevpid and store the new one
lbz r3, 0xCE(r21)
stb r25, 0xCE(r21)

# Begin switch case
cmplwi r22, 0x11
bgt removeInvFrames

# Call different subroutine depending on new damage
lis r4, SwitchTable@h
ori r4, r4, SwitchTable@l
slwi r6, r22, 2
lwzx r4, r6, r4
mtctr r4
bctr

# Case 2 - 1
# Disable invincibility frames unless the previous damage is explosion
case2:
subi r6, r5, 7
cmplwi r6, 1
bgt removeInvFrames
blr

# Case 3 - 3, 4, 5, 6
# Disable invincibility frames if previous damage is different or was given by a different player
case3:
cmpw r22, r5
bne removeInvFrames
cmpw r25, r3
bne removeInvFrames
blr

# Case 4 - 7, 8
# Disable invincibility frames if previous damage is different or if alternate camera angle is off
case4:
cmpw r22, r5
beqlr

# Snippet copied from tZ
lwz r4, 0(r21)
lwz r4, 0x24(r4)
cmpwi r4, 0
beq removeInvFrames
lhz r3, 0x334(r4)
rlwinm. r3, r3, 0, 31, 31
beqlr

# Case 1 - 0, 2, 9, a, c, e, 10, 11
# Disable invincibility frames unconditionally
removeInvFrames:
case1:
li r5, -1
blr

# Case 5 - b, f
# Disable invincibility frames if previous damage is different
case5:
cmpw r22, r5
bne removeInvFrames
blr

SwitchTable:
.long case1
.long case2
.long case1
.long case3
.long case3
.long case3
.long case3
.long case4
.long case4
.long case1
.long case1
.long case5
.long case1
.long case1
.long case1
.long case5
.long case1
.long case1
