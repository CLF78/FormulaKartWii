.include "asm_setup.S"

.extern SpeedMod1, SpeedMod4, SpeedModifier, SpeedModFloats, SpeedModHalf, KMPinfo
.global SpeedModHook1, SpeedModHook2, SpeedModHook3, SpeedModHook4, SpeedModHook5, SpeedModHook6, SpeedModHook7, SpeedModHook8, SpeedModHook9, SpeedModHook10, SpeedModHook11, SpeedModHook12, SpeedBuffHook

SpeedModHook1:
lfs f0, SpeedModHalf@l(r4)
lis r20, SpeedModifier@ha
lfs f28, SpeedModifier@l(r20)
fmuls f0, f28, f0
fmr f28, f29
li r20, 0
b SpeedMod1+4

SpeedModHook2:
lfs f0, SpeedModHalf@l(r9)
b SpeedApply1

SpeedModHook3:
lfs f0, SpeedModHalf@l+4(r5)
b SpeedApply1

SpeedModHook4:
lfs f0, SpeedModHalf@l+4(r4)
lis r20, SpeedModifier@ha
lfs f28, SpeedModifier@l(r20)
fmuls f0, f28, f0
fmr f28, f29
li r20, 0
b SpeedMod4+4

SpeedModHook5:
lfs f0, 0x108(r30)
b SpeedApply1

SpeedModHook6:
lfs f0, 0x4(r3)
b SpeedApply2

SpeedModHook7:
lfs f0, 0x14(r3)
b SpeedApply2

SpeedModHook8:
lfs f1, 0x24(r3)
b SpeedApply3

SpeedModHook9:
lfs f1, 0x28(r3)
b SpeedApply3

SpeedModHook10:
lfs f1, 0x2C(r3)
b SpeedApply3

SpeedModHook11:
lfs f1, 0x30(r3)
b SpeedApply3

SpeedModHook12:
lfs f1, 0x18(r3)
lis r20, KMPinfo@ha
lwz r20, KMPinfo@l(r20)
lwz r20, 0x3C(r20)
lwz r20, 0x0(r20)
lwz r20, 0x0(r20)
lwz r20, 0x0(r20)
lhz r19, 0xA(r20) # Load float halfword from KMP
rlwinm r19,r19,16,0,15
cmpwi r19, 0
bne .loc_0x30
lis r19, 0x3F80 # Load Default speed if empty

.loc_0x30:
lis r20, SpeedModifier@ha
stw r19, SpeedModifier@l(r20)
lis r19, 0
lfs f28, SpeedModifier@l(r20)
fmuls f1, f28, f1
lis r20, 0x8160
lis r19, 0x42D2
stw r19, 0x4(r20)
lis r19, 0x4296
stw r19, 0x8(r20)
lis r19, 0x4482
stw r19, 0xC(r20)
lis r19, 0x4402
stw r19, 0x10(r20)
lis r19, 0x491C
ori r19, r19, 0x4000
stw r19, 0x14(r20)
lis r19, 0x4302
stw r19, 0x18(r20)
lfs f30, 0x4(r20)
fmuls f30, f28, f30
lis r19, SpeedModFloats@ha
stfs f30, SpeedModFloats@l(r19)
lfs f30, 0x8(r20)
fmuls f30, f28, f30
stfs f30, SpeedModFloats@l-0x310(r19)
lfs f30, 0xC(r20)
fmuls f30, f28, f30
stfs f30, SpeedModFloats@l-0x1FC(r19)
lfs f30, 0x10(r20)
fmuls f30, f28, f30
stfs f30, SpeedModFloats@l-0x19C(r19)
lfs f30, 0x14(r20)
fmuls f30, f28, f30
stfs f30, SpeedModFloats@l-0x18C(r19)
lfs f30, 0x18(r20)
fmuls f30, f28, f30
stfs f30, SpeedModFloats@l-0x304(r19)    
fmr f30, f29
lis r19, 0      
fmr f28, f29
li r20, 0
blr

# Setup the multiplier floats
SpeedBuffHook:
lis r12, BuffFloats@h
ori r12, r12, BuffFloats@l
lfs f2, 0x18(r3)

# Check if we're on an outward vehicle
lwz r4, 0x4(r3)
cmpwi r4, 1
bgt noBuff
blt kartBuff
addi r12, r12, 0x4

# Apply the buff
kartBuff:
lfs f1, 0x0(r12)
fmuls f1, f2, f1
stfs f1, 0x18(r3)

# Original Instruction
noBuff:
cmpwi r31, 0
blr

SpeedApply1:
lis r20, SpeedModifier@ha
lfs f28, SpeedModifier@l(r20)
fmuls f0, f28, f0
fmr f28, f29
li r20, 0
blr

SpeedApply2:
lis r20, SpeedModifier@ha
lfs f27, SpeedModifier@l(r20)
fmuls f0, f27, f0
fmr f27, f29
li r20, 0
blr

SpeedApply3:
lis r20, SpeedModifier@ha
lfs f28, SpeedModifier@l(r20)
fmuls f1, f28, f1
fmr f28, f29
li r20, 0
blr

BuffFloats:
.float 1.03
.float 1.05