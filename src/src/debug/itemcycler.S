.include "asm_setup.S"

.extern GCNButton, ItemDebug
.global ItemCycler

ItemCycler:
lwz r0, 0x8C(r4) # Default instruction

# Check if Debug byte is enabled
lis r12, ItemDebug@ha
lbz r12, ItemDebug@l(r12)
cmpwi r12, 0x1
bnelr

# Setup the button activator
lis r7, GCNButton@ha
lis r10, itemStore@ha
lbz r31, itemStore@l+0x1(r10)
lbz r10, itemStore@l(r10) 
lhz r12, GCNButton@l(r7)
andi. r11, r12, 0x3 
beq skip 
cmpwi r31, 0 
bne skip 

# Code here will only execute for a frame
andi. r11, r12, 0x1 
beq add
cmpwi r10, 0 # Check if item is Green Shell
subi r10, r10, 1
bne skip
li r10, 0x13 # Set item to Triple Bananas (end of the list)
add:
andi. r11, r12, 0x2
beq skip
cmpwi r10, 0x12 # Check if item is Triple Banana
addi r10, r10, 1 
ble skip 
reset:
li r10, 0 # Set item to Green Shell (start of the list)
skip:
li r31, 1 
bne skip2 
li r31, 0
skip2:
lis r6, itemStore@ha
stb r31, itemStore@l+0x1(r6) # Store button press state
stb r10, itemStore@l(r6) # Store item ID
stw r10, 0x8C (r4) # Store item ID to item pointer
li r6, 1 # Set item amount to one
cmpwi r10, 5 # Check if item is Triple Mushroom
beq triple # Jump to set amount to three
cmpwi r10, 0x10 # If item ID is less than Triple Green Shell (0x10 and above are all Triple Items)
blt storeamt # Skip setting amount to three
triple:
li r6, 3 # Set amount to three
storeamt:
stw r6, 0x90 (r4) #Store amount to item pointer
blr
itemStore:
.word 0x0
.align 2