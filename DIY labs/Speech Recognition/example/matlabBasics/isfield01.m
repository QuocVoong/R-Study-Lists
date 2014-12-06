s = struct('name', {'Tim', 'Ann'}, 'scores', {[1 3 5 ],[2 4 6]});
fprintf('isfield(s, ''name'') = %d\n', isfield(s, 'name'));
fprintf('isfield(s, ''height'') = %d\n', isfield(s, 'height'));
