function [info_matrix,sparsity_matrix]=compare_gaussian_parameters(firing,position,gaussian_param_vector,offset)
nrows_vector=[20,25,30,35];
ncols_vector=[20,25,30,35];
info_matrix=zeros(size(firing,1),length(gaussian_param_vector));
sparsity_matrix=zeros(size(info_matrix));

parfor i=1:length(gaussian_param_vector)
    firing_rate=extractFiringRate(firing,gaussian_param_vector(i),gaussian_param_vector(i)*4);
    info_matrix(:,i)=InfoScoreMain(firing_rate,position,calculate_velocity(position,.05),nrows_vector,ncols_vector,offset,10);
    sparsity_matrix(:,i)=IndividualSparsityMain(firing_rate,position,nrows_vector,ncols_vector,offset);
end
