function info=InfoScoreMain(neural_activity,position,speed,hor_bin_vector,ver_bin_vector,offset,vel_thresh)
%Calculate info scores in regards to position correlated with neural
%activity, this code takes the mean info over several choices of binning

%neural_activity-S,trace,firing_rate,etc
%position-Nx2 matrix
%speed-Nx1 matrix
%hor_bin_vector-a vector containing the number of horizontal bins desired
%for each experiment, info scores are averaged after calculating them using
%each element of the vector
%ver_bin_vector-same as hor_bin_vector but describing vertical bins
%offset-offset the data to account for recording delays if desired
%vel_thresh-data points with velocity less than vel_thresh will not be included in
%analysis
%





%offset data
neural_activity=neural_activity(:,1:end-offset);
position=position(offset+1:end,:);
speed=speed(offset+1:end,:);
trackwidth=max(position(:,1))-min(position(:,1));
trackheight=max(position(:,2))-min(position(:,2));
%exclude data points with small velocity
if vel_thresh>0
    include_indices=(speed>vel_thresh);
    neural_activity=neural_activity(:,include_indices);
    position=position(include_indices,:);
end


%Calculate and average info scores
for i=1:length(hor_bin_vector)
    
    info(:,i)=CalculateInfoScore(neural_activity,position,hor_bin_vector(i),ver_bin_vector(i),trackwidth,trackheight);
end
info=mean(info,2);