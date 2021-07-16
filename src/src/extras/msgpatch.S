.include "asm_setup.S"

.extern GetSceneHolderThing, LoadArchive, AddFileToList, ArchiveRoot, MSGPatchHook, GameMode
.global MSGPatch, MSGPatch3, MSGPatch4

# Original instruction
MSGPatch:
bctrl

# Get SceneHolder thing
bl GetSceneHolderThing

# Load archive
lwz r5, 0x18D8(r3)
lis r3, ArchiveRoot@ha
lwz r3, ArchiveRoot@l(r3)
li r4, 0
li r6, 0
bl LoadArchive

# Add archive to linked list
mr r4, r3
mr r3, r31
li r5, 0
bl AddFileToList

# Return
b MSGPatchHook+4

# Store BMG ID of Game Mode
MSGPatch3:
lis r5, GameMode@ha
lbz r5, GameMode@l(r5)
addi r5, r5, 1436
stw r5, 0x80(r1)

# Original instruction
addi r5, r1, 0x58
blr

# Store BMG ID of Game Mode
MSGPatch4:
lis r5, GameMode@ha
lbz r5, GameMode@l(r5)
addi r5, r5, 1436
stw r5, 0x78(r1)

# Modified original instruction
li r4, 0x5A1
blr
