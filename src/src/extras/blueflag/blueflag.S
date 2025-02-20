.include "asm_setup.S"

.extern BlueFlag_ToggleVisibility, BlueFlagHook
.global BlueFlagInject, BlueFlagInject_K


BlueFlagInject:
bl BlueFlag_ToggleVisibility
mr r3, r31
lis r4,-0x7f64
b BlueFlagHook+4

BlueFlagInject_K:
bl BlueFlag_ToggleVisibility
mr r3, r31
lis r4,-0x7f65
b BlueFlagHook+4