.include "asm_setup.S"

.extern GetFile, Racedata, ArchiveRoot, new_a, GetResMdl, GetResMat, MatPointer

.global SherbetFix, HeyhoFix, RidgeFix, RidgeMatFix

# Push the stack
SherbetFix:
stwu sp, -0x20(sp)
mflr r0
stw r0, 0x24(sp)
stmw r29, 0x14(sp)

# Move r3 and r4 for later use
mr r29, r3
mr r30, r4

# Check if we're on N64 Sherbet Land
lis r5, Racedata@ha
lwz r3, Racedata@l(r5)
lwz r0, 0xB68(r3)
cmpwi r0, 27
bne notSherbet

# Attempt to grab "ice.brres"
lis r3, ArchiveRoot@ha
lwz r3, ArchiveRoot@l(r3)
lis r5, IceString@h
ori r5, r5, IceString@l
li r4, 1
li r6, 0
bl GetFile

# Check if null
li r31, 1
cmpwi r3, 0
bne iceExists

notSherbet:
li 31, 0

iceExists:
stb r31, 0x151(r29)
mr r3, r30

# Get vehicle type as normal
lwz r3, 0(r3)
lwz r3, 0(r3)
lwz r3, 0x14(r3)
lwz r3, 0(r3)
lwz r3, 0x4(r3)

# Pop the stack
lmw r29, 0x14(sp)
lwz r0, 0x24(sp)
mtlr r0
addi sp, sp, 0x20
blr


# Push the stack
HeyhoFix:
stwu sp, -0x10(sp)
mflr r0
stw r0, 0x14(sp)
stw r31, 0xC(sp)
mr r31, r3

# Attempt to grab "HeyhoShipGBA.brres"
lis r3, ArchiveRoot@ha
lwz r3, ArchiveRoot@l(r3)
lis r5, HeyhoString@h
ori r5, r5, HeyhoString@l
li r4, 1
li r6, 0
bl GetFile

# Check if null
cmpwi r3, 0
beq HeyhoNull

# Allocate as normal
mr r3, r31
bl new_a

# Pop the stack
HeyhoNull:
lwz r31, 0xC(sp)
lwz r0, 0x14(sp)
mtlr r0
addi sp, sp, 0x10
blr


# Push the stack
RidgeFix:
stwu sp, -0x10(sp)
mflr r0
stw r0, 0x14(sp)
stw r31, 0xC(sp)
stw r30, 0x8(sp)
mr r30, r3

# Attempt to grab "K_car_body.brres"
lis r3, ArchiveRoot@ha
lwz r31, ArchiveRoot@l(r3)
lis r5, RidgeCarString@h
ori r5, r5, RidgeCarString@l
li r4, 1
li r6, 0
mr r3, r31
bl GetFile

# Check if null
cmpwi r3, 0
beq RidgeNull

# Attempt to grab "K_truck.brres"
mr r3, r31
lis r5, RidgeTruckString@h
ori r5, r5, RidgeTruckString@l
li r4, 1
li r6, 0
bl GetFile

# Check if null
cmpwi r3, 0
beq RidgeNull

# Allocate as normal
mr r3, r30
bl new_a

# Pop the stack
RidgeNull:
lwz r30, 0x8(sp)
lwz r31, 0xC(sp)
lwz r0, 0x14(sp)
mtlr r0
addi sp, sp, 0x10
blr

# Push the stack
RidgeMatFix:
stwu sp, -0x20(sp)
mflr r0
stw r0, 0x24(sp)
stw r31, 0x1C(sp)
stw r30, 0x18(sp)

# Check if we're on Moonview Highway
lwz r0, 0xB68(r3)
cmpwi r0, 10
li r3, 0
bne RidgeMatNull

# Grab "course_model.brres"
lis r3, ArchiveRoot@ha
lwz r3, ArchiveRoot@l(r3)
lis r5, CourseModel@h
ori r5, r5, CourseModel@l
li r4, 1
li r6, 0
bl GetFile

# Grab the mdl0
stw r3, 0xC(sp)
lis r4, Course@h
ori r4, r4, Course@l
addi r3, sp, 0xC
bl GetResMdl

# Grab the material names
stw r3, 0x8(sp)
lis r31, MatPointer@h
ori r31, r31, MatPointer@l
li r30, 0

matLoop:
lwz r4, 0(r31)
addi r3, sp, 8
bl GetResMat

# Check if null
cmpwi r3, 0
beq RidgeMatNull

# Loop through each material for safety
addi r30, r30, 1
addi r31, r31, 4
cmpwi r30, 12
blt+ matLoop

# Return non zero if safe
li r3, 1

# Pop the stack
RidgeMatNull:
lwz r30, 0x18(sp)
lwz r31, 0x1C(sp)
lwz r0, 0x24(sp)
mtlr r0
addi sp, sp, 0x20
blr

IceString:
.string "ice.brres"
.align 2

HeyhoString:
.string "HeyhoShipGBA.brres"
.align 2

RidgeCarString:
.string "K_car_body.brres"
.align 2

RidgeTruckString:
.string "K_truck.brres"
.align 2

CourseModel:
.string "course_model.brres"
.align 2

Course:
.string "course"
.align 2