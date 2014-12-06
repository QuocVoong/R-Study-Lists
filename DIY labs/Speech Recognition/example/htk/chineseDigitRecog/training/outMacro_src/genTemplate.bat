@echo off & if defined debug echo on
setlocal enabledelayedexpansion 
if x%4x==xx (
	echo usage : %~nx0 #State mixtures ParaKind, out.template
	#State : 3/5
	mixtures : "6 6 6"
	ParaKind : MFCC_E_D_A_Z
	exit /b
)
set #state=%1
set mixs=%~2
set feapara=%~f3
set out.tmp=%~f4

%~dp0\outMacro.exe P D %#state% "%mixs%" %feapara% > %out.tmp%
