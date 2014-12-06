fields = {'name', 'age'};
values = {'Tim', 9; 'Annie', 6};
s = cell2struct(values, fields, 2);
s(1)			% 印出第一筆資料
s(2)			% 印出第二筆資料