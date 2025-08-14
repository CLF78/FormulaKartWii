.include "asm_setup.S"

.extern PlayerModels
.global AirFIBs

AirFIBs:
lwz		r11, 0x10  (r3)
cmpwi	r11, 0
bne		resetPoof

# Get Player Model
lis		r12, PlayerModels@ha
lwz		r12, PlayerModels@l (r12)
lbz		r11, 0x6c(r3) 
rlwinm	r11, r11, 0x2, 0x16, 0x1d
add		r12, r11, r12
lwz		r12, 0x10 (r12)

lwz		r12, 0 (r12)
lwz		r12, 4 (r12)
lwz		r12, 0x1C (r12)
cmpwi	r12, 3
blt		end

lwz		r11, 0x78 (r3)
ori		r11, r11, 8
stw		r11, 0x78 (r3)
stw		r11, 0x10 (r3)

# Prevent Poofing
resetPoof:
sth		r0, 0x15E (r3)

fsubs	f1, f1, f1
fmr		f2, f1

end:
lfs		f3, 0 (r4)
blr