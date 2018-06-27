function position_binned=bin_position_data(position,num_hor_bins,num_ver_bins,trackwidth,trackheight)
%bins position data
%num_hor_bins-integer indicating number of horizontal bins to use
%num_ver_bins-integer indicating number of vertical bins to use
%trackwidth-float
%trackheight-float


position_binned=zeros(size(position,1),1);
for i=1:length(position_binned)
   
    position_binned(i,1)=ceil(position(i,1)*num_hor_bins/trackwidth)+num_hor_bins*(ceil(position(i,2)*num_ver_bins/trackheight)-1);
end
