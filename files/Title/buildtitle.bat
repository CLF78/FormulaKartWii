wimgt encode logo.png --transform=TPL.IA4 --dest=logo.tpl
copy /b logo.tpl Title_E.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_F.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_G.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_I.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_J.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_K.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_M.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_Q.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_S.d\title\timg\logo.tpl >nul
copy /b logo.tpl Title_U.d\title\timg\logo.tpl >nul
wszst create *.d
ren %cd%\logo.tpl
