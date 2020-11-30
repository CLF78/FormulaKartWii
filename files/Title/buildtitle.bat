wimgt encode titlepics/*.png --transform=TPL.RGB565
ren %cd%\titlepics\*. *.tpl
ren %cd%\titlepics\Bowser.tpl tt_title_screen_koopa.tpl
ren %cd%\titlepics\Luigi.tpl tt_title_screen_luigi.tpl
ren %cd%\titlepics\Mario.tpl tt_title_screen_mario.tpl
ren %cd%\titlepics\MarioLuigi.tpl tt_title_screen_mario0.tpl
ren %cd%\titlepics\MarioKart.tpl tt_title_screen_mario2.tpl
ren %cd%\titlepics\Peach.tpl tt_title_screen_peachi.tpl
move %cd%\titlepics\*.tpl %cd%\Title.d\title\timg
wszst create Title.d