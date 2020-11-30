SECTIONS {
	gameId = 0x80000000;

	DVDOpen = 0x8015E21C;
	DVDReadPrio = 0x8015E794;
	DVDClose = 0x8015E4C8;
	sprintf = 0x80010ECC;
	OSSetMEM1ArenaHi = 0x801A1034;

	_init_cpp_exceptionsHook = 0x800206BC;
	_hook = 0x801BAA80;
	_autoException = 0x802A3084;
	_afterStaticRLoad = 0x800074D4;
}
