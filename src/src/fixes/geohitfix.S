.include "asm_setup.S"

.global GeoHitTableKartFix

# Load pointer to data
GeoHitTableKartFix:
lwz r3, 0x24(r30)

# Store damage 0xB to FlamePole_v and FlamePole_v_big
li r4, 0xB
sth r4, 0x974(r3)
sth r4, 0x99C(r3)

# Store damage 0x9 to choropu and choropu2
li r4, 9
sth r4, 0x744(r3)
sth r4, 0x794(r3)

# Original instruction
li r3, 0x14
blr
