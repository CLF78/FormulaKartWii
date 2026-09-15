.include "asm_setup.S"

.extern snprintf, SystemManager, FilenameEndings, DefaultFileEnding, PatchSZSHook
.global PatchSZS, PatchSZS2

# Get sourceCount and skip if less than 3
PatchSZS:
lhz r0, 0x8(r31)
cmplwi r0, 0x2
ble end

# Set state to 1 to replace name entirely
lwz r3, 0x18(r31)
li r0, 1
stw r0, 0x8(r3)

# Call snprintf
lwz r3, 0x10(r31)
lwz r3, 0x8(r3)
li r4, 0x80
lis r5, PatchFilenameUI@h
ori r5, r5, PatchFilenameUI@l
lis r6, DefaultFileEnding@h
ori r6, r6, DefaultFileEnding@l
bl snprintf

# Get sourceCount and skip if less than 4
lhz r0, 0x8(r31)
cmplwi r0, 0x3
ble end

# Set state to 1 to replace name entirely
lwz r3, 0x18(r31)
li r0, 1
stw r0, 0xC(r3)

# Call snprintf
lwz r3, 0x10(r31)
lwz r3, 0xC(r3)
li r4, 0x80
lis r5, PatchFilenameUI@h
ori r5, r5, PatchFilenameUI@l

# Get ending based on language (will work on all regions)
lis r7, SystemManager@ha
lwz r7, SystemManager@l(r7)
lwz r7, 0x5C(r7)
slwi r7, r7, 2
lis r6, FilenameEndings@h
ori r6, r6, FilenameEndings@l
lwzx r6, r6, r7
bl snprintf

# Original instruction
end:
lwz r0, 0x14(r1)
b PatchSZSHook+4

# Get sourceCount and skip if less than 3
PatchSZS2:
lhz r0, 0x8(r31)
cmplwi r0, 0x2
ble end2

# Set state to 1 to replace name entirely
lwz r3, 0x18(r31)
li r0, 1
stw r0, 0x8(r3)

# Call snprintf
lwz r3, 0x10(r31)
lwz r3, 0x8(r3)
li r4, 0x80
lis r5, PatchFilenameRace@h
ori r5, r5, PatchFilenameRace@l
lis r6, DefaultFileEnding@h
ori r6, r6, DefaultFileEnding@l
bl snprintf

# Original instruction
end2:
lwz r0, 0x14(r1)
b PatchSZSHook+0xC8

PatchFilenameUI:
.string "/Scene/UI/Patch%s"
.align 2

PatchFilenameRace:
.string "/Race/PatchCommon%s"
.align 2
