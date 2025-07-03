.include "asm_setup.S"

.global AirFIBs

# If our new bit is applied (UNSURE IF THIS BIT IS USED BY ANYTHING - TEST). If bit is set, force no FIB gravity)
# Needed else when we land, FIB no gravity is no longer running, so flag is set to always force it. Can also use padding
AirFIBs:
lwz r11, 0x78 (r3)
andis. r12, r11, 0x8000
bne resetPoof

# If we're in air when throwing the FIB, set our new bit
lwz r12, 0 (r30)
lwz r12, 4 (r12)
lwz r12, 0x1C (r12)
cmpwi r12, 3 # Experiment with it
blt end

# Set new bit
oris r11, r11, 0x8000

# Set "landed" bit (for collision)
ori r11, r11, 8
stw r11, 0x78 (r3)

# Always reset poof timer
resetPoof:
sth r0, 0x15E (r3)

# Set no FIB gravity
noGravity:
fsubs f1, f1, f1
fmr f2, f1

# THE END
end:
lfs f3, 0 (r4)
blr