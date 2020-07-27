SECTIONS {
	gameId = 0x80000000;

	DVDOpen = 0x8015E334;
	DVDReadPrio = 0x8015E8AC;
	DVDClose = 0x8015E5E0;
	sprintf = 0x80011A94;
	OSSetMEM1ArenaHi = 0x801A1430;

	_init_cpp_exceptionsHook = 0x80021284;
	_hook = 0x801BAE7C;
	_autoException = 0x80295404;
	_afterStaticRLoad = 0x800074D4;
}
