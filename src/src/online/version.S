.include "asm_setup.S"

.extern GuestSendHook, DWCiCheckResvCommand, Version
.global GuestSend, HostCheck

##############
# Guest Send #
##############

# Check if command is reservation
GuestSend:
cmpwi r3, 1
bne+ end

# If so, attach version
lwz r11, 0x14(r7)
lis r12, Version@ha
lbz r12, Version@l(r12)
or r11, r11, r12
stw r11, 0x14(r7)

# Original instruction
end:
stwu r1, -0x570(r1)
b GuestSendHook+4

##############
# Host Check #
##############

# Check the version
HostCheck:
lwz r9, 0x14(r31)
rlwinm r9, r9, 0, 0xFF
lis r12, Version@ha
lbz r12, Version@l(r12)
cmpw r9, r12
beq+ return

# Conditions were not met, send RESV_DENY
deny:
li r3, 3
blr

# Otherwise call the original function
return:
b DWCiCheckResvCommand
