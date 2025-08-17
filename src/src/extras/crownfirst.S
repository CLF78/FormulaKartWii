.include "asm_setup.S"

.global CrownMinimap
.extern Racedata

# 1st Place Crown on Minimap - Note that it stores to the custom pane's offsets directly

# Original instruction
CrownMinimap:
lwzx r4, r4, r0

# Set crown pane invisible by default
li r11, 0

# If player is not 1st place, store invisible crown visibility
lbz r12, 0x20 (r4)
cmpwi r12, 1
bne storeCrownVisibility

# Set crown pane visible if player is in 1st
setCrownVisible:
li r11, 1

# Store crown pane visibility
storeCrownVisibility:
lwz r12, 0x1B8 (r28)
stb r11, 0x887 (r12)

# Load character icon opacity and apply it to the crown for transparent CPU crowns
lha r11, 0xB8 (r12)
stb r11, 0x884 (r12)

# THE END
end:
blr