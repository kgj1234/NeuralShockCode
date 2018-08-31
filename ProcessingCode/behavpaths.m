basepath='E:/ShockPositionData/';
dates={'2_2_18_','2_3_18_','2_4_18_'};
suffixes={'bigbox_nonshock','shockbox','shockbox_SHOCK'};
behav_paths=cell(1,length(dates)*length(suffixes));
for i=1:length(dates)
    for j=1:length(suffixes)
        
      
        behav_paths{1,(length(suffixes))*(i-1)+j}=strcat(basepath,dates{1,i},suffixes{1,j},'.mat');
            
        
    end
    
end
  
