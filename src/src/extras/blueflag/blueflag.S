.include "asm_setup.S"

.extern BlueFlag_ToggleVisibility, BlueFlagHook
.global BlueFlagInject

BlueFlagInject:
bl BlueFlag_ToggleVisibility
mr r3, r31
#ifdef REGION_K
lis r4,-0x7f65
#else
lis r4,-0x7f64
#endif
b BlueFlagHook+4
