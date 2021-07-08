.include "asm_setup.S"

.extern SpeedoUpdateASM, RandomInstance, RandomRefresh
.global GameModeMaster

# Original instruction
GameModeMaster:
stw r0, 0x48(r29)

# Refresh random seed
lis r3, RandomInstance@h
ori r3, r3, RandomInstance@l
bl RandomRefresh

# Update speedometer (will be handled automatically by the function)
bl SpeedoUpdateASM

# Return
end:
b TimerManagerHook+4
