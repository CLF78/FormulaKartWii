.include "asm_setup.S"

.extern isUMT, UpdateBoost, UMTMultiplier, CreateEffect, DestroyEffect, HandleBase, GetFile, HoldSound, DetailPlay, DetailHold, ArchiveRoot
.global CreateUMTHook, BuffUMTHook, UMTMultHook, DriftStateHook, UMTCreateSparks, UMTDestroySparks, UMTBoostSetup, UMTMatrix, UMTFade, UMTSoundHook

# Check if 550 frames have passed for the UMT state
CreateUMTHook:

# Setup tiers based on vehicle Type
lwz r12, 0(r3)
lwz r12, 0(r12)
lwz r12, 0x14(r12)
lwz r12, 0(r12)
lwz r12, 4(r12)
cmplwi r12, 1
lha r12, 0x100(r3)
bgt createUMTEnd
beq outwardbike
cmpwi r12, 550
li r11, 4
bge storeDriftState

# If not, check if 300 frames have passed for the SMT state
outwardbike:
cmpwi r12, 300
li r11, 3
blt createUMTEnd

# Store our drift state
storeDriftState:
sth r11, 0xFC(r3)

createUMTEnd:
blr

# Grab Our PlayerID, alongside our mt stat and the drift state
BuffUMTHook:
lwz r4, 0(r3)
lwz r4, 0(r4)
lwz r5, 0x14(r4)
lwz r5, 0(r5)
lbz r4, 0x10(r4)
lha r6, 0xFC(r3)
lwz r3, 0x6C(r5)

# Set up our UMT state
lis r7, isUMT@h
ori r7, r7, isUMT@l

# Check if we released a UMT
cmpwi r6, 4
bne notUMT

#store a byte if it was a UMT for later
li r6, 1
stbx r6, r7, r4

# Check if we're in the UMT state
notUMT:
lbzx r6, r7, r4
cmpwi r6, 1
bne buffEnd

# Make the Miniturbo last 1.5x longer
slwi r6, r3, 2
sub r6, r6, r3
srwi r3, r6, 1

buffEnd:
blr

# Original instruction
UMTMultHook:
bl UpdateBoost

# Grab Our PlayerID and setup UMT state
lwz r4, 0(r28)
lwz r4, 0(r4)
lbz r4, 0x10(r4)
lis r12, isUMT@h
ori r12, r12, isUMT@l

# Check if we are boosting
cmpwi r3, 0
bne isBoosting
li r5, 0
stbx r5, r12, r4

# Check if the multiplier is valid before continuing
isBoosting:
lfs f1, 0x11C(r28)
lis r5, umtFloats@ha 
lfs f0, umtFloats@l(r5)
fcmpu cr0, f0, f1
beq validMult
lfs f0, umtFloats@l+0x4(r5)
fcmpu cr0, f0, f1
bne multEnd

validMult:
# Check if we're in the umt state
lbzx r5, r12, r4
cmpwi r5, 0
beq normalMult

# Load UMT multiplier if true
lis r5, umtFloats@ha 
lfs f0, umtFloats@l(r5)
b storeMult

# Load normal multiplier if not
normalMult:
lis r5, umtFloats@ha 
lfs f0, umtFloats@l+0x4(r5)

storeMult:
stfs f0, 0x11C(r28)

multEnd:
b UMTMultiplier + 0x4

DriftStateHook:
lwz r3, 0(r3)
lwz r3, 0x28(r3)
lha r3, 0xFC(r3)

# Check if we are in the UMT state
cmpwi r3, 4
bne stateEnd
li r3, 3

stateEnd:
blr

# Push the stack and back up important registers
UMTCreateSparks:
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

# Check if we're in the UMT drift state
lwz r10, 0x118(r3)
lwz r10, 0x0(r10)
lwz r10, 0x28(r10)
lha r0, 0xFC(r10)
cmpwi r0, 4
bne createDefault

# Load the purple sparks
lwz r4, 0xAE8(r25)
li r5, 0
li r6, 2
# Check if it's the right sparks and set values if so
cmpwi r27, 6
beq createLeft
addi r5, r5, 2
addi r6, r6, 2

createLeft:
bl CreateEffect

# Destroy the orange sparks
mr r3, r25
mr r4, r26
mr r5, r27
mr r6, r28
mr r7, r29
mr r8, r30
mr r9, r31
bl DestroyEffect
b createEnd

# Move the values back to appropriate registers and create them
createDefault:
mr r3, r25
mr r4, r26
mr r5, r27
mr r6, r28
mr r7, r29
mr r8, r30
mr r9, r31
bl CreateEffect

# Pop the stack
createEnd:
lmw r25, 0x14(sp)
lwz r0, 0x34(sp)
mtlr r0
addi sp, sp, 0x30
blr

# Push the stack and back up important registers
UMTDestroySparks:
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

# Load the purple sparks
lwz r4, 0xAE8(r25)
li r5, 0
li r6, 2
# Check if it's the right sparks and set values if so
cmpwi r27, 6
beq destroyLeft
addi r5, r5, 2
addi r6, r6, 2

# Destroy the purple sparks
destroyLeft:
bl DestroyEffect

# Destroy the orange sparks
mr r3, r25
mr r4, r26
mr r5, r27
mr r6, r28
mr r7, r29
mr r8, r30
mr r9, r31
bl DestroyEffect

# branch to createEnd as it's the same
b createEnd

# Check if we are in the UMT state
UMTBoostSetup:
lis r4, isUMT@h
ori r4, r4, isUMT@l
lbz r0, 0x12E(r30)
lbzx r0, r4, r0
cmpwi r0, 0
beq setupNormal

# Bunch of bit shifts to setup the loop index
rlwinm r3, r29, 0, 24, 31
rlwinm r0, r29, 30, 0, 1
rlwinm r3, r3, 1, 31, 31
lwz r4, 0xAE8 (r30)
sub r0, r0, r3
rlwinm r0, r0, 2, 0, 31
add r3, r0, r3
addi r0, r3, 4
rlwinm r0, r0, 2, 0, 29
lwzx r3, r4, r0

setupNormal:
lwz r12, 0x0(r3)
lwz r12, 0xC(r12)
mtctr r12
bctr

UMTMatrix:
  stwu      r1, -0x20(r1)
  mflr      r0
  stw       r0, 0x24(r1)
  stw       r31, 0x1C(r1)
  mr        r31, r4
  stw       r30, 0x18(r1)
  stw       r29, 0x14(r1)
  stw       r28, 0x10(r1)
  mr        r28, r3
  addi      r3, r3, 0x74
  bl        HandleBase
  cmpwi     r3, 0
  beq-      .loc_0x60
  lwz       r12, 0x0(r28)
  mr        r3, r28
  mr        r4, r31
  lwz       r12, 0x78(r12)
  mtctr     r12
  bctrl     
  lwz       r12, 0x0(r28)
  mr        r3, r28
  lwz       r12, 0x80(r12)
  mtctr     r12
  bctrl     

.loc_0x60:
  lwz       r0, 0x124(r30)
  cmpwi     r0, 0
  bne-      .loc_0xDC
  rlwinm    r3,r29,0,24,31
  rlwinm    r0,r29,30,0,1
  rlwinm    r3,r3,1,31,31
  lwz       r4, 0xAE8(r30)
  sub       r0, r0, r3
  rlwinm    r0,r0,2,0,31
  add       r3, r0, r3
  addi      r0, r3, 0x4
  rlwinm    r0,r0,2,0,29
  lwzx      r28, r4, r0
  addi      r3, r28, 0x74
  bl        HandleBase
  cmpwi     r3, 0
  beq-      .loc_0xDC
  lwz       r12, 0x0(r28)
  mr        r3, r28
  mr        r4, r31
  lwz       r12, 0x78(r12)
  mtctr     r12
  bctrl     
  lwz       r12, 0x0(r28)
  mr        r3, r28
  lwz       r12, 0x80(r12)
  mtctr     r12
  bctrl     

.loc_0xDC:
  lwz       r0, 0x24(r1)
  lwz       r31, 0x1C(r1)
  lwz       r30, 0x18(r1)
  lwz       r29, 0x14(r1)
  lwz       r28, 0x10(r1)
  mtlr      r0
  addi      r1, r1, 0x20
  blr       

UMTFade:
  stwu      r1, -0x10(r1)
  mflr      r0
  stw       r0, 0x14(r1)
  lwz       r12, 0x0(r3)
  lwz       r12, 0x14(r12)
  mtctr     r12
  bctrl     
  lwz       r0, 0x124(r31)
  cmpwi     r0, 0
  bne-      .loc_0x6C
  rlwinm    r3,r30,0,24,31
  rlwinm    r0,r30,30,0,1
  rlwinm    r3,r3,1,31,31
  lwz       r4, 0xAE8(r31)
  sub       r0, r0, r3
  rlwinm    r0,r0,2,0,31
  add       r3, r0, r3
  addi      r0, r3, 0x4
  rlwinm    r0,r0,2,0,29
  lwzx      r3, r4, r0
  lwz       r12, 0x0(r3)
  lwz       r12, 0x14(r12)
  mtctr     r12
  bctrl     

.loc_0x6C:
  lwz       r0, 0x14(r1)
  mtlr      r0
  addi      r1, r1, 0x10
  blr       

# Push the stack
UMTSoundHook:
stwu sp, -0x20(sp)
mflr r0
stw r0, 0x24(sp)
stmw r29, 0x14(sp)

# Move registers for later use
mr r29, r3
mr r30, r4
mr r31, r5

# Check if we are in UMT Drift state
lbz r0, 0xE9(r3)
cmpwi r0, 4
bne playDefault

# Load our custom BRSEQ
lis r5, umtString@h
ori r6, r5, umtString@l+0x10
ori r5, r5, umtString@l
mr r4, r31
li r7, 1
bl LoadExtBRSEQ

# Check if the BRSEQ was found and exit if not
cmpwi r3, 0
beq nullSound

# Restore regular registers and play the drift sound 
playDefault:
mr r3, r29
mr r4, r30
mr r5, r31
bl HoldSound

# Pop the stack
nullSound:
lmw r29, 0x14(sp)
lwz r0, 0x24(sp)
mtlr r0
addi sp, sp, 0x20
blr

# Push the stack
LoadExtBRSEQ:
stwu sp, -0x40(sp)
mflr r0
stw r0, 0x44(sp)
stmw r29, 0x34(sp)

# Setup and check if the file exists
mr r29, r3
mr r30, r4
mr r31, r7
lis r3, ArchiveRoot@ha
lwz r3, ArchiveRoot@l(r3)
li r4, 0
stw r6, 0x24 (sp)
li r6, 0
li r9, 0
ori r0, r9, 0x10
stw r9, 0x20(sp)
stw r0, 0x8(sp)
bl GetFile
cmpwi r3, 0
beq load128

# Check if we hold the sound
cmpwi r31, 0
stw r3, 0x20 (sp)
beq dontHold

# Hold the sound
mr r3, r29
mr r4, r30
addi r6, sp, 8
li r5, 0x19A
bl DetailHold
b soundEnd

# Play the sound
dontHold:
mr r3, r29
mr r4, r30
addi r6, sp, 8
li r5, 0x19A
bl DetailPlay
b soundEnd

# I think this loads a dummy sound?
load128:
li r3, 128

# Pop the stack
soundEnd:
lmw r29, 0x34(sp)
lwz r0, 0x44(sp)
mtlr r0
addi sp, sp, 0x40
blr


umtFloats:
.float 1.32
.float 1.2

umtString:
.string "PurpleMT.brseq"
.align 2
.string "b"
.align 2