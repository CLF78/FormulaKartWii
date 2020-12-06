# Original instruction
lfs f0, 0x184(r4)

# Load the left part of our custom float in f1
lis r5, 0x3FC0
stw r5, 0x184(r3)
lfs f1, 0x184(r3)

# Multiply
fmuls f0, f1, f0

#ENDCODE
