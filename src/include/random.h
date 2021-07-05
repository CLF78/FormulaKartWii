#pragma once
#include <common.h>

extern void* RandomInstance;
void* RandomConstruct(void* random);
int RandomNextLimited(void* random, u32 modulo);
