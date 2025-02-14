.include "asm_setup.S"

.extern BlueFlag_ToggleVisibility, BlueFlagHook
.global BlueFlagInject


BlueFlagInject:
bl BlueFlag_ToggleVisibility
mr r3, r31
lis r4,-0x7f64
b BlueFlagHook+4