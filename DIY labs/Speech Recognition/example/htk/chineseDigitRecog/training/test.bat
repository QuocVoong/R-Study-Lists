@echo off

set current=0
:loop 
	set /a prev=current
	set /a current+=1
	copy /y output\hmm\macro.%prev% output\hmm\macro.%current%
	set cmd=HERest -H output\hmm\macro.%current% -I output\digitSylPhone.mlf -S output\trainFea.scp output\digitSyl.mnl
	echo %cmd%
	%cmd%
if not %current%==5 goto :loop

echo III.1: 使用 digit.grammar 產生 digit.net
Hparse digit.grammar output\digit.net

echo III.2: 對測試資料及訓練資料產生辨識結果
echo 	辨識率測試（Outside test）：產生 result_test.mlf
HVite -H output\hmm\macro.5 -l * -i output\result_test.mlf -w output\digit.net -S output\testFea.scp digitSyl.pam output\digitSyl.mnl
echo 	辨識率測試（Inside test）：產生 result_train.mlf
HVite -H output\hmm\macro.5 -l * -i output\result_train.mlf -w output\digit.net -S output\trainFea.scp digitSyl.pam output\digitSyl.mnl

echo III.3: 產生 Outside Test 及 Inside Test 的 Confusion Matrix
findstr /v "sil" output\result_test.mlf > output\result_test_no_sil.mlf
findstr /v "sil" digitSyl.mlf > output\answer.mlf
HResults -p -I output\answer.mlf digitSyl.pam output\result_test_no_sil.mlf > output\outsideTest.txt
echo 	Confusion matrix of outside test:
type output\outsideTest.txt

findstr /v "sil" output\result_train.mlf > output\result_train_no_sil.mlf
findstr /v "sil" digitSyl.mlf > output\answer.mlf
HResults -p -I output\answer.mlf digitSyl.pam output\result_train_no_sil.mlf > output\insideTest.txt
echo 	Confusion matrix of inside test:
type output\insideTest.txt