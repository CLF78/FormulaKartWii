.include "asm_setup.S"

.extern CreateEffect, DestroyEffect
.global SMTCreateSparks, SMTDestroySparks

# Push the stack and back up important registers
SMTCreateSparks:
stwu sp, -0x30(sp)
mflr r0
stw r0, 0x34(sp)
stmw r25, 0x14(sp)

# Store values into free registers
mr r25, r3
mr r26, r4
mr r27, r5
mr r28, r6
mr r29, r7
mr r30, r8
mr r31, r9

# Check if we're in the SMT drift state
lwz r10, 0x118(r3)
lwz r10, 0x0(r10)
lwz r10, 0x28(r10)
lha r0, 0xFC(r10)
cmpwi r0, 3
bne createDefaultbike

# Load the orange sparks
lwz r4, 0xAE8(r25)
li r5, 2
li r6, 4
# Check if it's the right sparks and set values if so
cmpwi r27, 3
beq createRightBike
li r5, 0
li r6, 2

createRightBike:
bl CreateEffect

# Destroy the blue sparks
mr r3, r25
mr r4, r26
mr r5, r27
mr r6, r28
mr r7, r29
mr r8, r30
mr r9, r31
bl DestroyEffect
b createEndBike

# Move the values back to appropriate registers and create them
createDefaultbike:
mr r3, r25
mr r4, r26
mr r5, r27
mr r6, r28
mr r7, r29
mr r8, r30
mr r9, r31
bl CreateEffect

# Pop the stack
createEndBike:
lmw r25, 0x14(sp)
lwz r0, 0x34(sp)
mtlr r0
addi sp, sp, 0x30
blr

# Push the stack and back up important registers
SMTDestroySparks:
stwu sp, -0x30(sp)
mflr r0
stw r0, 0x34(sp)
stmw r25, 0x14(sp)

# Store values into free registers
mr r25, r3
mr r26, r4
mr r27, r5
mr r28, r6
mr r29, r7
mr r30, r8
mr r31, r9

# Load the orange sparks
lwz r4, 0xAE8(r25)
li r5, 2
li r6, 4
# Check if it's the right sparks and set values if so
cmpwi r27, 3
beq destroyRightBike
li r5, 0
li r6, 2

# Destroy the orange sparks
destroyRightBike:
bl DestroyEffect

# Destroy the blue sparks
mr r3, r25
mr r4, r26
mr r5, r27
mr r6, r28
mr r7, r29
mr r8, r30
mr r9, r31
bl DestroyEffect

# branch to createEndBike as it's the same
b createEndBike