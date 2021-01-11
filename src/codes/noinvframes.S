###############################
# Banana Invincibility Frames #
###############################
#INJECT 80573188, 8056E338, 80572B08, 805611E0

.set InvFramesOn, 0x800001B0

# Change damage to 1
li r3, 1

# Also store 1 to InvFramesOn
lis r4, InvFramesOn@h
ori r4, r4, InvFramesOn@l
stbx r3, r24, r4
#ENDCODE

############################
# FIB Invincibility Frames #
############################
#INJECT 805733A4, 8056E554, 80572D24, 805613FC

.set InvFramesOn, 0x800001B0

# Original instruction
mr r3, r31

# Store 1 to InvFramesOn
li r31, 1
lis r30, InvFramesOn@h
ori r30, r30, InvFramesOn@l
stbx r31, r24, r30
#ENDCODE

##############################
# Shell Invincibility Frames #
##############################
#INJECT 805731A8, 8056E358, 80572B28, 80561200

.set InvFramesOn, 0x800001B0

# Original instruction
li r3, 2

# Store 1 to InvFramesOn
li r4, 1
lis r5, InvFramesOn@h
ori r5, r5, InvFramesOn@l
stbx r4, r24, r5
#ENDCODE

#####################
# POW Player ID Fix #
#####################
#INJECT 80581178, 8057A914, 80580AF8, 8056F1D0

rlwinm r0, r3, 0x2, 0x16, 0x1d
mr r11, r3
#ENDCODE

############################
# POW Invincibility Frames #
############################
#INJECT 805811A4, 8057A940, 80580B24, 8056F1FC

.set InvFramesOn, 0x800001B0

# Original instruction
li r4, 0xB

# Store 1 to InvFramesOn
li r5, 1
lis r6, InvFramesOn@h
ori r6, r6, InvFramesOn@l
stbx r5, r11, r6

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

.set InvFramesOn, 0x800001B0

# Original instruction
lwz r5, 0x1C(r21)

# Get Player ID
lwz r7, 0x20(r1)

# Load InvFrames
lis r3, InvFramesOn@h
ori r3, r3, InvFramesOn@l
lbzx r4, r7, r3

# Check that InvFrames is off
cmpwi r4, 0
beq+ end

# Otherwise set r5 to -1 to remove invincibility frames
li r5, -1

# Store 0 to InvFramesOn
li r4, 0
stbx r4, r7, r3

end:
#ENDCODE
