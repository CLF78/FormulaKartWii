.include "asm_setup.S"

.global GeoHitTableKartFix

# Load pointer to data
GeoHitTableKartFix:
lwz r3, 0x24(r30)

# Load custom damage
li r4, 0xB

# Store it to FlamePole_v and FlamePole_v_big
sth r4, 0x974(r3)
sth r4, 0x99C(r3)

# Original instruction
li r3, 0x14
blr
