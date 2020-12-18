wimgt encode version.png --transform=TPL.IA4 --dest=version.tpl
copy /b version.tpl Title_E.d\title\timg\version.tpl >nul
copy /b version.tpl Title_F.d\title\timg\version.tpl >nul
copy /b version.tpl Title_G.d\title\timg\version.tpl >nul
copy /b version.tpl Title_I.d\title\timg\version.tpl >nul
copy /b version.tpl Title_J.d\title\timg\version.tpl >nul
copy /b version.tpl Title_K.d\title\timg\version.tpl >nul
copy /b version.tpl Title_M.d\title\timg\version.tpl >nul
copy /b version.tpl Title_Q.d\title\timg\version.tpl >nul
copy /b version.tpl Title_S.d\title\timg\version.tpl >nul
copy /b version.tpl Title_U.d\title\timg\version.tpl >nul
wszst create *.d
ren %cd%\version.tpl
