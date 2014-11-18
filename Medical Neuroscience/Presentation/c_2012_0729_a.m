% 2012/07/03
% 用亂數產生洗牌的效果，將圖片與字做隨機的對應
% 產生5組的資料,輸出result.txt
% 由traditonal_meet_num_result, simplified_meet_num_resul看出每組資料配對成功的次數
% 由traditonal_no_meet_num_result, simplified_no_meet_num_result看出每組資料配對不成功的次數
% 修改洗牌的演算法-2012/07/08
% 將不是平均分配的結果移除，只留下平均分配的結果 -2012/07/29

clear all
clc

life_num =24; %update it on 2012/07/16
lifeless_num = 32;
total_num = life_num + lifeless_num ;
% life_num =10;
% lifeless_num = 12;

do_times = 25;
result_index = 0;  % add it on 2012/07/29
result_num =10;    % add it on 2012/07/29

fid = fopen('result.txt','wt');
for do_i = 1: do_times
    
    word_traditonal_life= randperm(life_num);
    word_simplified_life= randperm(life_num);
    org_word_traditonal_life = word_traditonal_life;
    
    word_traditonal_lifeless = randperm(lifeless_num);
    word_simplified_lifeless = randperm(lifeless_num);
    org_word_traditonal_lifeless = word_traditonal_lifeless;
    
    pic_life = randperm(life_num);
    pic_lifeless = randperm(lifeless_num);
    
    meet_life_rig = zeros(1,life_num);
    % meet_rig(1) =1;
    % break
    meet_c = 50;
    random_num = 100;
    for i = 1:life_num
        if pic_life(i) == word_traditonal_life(i)
            meet_life_rig(i)=1;
        else
            c = randint(1,1,[1,random_num]);
            if c>=meet_c % meet % update it on 2012/07/14
                meet_life_rig(i)=1; % add it on 2012/07/08
                temp = word_traditonal_life(i);
                for j=1:life_num
                    if pic_life(i) == word_traditonal_life(j)
                        %                             meet_rig(i)=1;
                        word_traditonal_life(j) = temp;
                        word_traditonal_life(i) = pic_life(i);
                        if pic_life(j) == word_traditonal_life(j)  % add it on 2012/07/16
                            meet_life_rig(j)=1;
                        end
                        break
                    end
                end
            end
        end
    end
    org_meet_life_rig = meet_life_rig;
    %     org_word_traditonal_life = word_traditonal_life;
    sum_meet_life = sum(meet_life_rig);
    
    if sum_meet_life> (life_num/2)
        add_num = sum_meet_life-(life_num/2);
        for change_loop = 1:add_num
            for ii= 1:life_num
                if meet_life_rig(ii) == 1
                    for iii = 1:life_num
                        if meet_life_rig(iii) == 0
                            %                            fprintf('A')
                            temp = word_traditonal_life(ii);
                            word_traditonal_life(ii) = word_traditonal_life(iii);
                            word_traditonal_life(iii) = temp;
                            meet_life_rig(ii)=0;
                            break
                        end
                    end
                    break
                end
            end
        end
    elseif (life_num/2) > sum_meet_life
        add_num = (life_num/2)-sum_meet_life;
        for change_loop = 1:add_num
            for ii= 1:life_num
                if meet_life_rig(ii) == 0
                    for iii = 1:life_num
                        
                        if pic_life(ii) == word_traditonal_life(iii)
                            %                            fprintf('B')
                            word_traditonal_life(iii) = word_traditonal_life(ii);
                            word_traditonal_life(ii) = pic_life(ii);
                            meet_life_rig(ii) = 1;
                            break
                        end
                    end
                    break
                end
            end
        end
    end
    sum_meet_life = sum(meet_life_rig);
    %     break
    
    %% Lifeless poartion
    
    meet_lifeless_rig = zeros(1,lifeless_num);
    for i = 1:lifeless_num
        if pic_lifeless(i) == word_traditonal_lifeless(i)
            meet_lifeless_rig(i)=1;
        else
            c = randint(1,1,[1,random_num]);
            if c>=meet_c % meet & update it on 2012/07/14
                meet_lifeless_rig(i)=1; % add it on 2012/07/08
                %                 if pic_lifeless(i) == word_traditonal_lifeless(i)
                %                 else
                
                temp = word_traditonal_lifeless(i);
                for j=1:lifeless_num
                    if pic_lifeless(i) == word_traditonal_lifeless(j)
                        word_traditonal_lifeless(j) = temp;
                        word_traditonal_lifeless(i) = pic_lifeless(i);
                        if pic_lifeless(j) == word_traditonal_lifeless(j)  % add it on 2012/07/16
                            meet_life_rig(j)=1;
                        end
                        break
                    end
                end
            end
        end
    end
    
    org_meet_lifeless_rig = meet_lifeless_rig;
    %     org_word_traditonal_lifeless = word_traditonal_lifeless;
    
    sum_meet_lifeless=sum(meet_lifeless_rig);
    
    if sum_meet_lifeless> (lifeless_num/2)
        add_num = sum_meet_lifeless-(lifeless_num/2);
        for change_loop = 1:add_num
            for ii= 1:lifeless_num
                if meet_lifeless_rig(ii) == 1
                    for iii = 1:lifeless_num
                        if meet_lifeless_rig(iii) == 0
%                             fprintf('A')
                            temp = word_traditonal_lifeless(ii);
                            word_traditonal_lifeless(ii) = word_traditonal_lifeless(iii);
                            word_traditonal_lifeless(iii) = temp;
                            meet_lifeless_rig(ii)=0;
                            break
                        end
                    end
                    break
                end
            end
        end
    elseif (lifeless_num/2) > sum_meet_lifeless
        add_num = (lifeless_num/2)-sum_meet_lifeless;
        for change_loop = 1:add_num
            for ii= 1:lifeless_num
                if meet_lifeless_rig(ii) == 0
                    for iii = 1:lifeless_num
                        
                        if pic_lifeless(ii) == word_traditonal_lifeless(iii)
%                             fprintf('B')
                            word_traditonal_lifeless(iii) = word_traditonal_lifeless(ii);
                            word_traditonal_lifeless(ii) = pic_lifeless(ii);
                            meet_lifeless_rig(ii) = 1;
                            break
                        end
                    end
                    break
                end
            end
        end
    end
    sum_meet_lifeless = sum(meet_lifeless_rig);
    %     break
    
    %% Result
    %     trad_simp_c = 50;
    result_pic = randperm(life_num+lifeless_num);
    for result_i = 1:length(result_pic)
        if result_pic(result_i)> (length(result_pic))/2
            random_trad_simp(result_i) = 1;
        else
            random_trad_simp(result_i) = 0;
        end
    end
    %    sum_trad = sum(random_trad_simp)
    
    if result_pic(1)<=24 % update it on 2012/06/29
        pic = result_pic(1)+200;
        for i=1:life_num
            if result_pic(1) == pic_life(i)
                %                 c = randint(1,1,[1,random_num]);
                if random_trad_simp(i)==1
                    word = word_traditonal_life(i);
                else
                    word = word_traditonal_life(i)+100;
                end
                break
            end
        end
    else
        pic = result_pic(1)-24+250;
        for i=1:lifeless_num
            if result_pic(1)-24 == pic_lifeless(i)
                %                 c = randint(1,1,[1,random_num]);
                if random_trad_simp(i+24)==1
                    word = word_traditonal_lifeless(i)+50;
                else
                    word = word_traditonal_lifeless(i)+50+100;
                end
                
                break
            end
        end
    end
    result = [pic,word];
    
    for ii = 2:length(result_pic)
        if result_pic(ii)<=24 % update it on 2012/06/29
            pic = result_pic(ii)+200;
            for i=1:life_num
                if result_pic(ii) == pic_life(i)
                    %                     c = randint(1,1,[1,random_num]);
                    if random_trad_simp(i)==1
                        word = word_traditonal_life(i);
                    else
                        word = word_traditonal_life(i)+100;
                    end
                    break
                end
            end
        else
            pic = result_pic(ii)-24+250;
            for i=1:lifeless_num
                if result_pic(ii)-24 == pic_lifeless(i)
                    %                     c = randint(1,1,[1,random_num]);
                    if random_trad_simp(i+24)==1
                        word = word_traditonal_lifeless(i)+50;
                    else
                        word = word_traditonal_lifeless(i)+50+100;
                    end
                    break
                end
            end
        end
        result = [result pic word];
    end
    
    traditonal_meet_num = 0;
    simplified_meet_num = 0;
    traditonal_no_meet_num = 0;
    simplified_no_meet_num = 0;
    
    traditonal_meet = [];
    simplified_meet = [];
    traditonal_no_meet = [];
    simplified_no_meet = [];
    for i = 1:total_num
        if (result(i*2-1)-result(i*2) == 100) | (result(i*2-1)-result(i*2) == 200)
            if result(i*2)<100
                traditonal_meet_num = traditonal_meet_num+1;
                check_rig(i) = 1;
                traditonal_meet = [traditonal_meet,i];
            else
                simplified_meet_num = simplified_meet_num+1;
                check_rig(i) = 2;
                simplified_meet = [simplified_meet,i];
            end
        else
            if result(i*2)<100
                traditonal_no_meet_num = traditonal_no_meet_num+1;
                check_rig(i) = 3;
                traditonal_no_meet = [traditonal_no_meet,i];
            else
                simplified_no_meet_num = simplified_no_meet_num+1;
                check_rig(i) = 4;
                simplified_no_meet = [simplified_no_meet,i];
            end
        end
    end
    
    %     for i = 1:55
    %
%     traditonal_meet_num
%     simplified_meet_num
%     traditonal_meet_num-simplified_meet_num
    diff_meet = traditonal_meet_num-simplified_meet_num;
    if (diff_meet)/2>0
        for ii = 1:(diff_meet)/2
            result(2*traditonal_meet(2*ii)) = result(2*traditonal_meet(2*ii))+100;
            traditonal_meet_num = traditonal_meet_num-1;
            simplified_meet_num =  simplified_meet_num+1;
        end
    elseif (diff_meet)/2<0
        for ii = 1:-(diff_meet)/2
            result(2*simplified_meet(2*ii)) = result(2*simplified_meet(2*ii))-100;
            traditonal_meet_num = traditonal_meet_num+1;
            simplified_meet_num =  simplified_meet_num-1;
        end
    end
    
    diff_no_meet = traditonal_no_meet_num-simplified_no_meet_num;
    if (diff_no_meet)/2>0
        for ii = 1:(diff_no_meet)/2
            result(2*traditonal_no_meet(2*ii)) = result(2*traditonal_no_meet(2*ii))+100;
            traditonal_no_meet_num = traditonal_no_meet_num-1;
            simplified_no_meet_num =  simplified_no_meet_num+1;
        end
    elseif (diff_no_meet-1)/2<0
        for ii = 1:-(diff_no_meet-1)/2
            result(2*simplified_no_meet(2*ii)) = result(2*simplified_no_meet(2*ii))-100;
            traditonal_no_meet_num = traditonal_no_meet_num+1;
            simplified_no_meet_num =  simplified_no_meet_num-1;
        end
    end  
    
    if traditonal_meet_num ==14 & simplified_meet_num ==14 & traditonal_no_meet_num==14 & simplified_no_meet_num ==14   % add it on 2012/07/29
        result_index = result_index+1;  % add it on 2012/07/29
        traditonal_meet_num_result(result_index) = traditonal_meet_num;
        simplified_meet_num_result(result_index) = simplified_meet_num;
        traditonal_no_meet_num_result(result_index) = traditonal_no_meet_num;
        simplified_no_meet_num_result(result_index) = simplified_no_meet_num;              
        for i =1:length(result)
            str_result = num2str(result(i));
            fprintf(fid,str_result);
            fprintf(fid,' ');
        end
        fprintf(fid,'\n');
    end
    if result_index == result_num   % add it on 2012/07/29
        break
    end
end
fclose(fid);








