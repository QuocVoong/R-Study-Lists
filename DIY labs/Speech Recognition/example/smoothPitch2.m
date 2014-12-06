function [pitch, changed]=smoothPitch2(pitch)

changed=0*pitch;
for i=4:length(pitch)-2
	if pitch(i)~=0 & pitch(i-1)~=0
%		if pitch(i)-pitch(i-1)>100,
%			difference=pitch(i)-pitch(i-1);
%			octave=floor((difference+60)/120);
%			pitch(i)=pitch(i)-octave*120;
%			changed(i)=1;
%		end
%		if pitch(i)-pitch(i-1)<-100,
%			difference=pitch(i-1)-pitch(i);
%			octave=floor((difference+60)/120);
%			pitch(i)=pitch(i)+octave*120;
%			changed(i)=1;
%		end
		if abs(pitch(i)-pitch(i-1))>100,
            former=0;                                    
            successor=0;            
            for j=1:2
                if abs(pitch(i-1-j)-pitch(i-1))<100 
                    former=former+1;
                end                                                
                if abs(pitch(i+j)-pitch(i))<100
                    successor=successor+1;
                end                
            end
            if former<2      
                for j=0:2
                    if pitch(i-1-j)~=0
                        difference=pitch(i-1-j)-pitch(i)
                        if difference>100
                			octave=floor((difference+60)/120);
                			pitch(i-1-j)=pitch(i-1-j)-octave*120;
                			changed(i-1-j)=1;     
                        elseif difference<-100
                            difference=-difference;
                			octave=floor((difference+60)/120);
                			pitch(i-1-j)=pitch(i-1-j)+octave*120;
                			changed(i-1-j)=1;     
                        end
                    end
                end            
            elseif successor<2
                for j=0:2
                    if pitch(i+j)~=0                    
                        difference=pitch(i+j)-pitch(i-1)
                        if difference>100
                			octave=floor((difference+60)/120);
                			pitch(i+j)=pitch(i+j)-octave*120;
                			changed(i+j)=1;     
                        elseif difference<-100
                            difference=-difference;
                			octave=floor((difference+60)/120);
                			pitch(i+j)=pitch(i+j)+octave*120;
                			changed(i+j)=1;     
                        end
                    end
                end           
            end
        end
	end
end