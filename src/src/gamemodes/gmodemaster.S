.include "asm_setup.S"

.extern SpeedoUpdateASM
.global GameModeMaster

# Original instruction
GameModeMaster:
stw r0, 0x48(r29)

# Update speedometer (will be handled automatically by the function)
bl SpeedoUpdateASM

# Return
end:
b TimerManagerHook+4
