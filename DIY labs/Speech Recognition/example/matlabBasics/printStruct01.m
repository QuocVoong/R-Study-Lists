clear student		% 清除 student 變數
student(1) = struct('name', '張庭碩', 'scores', [85, 80]);
student(2) = struct('name', '鍾書蓉', 'scores', [80, 85]);
student(3) = struct('name', '黃念中', 'scores', [88, 82]);
for i = 1:length(student)	% 列印出每個學生的名字  
	fprintf ('student %g: %s\n', i, student(i).name);     
end  