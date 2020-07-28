#pragma once

#include <stdbool.h>
#include <stdarg.h>
#include <stddef.h>
#include <stdint.h>

// thanks josh
#define dcbf(_val) asm volatile("dcbf 0, %0" \
                                :            \
                                : "r"(_val))
#define icbi(_val) asm volatile("icbi 0, %0" \
                                :            \
                                : "r"(_val))

typedef struct {
	int unk1;	// 00
	int unk2;	// 04
	int unk3;	// 08
	int unk4;	// 0C
	int unk5;	// 10
	int unk6;	// 14
	int unk7;	// 18
	int unk8;	// 1C
	int unk9;	// 20
	int unk10;	// 24
	int unk11;	// 28
	int unk12;	// 2C
	int address;	// 30
	int length;	// 34
	int unk13;	// 38
} DVDHandle;

bool DVDOpen(const char* path, DVDHandle *fd);
int DVDReadPrio(DVDHandle* fd, void* buffer, int length, int offset, int param_5);
bool DVDClose(DVDHandle* fd);
int sprintf(char *s, const char *format, ...);
void OSSetMEM1ArenaHi(uint32_t value);
void flushAddr(void* addr);
void directWrite(uint32_t* addr, uint32_t value);
void directBranchEx(void* addr, void* ptr, bool lk);
extern void file_start();

char* gameId;
void* _init_cpp_exceptionsHook;
void* _hook;
void* _autoException;
void* _afterStaticRLoad;
