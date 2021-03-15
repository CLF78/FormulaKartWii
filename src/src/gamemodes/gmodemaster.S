.include "asm_setup.S"

.global GameModeMaster

# Original instruction
GameModeMaster:
stw r0, 0x48(r29)

# 30 FPS
bl ThirtyFPS

# Return
b TimerManagerHook+4
