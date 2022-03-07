#pragma once

#include "common.h"

typedef struct {
	u32 magic;
	u32 fileLength;
	u16 numSections;
	u16 headerLength;
	u32 version;
	u32 sectionOffsets[];
} KMPHeader;
