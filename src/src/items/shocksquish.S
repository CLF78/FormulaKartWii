.include "asm_setup.S"

.extern ShockSquishingHook, ShockSquishingCall, ShockSquishingCall2
.global ShockSquishing

# r31 = PlayerSub18 (playerPointers at 0x0)
# r30 = otherPlayer (playerPointers at 0x4)
# r29 = isBattle
# r24 = in a mega
# r23 = other in a mega
# r22 = other crushed
# r21 = crushed
# r20 = in a bullet
# r19 = other in a bullet

##################
# Initial Checks #
##################

# If any player is in a bullet or in a mega, return. Star was already checked by the game itself, so we don't need to
ShockSquishing:
cmpwi r24, 1
beq end
cmpwi r23, 1
beq end
cmpwi r20, 1
beq end
cmpwi r19, 1
beq end

# Initial values for candidates
li r4, 0
li r5, 0

###################
# Player 1 Checks #
###################

# If player is already squished, skip to second player
cmpwi r21, 1
beq processOtherPlayer

# If player is not shocked, process second player to see if he's shocked instead
lwz r3, 0(r31)
lwz r3, 0x4(r3)
lwz r3, 0xC(r3)
rlwinm. r3, r3, 25, 31, 31
beq+ processOtherPlayer

# Player 1 is a candidate for squishing!
li r4, 1

###################
# Player 2 Checks #
###################

# Preload bitfield2 from otherPlayer's sub1c
processOtherPlayer:
lwz r3, 0x4(r30)
lwz r3, 0x4(r3)
lwz r3, 0xC(r3)

# Check if player is to be squished
cmpwi r4, 1
beq playerSquished

# Player 1 not to be squished #

# If otherPlayer is already squished, return
cmpwi r22, 1
beq end

# If otherPlayer is not shocked, return
rlwinm. r3, r3, 25, 31, 31
beq+ end

# Player 2 is a candidate for squishing!
li r5, 1
b squishCheck

# Player 1 to be squished #

# If otherPlayer is also shocked, return
playerSquished:
rlwinm. r3, r3, 25, 31, 31
bne end

##################
# Squish Applier #
##################

# Common value
squishCheck:
lis r11, ShockSquishingCall@h

# Check which player has to be squished and load their unique data
cmpwi r4, 1
bne+ squishCheck2
lwz r3, 0(r31)
lwz r8, 0x4(r30)
ori r11, r11, ShockSquishingCall@l
b applySquish

squishCheck2:
cmpwi r5, 1
bne+ end
lwz r3, 0x4(r30)
lwz r8, 0(r31)
ori r11, r11, ShockSquishingCall2@l

# Setup arguments for the part we skipped
applySquish:

# Player id of opponent
lwz r8, 0(r8)
lbz r8, 0x10(r8)

# Player's sub14 and its vtable
lwz r3, 0x2C(r3)
lwz r12, 0xC(r3)

# Damage type
li r4, 0x10

# Call function (does not return)
mtctr r11
bctr

# Original instruction
end:
cmpwi r24, 0
b ShockSquishingHook+4
