##################
# Skip InvFrames #
##################
#INJECT 80567794, 80563414, 80567114, 805557EC

.set InvFramesOn, 0x800001F0

# Original instruction
lwz r5, 0x1C(r21)

# Check that InvFrames is on
lis r3, InvFramesOn@ha
lbz r3, InvFramesOn@l(r3)
cmpwi r3, 0
beq+ end

# Check if the damage type is explosion
cmpwi r22, 7
beq end

cmpwi r22, 8
beq end

# Otherwise set r5 to -1 to remove invincibility frames
li r5, -1

end:
#ENDCODE

######################
# Enable InvFramesOn #
######################
#INJECT 80572770, 8056D920, 805720F0, 805607C8

.set InvFramesOn, 0x800001F0

# Load InvFramesOn
lis r15, InvFramesOn@ha

# Replace spin type 0 with spin type 1
cmpwi r3, 0
bne+ notBanana
li r3, 1

# Store 1 to InvFramesOn
notBanana:
li r12, 0x1
stb r12, InvFramesOn@l(r15)

#ENDCODE

##############
# Camera Fix #
##############
#INJECT 805A22C4, 8059728C, 805A1C44, 8059031C

.set InvFramesOn, 0x800001F0

# Only execute is InvFrames is off
lis r4, InvFramesOn@ha
lbz r28, InvFramesOn@l(r4)
cmpwi r28, 1
beq end

# Original instruction
lhz r0, 0x334(r29)

end:
li r28, 0
stb r28, InvFramesOn@l(r4)

#ENDCODE
