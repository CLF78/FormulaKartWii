.if (REGION == 'P')
	.set BranchAddress, 0x805EEFBC
.elseif (REGION == 'U')
	.set BranchAddress, 0x805D44E8
.elseif (REGION == 'J')
	.set BranchAddress, 0x805EE898
.elseif (REGION == 'K')
    .set BranchAddress, 0x805ED3DC
.else
    .err
.endif

# Default instruction
stw r4, 0x178 (r3)

# Set 2nd half of instruction (branching offset amount)
li r11, 0x0018

# Check that the button is the Battle one
cmpwi r4, 3
beq skip

# For beq instruction
oris r11, r11, 0x4182
b end

# For b instruction
skip:
oris r11, r11, 0x4800 

# Write in new instruction
end:
lis r5, BranchAddress@ha
stw r11, BranchAddress@l(r5)

#ENDCODE
