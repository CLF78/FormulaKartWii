.include "asm_setup.S"

.extern LocalIDHook, USERIDHook, RegionByte, Menudata
.global LocalRegionID, USERRegionID, LineColors, 

LocalRegionID:
lis r4, RegionByte@ha
lbz r4, RegionByte@l(r4)
b LocalIDHook+0x4

USERRegionID:
lis r3, RegionByte@ha
lbz r0, RegionByte@l(r3)
b USERIDHook+0x4

LineColors:
lis r12, Menudata@ha
lwz r12, Menudata@l(r12)
lwz r12, 0x98(r12)
rlwinm r0, r30, 2, 22, 29
add r12, r12, r0
lwz r12, 0x38C(r12)
subi r12, r12, 7
cmplwi r12, 3
bgt vanillaRegion
slwi r12, r12, 2
lis r4, ColorCodes@h
ori r4, r4, ColorCodes@l
lwzx r6, r4, r12
stw r6, 0x10(sp)
stw r6, 0x2C(sp)
vanillaRegion:
lwz r28, 0x2C(sp)
blr
ColorCodes:
.long 0x000000FF
.long 0xFF7F00FF
.long 0x00FFFFFF
.long 0x7F00FFFF
.align 2