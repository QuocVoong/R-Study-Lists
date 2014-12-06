@echo off & if defined debug echo on
bcc32 outMacro.cpp

if not errorlevel 1 (
	echo\
	outMacro.exe P D 3 "6 3 2" MFCC_E_D_A_Z "13 13 13" > test.txt
	echo n | comp ans.txt test.txt
)
del *.tds *.obj >nul 2>&1
