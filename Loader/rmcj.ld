SECTIONS {
	gameId = 0x80000000;

	DVDOpen = 0x8015E1DC;
	DVDReadPrio = 0x8015E754;
	DVDClose = 0x8015E488;
	sprintf = 0x80011950;
	OSSetMEM1ArenaHi = 0x801A0FF4;

	_init_cpp_exceptionsHook = 0x80021140;
	_hook = 0x801BAA40;
	_autoException = 0x802A6D84;
	_afterStaticRLoad = 0x800074D4;
}
