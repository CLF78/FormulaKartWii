###############################
# Banana Invincibility Frames #
###############################
#INJECT 80573188, 8056E338, 80572B08, 805611E0

.set InvFramesOn, 0x800001F0

# Change damage to 1
li r3, 1

# Also store 1 to InvFramesOn
lis r4, InvFramesOn@ha
stb r3, InvFramesOn@l(r4)
#ENDCODE

############################
# FIB Invincibility Frames #
############################
#INJECT 805733A4, 8056E554, 80572D24, 805613FC

.set InvFramesOn, 0x800001F0

# Original instruction
mr r3, r31

# Store 1 to InvFramesOn
li r31, 1
lis r30, InvFramesOn@ha
stb r31, InvFramesOn@l(r30)
#ENDCODE

##############################
# Shell Invincibility Frames #
##############################
#INJECT 805731A8, 8056E358, 80572B28, 80561200

.set InvFramesOn, 0x800001F0

# Original instruction
li r3, 2

# Store 1 to InvFramesOn
li r4, 1
lis r5, InvFramesOn@ha
stb r4, InvFramesOn@l(r5)
#ENDCODE

##############################
# Shock Invincibility Frames #
##############################
#INJECT 805808A4, 8057A040, 80580224, 8056E8FC

.set InvFramesOn, 0x800001F0

# Original instruction
li r4, 0xA

# Store 1 to InvFramesOn
li r3, 1
lis r5, InvFramesOn@ha
stb r3, InvFramesOn@l(r5)
#ENDCODE

############################
# POW Invincibility Frames #
############################
#INJECT 805811A4, 8057A940, 80580B24, 8056F1FC

.set InvFramesOn, 0x800001F0

# Original instruction
li r4, 0xB

# Store 1 to InvFramesOn
li r5, 1
lis r6, InvFramesOn@ha
stb r5, InvFramesOn@l(r6)

#######################################
# Blue/Bomb Explosion Damage Type Mod #
#######################################
#ENDCODE

#SETTYPE COMPILED
#SETREGION P
045731C0 38600001
045731D8 38600001
#ENDCODE

#SETREGION U
0456E370 38600001
0456E388 38600001
#ENDCODE

#SETREGION J
04572B40 38600001
04572B58 38600001
#ENDCODE

#SETREGION K
04561218 38600001
04561230 38600001
#ENDCODE

##################
# Skip InvFrames #
##################
#SETTYPE C2D2
#INJECT 80567794, 80563414, 80567114, 805557EC

.set InvFramesOn, 0x800001F0

# Original instruction
lwz r5, 0x1C(r21)

# Load InvFrames
lis r3, InvFramesOn@h
ori r3, r3, InvFramesOn@l
lbz r4, 0(r3)

# Check that InvFrames is off
cmpwi r4, 0
beq+ end

# Otherwise set r5 to -1 to remove invincibility frames
li r5, -1

# Store 0 to InvFramesOn
end:
li r4, 0
stb r4, 0(r3)
#ENDCODE

##############
# Camera Fix #
##############
#INJECT 805A22C4, 8059728C, 805A1C44, 8059031C

.set InvFramesOn, 0x800001F0

# Only execute is InvFrames is off
lis r4, InvFramesOn@ha
lbz r4, InvFramesOn@l(r4)
cmpwi r4, 1
beq end

lhz r0, 0x334(r29)

end:
#ENDCODE
