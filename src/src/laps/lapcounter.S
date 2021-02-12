.include "asm_setup.S"

.extern SetPaneColor, ColorFixHook
.global ColorFix

#############
# Color Fix #
#############

# First call
ColorFix:
mr r3, r28
bl trick

.string "lap_lefft"
.align 2

trick:
mflr r4
li r5, 1
bl SetPaneColor

# Second call
mr r3, r28
bl trick2

.string "lap_riighter"
.align 2

trick2:
mflr r4
li r5, 1
bl SetPaneColor

# Original instruction
mr r3, r28
b ColorFixHook+4
