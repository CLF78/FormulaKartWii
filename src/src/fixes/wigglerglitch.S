.include "asm_setup.S"

.global DisableWigglerGlitch

# Copy current position to previous position
DisableWigglerGlitch:
lfs f0, 0x30(r30)
stfs f0, 0xF4(r30)
lfs f0, 0x34(r30)
stfs f0, 0xF8(r30)
lfs f0, 0x38(r30)
stfs f0, 0xFC(r30)

# Original instruction
lfs f0, 0x14(r1)
blr
