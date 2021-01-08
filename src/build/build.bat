@echo off

SET /P BIN=Compile BINs? (Y/N): 

python C:\Users\CLF78\Desktop\CodeManagerProj\main.py C:\Users\CLF78\Desktop\FKW\src\build\OnlineEnduranceP.txt C:\Users\CLF78\Desktop\FKW\src\build\OnlineEnduranceU.txt C:\Users\CLF78\Desktop\FKW\src\build\OnlineEnduranceJ.txt C:\Users\CLF78\Desktop\FKW\src\build\OnlineEnduranceK.txt

IF /i %BIN%==Y python C:\Users\CLF78\Desktop\FKW\src\build\createbin.py

pause