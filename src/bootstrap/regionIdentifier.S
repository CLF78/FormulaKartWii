.include "asm_setup.S"

.set CheckAddress, 0x80006208
.set StartFunc, 0x808DD400
.global regionIdentifier, runPayload, funcs, filename, fatalstring

# Load the branch to the main function
regionIdentifier:
lis r4, CheckAddress@ha
lhz r4, CheckAddress@l+2(r4)

# Check if PAL
li r3, 0
cmpwi r4, 0x54A9
beqlr

# Check if NTSC-U
li r3, 1
cmpwi r4, 0x5409
beqlr

# Check if NTSC-J
li r3, 2
cmpwi r4, 0x53CD
beqlr

# Check if NTSC-K
li r3, 3
cmpwi r4, 0x5511
beqlr

# Impossible to detect the region, abort!
halt:
b halt

# Run payload
runPayload:
lis r3, StartFunc@ha
lwz r3, StartFunc@l(r3)
mtctr r3
bctrl

# Pop stack and return - devkitPro is too dumb to do it without invoking restgpr
lwz r0, 0x8C(r1)
lmw r29, 0x7C(r1)
mtlr r0
addi r1, r1, 0x88
blr

# PAL Functions
funcs:
.long 0x801A4EC4
.long 0x80011A2C
.long 0x8015E2BC
.long 0x8015E568
.long 0x8015E834
.byte 'P'
.align 2

# NTSC-U Functions
.long 0x801A4E24
.long 0x80010ECC
.long 0x8015E21C
.long 0x8015E4C8
.long 0x8015E794
.byte 'E'
.align 2

# NTSC-J Functions
.long 0x801A4DE4
.long 0x80011950
.long 0x8015E1DC
.long 0x8015E488
.long 0x8015E754
.byte 'J'
.align 2

# NTSC-K Functions
.long 0x801A5220
.long 0x80011A94
.long 0x8015E334
.long 0x8015E5E0
.long 0x8015E8AC
.byte 'K'
.align 2

filename:
.string "/fkw/FormulaKartWii%c.bin"

fatalstring:
.string "Could not find Formula Kart Wii payload.\nPlease check that your installation is correct."
