###########
# Pillars #
###########
#INJECT 807FEE14, 80845124, 807FE480, 807ED1D4

# Multiply by 16 (CC-independent)
mulli r0, r0, 16
stw r0, 0x108(r31)

# Original instruction
lwz r3, 0(r28)

#ENDCODE

############
# Sandpits #
############
#INJECT 80687028, 80682BA0, 80686694, 806753D0

# Reload word as float
lis r4, 0x4200
stw r4, 0x128(r28)
lfs f1, 0x128(r28)

# Divide
fdivs f0, f0, f1

# Store (original instruction)
stfs f0, 0x128(r28)

###########################
# Sandpit Halfword Hotfix #
###########################
#ENDCODE

#SETTYPE COMPILED
#SETREGION P
006872E8 00000090
0068787C 00000080
#ENDCODE

#SETREGION U
00682E60 00000090
006833F4 00000080
#ENDCODE

#SETREGION J
006872E8 00000090
00686EE8 00000080
#ENDCODE

#SETREGION K
00675690 00000090
00675C24 00000080
#ENDCODE

