.include "asm_setup.S"

.global SquishCheck, SquishDmg, SquishDmg2

# r24 = in a mega
# r23 = other in a mega
# r6 = bitfield2
# r7 = otherBitfield2

#####################################################
# Checks to make the player pretend to be in a Mega #
#####################################################
# Hook 8056fd4c
# Check if p1 is crushed
SquishCheck:
rlwinm. r26, r6, 16, 31, 31
bne player2

# Check if p1 is shocked
rlwinm. r26, r6, 25, 31, 31
beq player2

# Check if p2 is not shocked as well
rlwinm. r26, r7, 25, 31, 31
bne end

li r23, 1
b end

# Check if p2 is crushed
player2:
rlwinm. r26, r7, 16, 31, 31
bne end

# Check if p2 is shocked
rlwinm. r26, r7, 25, 31, 31
beq end

# Check if p1 is not shocked as well
rlwinm. r26, r6, 25, 31, 31
bne end

li r24, 1

# Restore cr0 and execute original instruction
end:
cmpwi r27, 0
rlwinm r26, r3, 1, 31, 31
blr

#######################
# Damage Change Hooks #
#######################

# Hook 8057042c
# Grab PlayerPointers and call sub
SquishDmg:
lwz r5, 0(r31)
b SquishDmgSub

# Hook 805705bc
# Grab PlayerPointers and call sub
SquishDmg2:
lwz r5, 0x4(r30)
b SquishDmgSub

####################################
# Subroutine for the above methods #
####################################

# Original instruction
SquishDmgSub:
li r4, 0xD

# Get if the other player is in a Mega
lwz r5, 0x4(r5)
lwz r5, 0xC(r5)
rlwinm. r5, r5, 17, 31, 31
bnelr+

# Replace damage
li r4, 0x10
blr
