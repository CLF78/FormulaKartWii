SECTIONS {
	gameId = 0x80000000;

	DVDOpen = 0x8015E2BC;
	DVDReadPrio = 0x8015E834;
	DVDClose = 0x8015E568;
	sprintf = 0x80011A2C;
	OSSetMEM1ArenaHi = 0x801A10D4;

	_init_cpp_exceptionsHook = 0x8002121C;
	_hook = 0x801BAB20;
	_autoException = 0x802A7404;
	_afterStaticRLoad = 0x800074D4;
}
