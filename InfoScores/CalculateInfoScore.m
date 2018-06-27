function info_scores=CalculateInfoScore(neural_activity,position,num_hor_bins,num_ver_bins,trackwidth,trackheight)
%neural_activity-firing_rate,S,C,etc
%num_hor_bins-number of bins the horizontal width should be divided into
%num_ver_bins-number of bins the vertical height should be divided into
%trackwidth,trackheight-width and height of track



%bin position data
n=size(neural_activity,1);

position(:,1)=position(:,1)-(min(position(:,1))-.0001);
position(:,2)=position(:,2)-(min(position(:,2))-.0001);
position=bin_position_data(position,num_hor_bins,num_ver_bins,trackwidth+.001,trackheight+.001);
%Caclulate probabilities of mouse being in given bin
probabilities=zeros(1,num_hor_bins*num_ver_bins);
for i=1:num_ver_bins*num_hor_bins
    probabilities(i)=sum(position==i)/length(position);
end

positivefiring=[];
for i=1:size(neural_activity,1)
    
    if max(neural_activity(i,:))>0
        
        positivefiring=[positivefiring,i];
    end
end

neural_activity=neural_activity(positivefiring,:);
%Set up scoring for shifted values
info_scores_shifted=zeros(size(neural_activity,1),101);
info_scores=zeros(size(neural_activity,1),1);
mean_firing_rate=mean(neural_activity,2);
firing_rate_per_bin=zeros(size(neural_activity,1),length(probabilities));

%calculate info scores for all shifted data, as well as original data

%If you want to calculate info without comparing to shifted, set i=0  in
%the for loop, and uncomment the code after the for loop that calculates
%mean and std.
for i=-50:50
    shifted_position=shiftposition(position,i);

    for k=1:length(probabilities)
        mouse_in_k=(shifted_position==k);
        firing_rate_per_bin(:,k)=mean(neural_activity(:,mouse_in_k),2);
    end
    for j=1:length(probabilities)
        for k=1:size(neural_activity,1)
            if firing_rate_per_bin(k,j)>0
                info_scores_shifted(k,i+51)=info_scores_shifted(k,i+51)+probabilities(j)*(firing_rate_per_bin(k,j)/mean_firing_rate(k)).*log2(firing_rate_per_bin(k,j)./mean_firing_rate(k));
            end
        end
    end
    if i==0
        for j=1:length(probabilities)
            for k=1:size(neural_activity,1)
                if firing_rate_per_bin(k,j)>0
                    info_scores(k,1)=info_scores(k,1)+probabilities(j)*(firing_rate_per_bin(k,j)./mean_firing_rate(k)).*log2(firing_rate_per_bin(k,j)./mean_firing_rate(k));
        
                end
            end
        end
    end
end    
%Z score info scores
avg=mean(info_scores_shifted,2);
std_dev=std(info_scores_shifted,0,2);
info_scores=(info_scores-avg)./std_dev;
%Include neurons that never fired with info scores of 0
nonfiring=setdiff(1:n,positivefiring);
i=1;
while length(nonfiring)>=1
    if i==nonfiring(1)
       
        info_scores=vertcat(info_scores(1:i-1,1),[0],info_scores(i:end,1));
        
        
        if length(nonfiring)>1
            nonfiring(1)=[];
        else
            nonfiring=[];
        end
        i=1;
    else
        i=i+1;
    end
        
     
end
    

