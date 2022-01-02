.include "asm_setup.S"

.extern ItemBoxFix3Hook
.global ItemBoxFix3

# Get current route point and check if it's less than 4
ItemBoxFix3:
lwz r3, 0x20(r31)
lha r3, 0x46(r3)
cmpwi r3, 3
ble end

# If not skip a few function calls so the itembox can respawn
b ItemBoxFix3Hook+0x2C

# If yes execute original instruction and resume normal function flow
end:
lwz r12, 0(r31)
b ItemBoxFix3Hook+4
