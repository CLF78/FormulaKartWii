.include "asm_setup.S"

.extern DriftFixHook4, DriftFixHook5
.global DriftFixMain, DriftFixSub, DriftFixSub2, DriftFixSub3, DriftFixSub4

###################
# Drift Fix Sub 3 #
###################

DriftFixSub3:
mflr r11
bl DriftFixMain
mtlr r11
b DriftFixHook4+4

###################
# Drift Fix Sub 4 #
###################

DriftFixSub4:
mflr r11
bl DriftFixMain
mtlr r11
b DriftFixHook5+4

###################
# Drift Fix Sub 1 #
###################

DriftFixSub:
mr r3, r29
b DriftFixMain

###################
# Drift Fix Sub 2 #
###################

# No need for b
DriftFixSub2:
mr r3, r31

######################################
# Drift Speed Decrease Main Function #
######################################

# Load multiplier and floats we need
DriftFixMain:
lfs f3, 0x10(r3)
lis r12, FloatOne@ha
lfs f4, FloatOne@l(r12)
lfs f5, FloatTwo@l(r12)

# Drift = Drift - (Multiplier - 1.0) * 0.4
fsubs f4,f3,f4
fneg f4,f4
fmadds f0,f4,f5,f0

# Original instruction
fmuls f0, f0, f1
blr

##########
# Floats #
##########

FloatOne: .float 1.0
FloatTwo: .float 0.4
