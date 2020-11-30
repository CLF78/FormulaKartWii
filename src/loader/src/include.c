#include <stdint.h>
#include <stdbool.h>
#include "include.h"

void flushAddr(void* addr) {
	dcbf(addr);
	icbi(addr);
}

void directWrite(uint32_t* addr, uint32_t value) {
	addr[0] = value;
	flushAddr(addr);
}

void directBranchEx(void* addr, void* ptr, bool lk) {
	directWrite((uint32_t*)(addr), ((((uint32_t)(ptr) - (uint32_t)(addr)) & 0x3FFFFFF) | 0x48000000 | !!lk));
}
