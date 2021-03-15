.include "asm_setup.S"

.global GameModeMaster

GameModeMaster:

# 30 FPS
bl ThirtyFPS

# Return
b TimerManagerHook+4
