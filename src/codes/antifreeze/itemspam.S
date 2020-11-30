# Checks if EVENT data would fit in the buffer before copying it in
# This prevents you crashing from sending too many items
# See http://wiki.tockdom.com/wiki/MKWii_Network_Protocol/EVENT

# r12: free
# r27: entry pointer
# r30: total size

# Get data size
lbz r12, 0x1C (r27)

# Check if it would fit in the buffer
add r12, r30, r12
cmpwi r12, 0xE0
blt+ noblock

# Set type to none if not to ignore
li r0, 0
stb r0, 0x19 (r27)

# Default instruction
noblock:
	lbz r0, 0x19 (r27)

#ENDCODE
