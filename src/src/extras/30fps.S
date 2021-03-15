.include "asm_setup.S"

.extern Framerate, FramerateHook, FramerateHook2
.global ThirtyFPS

ThirtyFPS:
lis r31, Framerate@ha
lbz r31, Framerate@l(r31)
cmpwi r31, 1
bnelr+

do30FPS:
li r30, 2
lis r29, FramerateHook@ha
stb r30, FramerateHook@l(r29)
lis r29, FramerateHook2@ha
stb r30, FramerateHook2@l(r29)
blr
