.include "asm_setup.S"

.global HybridDrift2, HybridDrift3, HybridDrift4, HybridDrift5, HybridDrift6

#########################
# Manual Drift Enabling #
#########################

# Load bitfield 0 and check if we're trying to hop/we're already manually drifting
HybridDrift2:
lwz r3, 0x4(r30)
andi. r4, r3, 0x84
beq end

# If so, then clear the auto drift mode bit in bitfield 4
lwz r4, 0x14(r30)
rlwinm r4, r4, 0, 28, 26
stw r4, 0x14(r30)

# And the automatic drift bit in bitfield 0
rlwinm r3, r3, 0, 4, 2
stw r3, 0x4(r30)

# Original instruction
end:
mr r3, r30
blr

##########################
# Manual Drift Disabling #
##########################

# Check if Hybrid Drift is enabled
HybridDrift3:
lwz r0, 0x14(r3)
rlwinm. r12, r0, 0, 18, 18
beq end2

# Set the auto drift mode bit in bitfield 4
ori r0, r0, 0x10
stw r0, 0x14(r3)

# Original instruction
end2:
lwz r0, 0x4(r3)
blr

############################
# Manual Drift Disabling 2 #
############################

# Check if Hybrid Drift is enabled
HybridDrift4:
lwz r0, 0x14(r4)
rlwinm. r12, r0, 0, 18, 18
beq end3

# Set the auto drift mode bit in bitfield 4
ori r0, r0, 0x10
stw r0, 0x14(r4)

# Original instruction
end3:
lwz r0, 0x4(r4)
blr

########################################
# Update Manual Drift if outside drift #
########################################

# Original instruction
HybridDrift5:
lwz r0, 0x14(r3)

# Check if we're an inside drifting bike [, if we are, end the code (Bug is only for outside drift)]
lwz r12, 0(r28)
lwz r12, 0(r12)
lwz r12, 0x14(r12)
lwz r12, 0(r12)
lwz r12, 0x4(r12)
cmpwi r12, 2
beqlr

# Check if we're drifting, if we are, end the code
# lwz r3, 4 (r3)
# andis. r3, r3, 0x1000
# bnelr

# Fix slide issue (Load a dummy value to force the next branch)
li r0, 0
blr

#####################
# Outside Drift Fix #
#####################

# Original instruction
HybridDrift6:
rlwinm. r0, r0, 0x0, 0x1b, 0x1b
bnelr

# If we're on manual, fix our angle
li r0, 0
stw r0, 0x1C8(r3)
blr
