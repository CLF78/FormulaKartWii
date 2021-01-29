##########################
# Drift Speed Decrease 1 #
##########################
#INJECT 8057E128, 805778C4, 8057DAA8, 8056C180

.set FloatOne, 0x800014B0
.set FloatTwo, 0x800001F4

# Load multiplier and floats we need
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
#ENDCODE

##########################
# Drift Speed Decrease 2 #
##########################
#INJECT 8057DF1C, 805776B8, 8057D89C, 8056BF74

.set FloatOne, 0x800014B0
.set FloatTwo, 0x800001F4

# Load multiplier and floats we need
lfs f3, 0x10(r29)
lis r12, FloatOne@ha
lfs f4, FloatOne@l(r12)
lfs f5, FloatTwo@l(r12)

# Drift = Drift - (Multiplier - 1.0) * 0.4
fsubs f4,f3,f4
fneg f4,f4
fmadds f0,f4,f5,f0

# Original instruction
fmuls f0, f0, f1
#ENDCODE

##########################
# Drift Speed Decrease 3 #
##########################
#INJECT 8057E5A8, 80577D44, 8057DF28, 8056C600

.set FloatOne, 0x800014B0
.set FloatTwo, 0x800001F4

# Load multiplier and floats we need
lfs f3, 0x10(r31)
lis r12, FloatOne@ha
lfs f4, FloatOne@l(r12)
lfs f5, FloatTwo@l(r12)

# Drift = Drift - (Multiplier - 1.0) * 0.4
fsubs f4,f3,f4
fneg f4,f4
fmadds f0,f4,f5,f0

# Original instruction
fmuls f0, f0, f1
#ENDCODE

##########################
# Drift Speed Decrease 4 #
##########################
#INJECT 8057EAA4, 80578240, 8057E424, 8056CAFC

.set FloatOne, 0x800014B0
.set FloatTwo, 0x800001F4

# Load multiplier and floats we need
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
#ENDCODE

##########################
# Drift Speed Decrease 5 #
##########################
#INJECT 8057F008, 805787A4, 8057E988, 8056D060

.set FloatOne, 0x800014B0
.set FloatTwo, 0x800001F4

# Load multiplier and floats we need
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
#ENDCODE
