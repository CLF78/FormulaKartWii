.include "asm_setup.S"

.extern DriverStartCheerNetRecv, DriverNetSendCheer
.global DriverCheerR30, DriverCheerR31

DriverCheerR30:
addi r3, r30, 4
mr r4, r31
b DriverCheerMain

DriverCheerR31:
mr r3, r31
addi r4, r30, 4
# fall through

DriverCheerMain:
mflr r0
stwu r1, -0x10(r1)
stw r0, 0x14(r1)
stw r31, 8(r1)
stw r30, 0xC(r1)

mr r31, r3
mr r30, r4 # cheer kart

# argument r3 is overwritten by r4
bl DriverStartCheerNetRecv

# get playerid
lwz r4, 0(r30)
lwz r4, 0(r4)
lbz r4, 0x10(r4)

li r5, 0
mr r3, r31
bl DriverNetSendCheer

mr r3, r31 # restore r3 for call after hook
lwz r31, 8(r1)
lwz r30, 0xC(r1)
lwz r0, 0x14(r1)
addi r1, r1, 0x10
mtlr r0
blr