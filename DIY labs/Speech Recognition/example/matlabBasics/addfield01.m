clear student		% 清除 student 變數
student = struct('name', 'Roland', 'scores', [80, 90]);
student(2).age = 20;	% 加入新欄位
student(1)		% 顯示 student(1)
student(2)		% 顯示 student(2)