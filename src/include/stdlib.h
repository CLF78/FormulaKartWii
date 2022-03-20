#pragma once

int snprintf(char* buffer, int length, char* format, ...);
void* new(u32 size, void* heap, u32 align);
void delete(void* buffer);
