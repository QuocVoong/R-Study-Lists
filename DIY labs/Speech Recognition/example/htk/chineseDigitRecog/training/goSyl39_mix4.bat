@echo off
setlocal
path %path%;%cd%\..\bin.win32;%cd%\..\bin

echo I.1: 產生輸出目錄
for %%i in (output output\feature output\hmm) do mkdir %%i > nul 2>&1

echo I.2: 產生 modelName.txt 及 phone.mlf
@echo EX > output\syl2phone.scp
HLEd -n output\modelName.txt -d digit.pam -l * -i output\phone.mlf output\syl2phone.scp syl.mlf

echo I.3: 產生 wav2fea.scp 
(for /f "delims=" %%i in ('dir/s/b ..\waveFile\*.wav') do @echo %%i output\feature\%%~ni.fea)> output\wav2fea.scp

echo I.4: 使用 HCopy.exe 進行語音特徵抽取
HCopy -C mfcc39.cfg -S output\wav2fea.scp

echo II.1: 產生訓練資料和測試資料的檔案列表 trainFea.scp 及 testFea.scp
for %%i in (train test) do (
	for /f %%j in (%%iFile.list) do @echo output\feature\%%j.fea
) > output\%%iFea.scp

echo II.2: 產生 HMM 樣板檔案 template.hmm    
outMacro.exe P D 3 1 MFCC_E_D_A_Z 39 > output\template.hmm

echo II.3: 使用 Flat Start 產生 hcompv.hmm    
HCompV -m -o hcompv.hmm -M output -I output\phone.mlf -S output\trainFea.scp output\template.hmm

echo II.4: 拷貝 hcompv.hmm 以產生 macro.init
(for /f %%i in (output\modelName.txt) do @sed 's/hcompv.hmm/%%i/g' output\hcompv.hmm) > output\macro.init

echo II.5: 使用 mxup.scp 來修改 macro.init 以產生 macro.0
(@echo MU 4 {*.state[2-4].mix}) > output\mxup.scp
copy /y output\macro.init output\hmm\macro.0
HHEd -H output\hmm\macro.0 output\mxup.scp output\modelName.txt

echo II.6: 進行 EM 以產生 macro.1~macro.5
:loop 
  set /a current+=1
	set /a prev=current-1
	copy /y output\hmm\macro.%prev% output\hmm\macro.%current%
	set cmd=HERest -H output\hmm\macro.%current% -I output\phone.mlf -S output\trainFea.scp output\modelName.txt
	echo %cmd%
	%cmd%
if not %current%==5 goto :loop

echo III.1: 使用 digit.grammar 產生 digit.net
Hparse digit.grammar output\digit.net

echo III.2: 對測試資料及訓練資料產生辨識結果
echo 	辨識率測試（Outside test）：產生 result_test.mlf
HVite -H output\hmm\macro.5 -l * -i output\result_test.mlf -w output\digit.net -S output\testFea.scp digit.pam output\modelName.txt
echo 	辨識率測試（Inside test）：產生 result_train.mlf
HVite -H output\hmm\macro.5 -l * -i output\result_train.mlf -w output\digit.net -S output\trainFea.scp digit.pam output\modelName.txt

echo III.3: 產生 Outside Test 及 Inside Test 的 Confusion Matrix
findstr /v "sil" output\result_test.mlf > output\result_test_no_sil.mlf
findstr /v "sil" syl.mlf > output\answer.mlf
HResults -p -I output\answer.mlf digit.pam output\result_test_no_sil.mlf > output\outsideTest.txt
echo 	Confusion matrix of outside test:
type output\outsideTest.txt

findstr /v "sil" output\result_train.mlf > output\result_train_no_sil.mlf
findstr /v "sil" syl.mlf > output\answer.mlf
HResults -p -I output\answer.mlf digit.pam output\result_train_no_sil.mlf > output\insideTest.txt
echo 	Confusion matrix of inside test:
type output\insideTest.txt