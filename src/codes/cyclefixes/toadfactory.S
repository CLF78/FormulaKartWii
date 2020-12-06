# Original instruction
lwz r0, 0xBC(r3)

# Subtract one second to let the animation play
subi r27, r30, 60
cmpw r0, r27
bne+ end

# Copy to r14
mr r14, r0

# Calculate the difference between the first timer and the second timer
sub r29, r14, r5

# Add the result once to the first timer
add r14, r14, r29
stw r14, 0xB8(r3)

# Add it twice to the second timer
add r14, r14, r29
stw r14, 0xBC(r3)

end:
#ENDCODE
