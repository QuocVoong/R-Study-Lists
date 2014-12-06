function frameWinMouseAction(action)
% This function is used in "frame2pitchSimple".

if nargin<1, action='start'; end

switch(action)
	case 'start', % ====== 開啟圖形視窗
		% 設定滑鼠按鈕被按下時的反應動作
		set(gcf, 'WindowButtonDownFcn', [mfilename ' down']);
	case 'down', % ====== 滑鼠按鈕被按下時的反應指令
		% 設定滑鼠移動時的反應指令
		set(gcf, 'WindowButtonMotionFcn', [mfilename, ' move']);
		% 設定滑鼠按鈕被釋放時的反應指令
		set(gcf, 'WindowButtonUpFcn', [mfilename ' up']);
		% 一被按下，即執行 checkPitch move
		feval(mfilename, 'move');
	case 'move', % ====== 滑鼠移動時的反應指令
		% 取得相關資料
		amdfH=findobj(gcf, 'tag', 'amdf');
		amdfAxisH=findobj(gcf, 'tag', 'amdfAxis');
		frameH=findobj(gcf, 'tag', 'frame');
		minIndexH=findobj(gcf, 'tag', 'minIndex');
		localMinIndexH=findobj(gcf, 'tag', 'localMinIndex');
		amdfAxisH=findobj(gcf, 'tag', 'amdfAxis');
		amdfX=get(amdfH, 'xdata');
		amdfY=get(amdfH, 'ydata');
		% 取得滑鼠座標
		axes(amdfAxisH);
		amdfXLim=get(amdfAxisH, 'xlim');
		currPt=get(gca, 'CurrentPoint');
		x=currPt(1,1);
		y=currPt(1,2);
		% 更新 manualBarH
		manualBarH=findobj(gcf, 'tag', 'manualBar');
		if (amdfXLim(1)<=x) & (x<=amdfXLim(2))
			% 找出距離最近的點
			[minDist, amdfIndex]=min(abs(amdfX-x));
		else
			amdfIndex=0;
		end
		set(manualBarH, 'xdata', amdfIndex*[1 1]);
		% 更新 mainWindow 的圖
		mainWindow=get(gcf, 'userdata');
		if ~isempty(mainWindow)
			frameWindow=gcf;
			figure(mainWindow);
			pitch1H=findobj(gcf, 'tag', 'pitch1');
			pitch2H=findobj(gcf, 'tag', 'pitch2');
			pitch3H=findobj(gcf, 'tag', 'pitch3');
			
			pitch1=get(pitch1H, 'ydata');
			load text/frameIndex.txt; frameIndex=text_frameIndex;
			if amdfIndex==0,
				pitch1(frameIndex)=0;
			else
				freq=10*floor((8000+floor((amdfIndex-1)/2))/(amdfIndex-1));
				pitch1(frameIndex)=freq2pitch(freq);
			end
			
			load text/lowVolIndex.txt; lowVolIndex=text_lowVolIndex;
			pitch2=pitch1; pitch2(lowVolIndex)=0;
			pitch3=smoothPitch(pitch2);
			
			pitch1(pitch1==0)=nan;
			pitch2(pitch2==0)=nan;
			pitch3(pitch3==0)=nan;
			set(pitch1H, 'ydata', pitch1);
			set(pitch2H, 'ydata', pitch2);
			set(pitch3H, 'ydata', pitch3);
			
			figure(frameWindow);
		end
	case 'up', % ====== 滑鼠按鈕被釋放時的反應指令
		% 清除滑鼠移動時的反應指令
		set(gcf, 'WindowButtonMotionFcn', '');
		% 清除滑鼠按鈕被釋放時的反應指令
		set(gcf, 'WindowButtonUpFcn', '');
end