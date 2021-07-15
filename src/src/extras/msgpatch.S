.include "asm_setup.S"

.extern GetSceneHolderThing, LoadArchive, AddFileToList, ArchiveRoot, MSGPatchHook
.global MSGPatch

# Original instruction
MSGPatch:
bctrl

# Get SceneHolder thing
bl GetSceneHolderThing

# Load archive
lwz r5, 0x18D4(r3)
lis r3, ArchiveRoot@ha
lwz r3, ArchiveRoot@l(r3)
li r4, 0
li r6, 0
bl LoadArchive

# Add archive to linked list
mr r4, r3
addi r3, r31, 0xC74
li r5, 0
bl AddFileToList

# Return
b MSGPatchHook+4
