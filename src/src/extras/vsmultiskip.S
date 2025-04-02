.include "asm_setup.S"

.extern Menudata, VSMenuReturn2Func, VSMenuReturn2NormFunc, VSMenuReturnHook, VSMenuReturnNormFunc, VSMenuSkipOGInstr
.global VSMenuReturn, VSMenuReturn2

# Load Menudata and menu index
VSMenuReturn:
lis r4, Menudata@ha
lwz r4, Menudata@l(r4)
lwz r4, 0 (r4)
lwz r4, 0 (r4)

# If it's single player menu, continue as normal
cmpwi r4, 0x48
beq end

# Otherwise return to the main menu using the function
b VSMenuReturnNormFunc

# Load Menudata and menu index
VSMenuReturn2:
lis r5, Menudata@ha
lwz r5, Menudata@l(r5)
lwz r5, 0 (r5)
lwz r5, 0 (r5)

# If it's single player menu, continue as normal
cmpwi r5, 0x48
beq end2

# Otherwise, setup arguments for the return to main menu function and call it
mr r5, r4
li r4, 0x41
b VSMenuReturn2Func

end2:
b VSMenuReturn2NormFunc

# Original instruction
end:
lis	r4, VSMenuSkipOGInstr@ha
b VSMenuReturnHook + 4