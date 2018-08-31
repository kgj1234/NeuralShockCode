function sparsity=IndividualSparsityMain(neural_activity,position,nrows_vector,ncols_vector,offset)

trackwidth=max(position(:,1))-min(position(:,1));
trackheight=max(position(:,2))-min(position(:,2));
neural_activity=neural_activity(:,1:end-offset);
position=position(offset+1:end,:);
sparsity_matrix=zeros(size(neural_activity,1),length(nrows_vector)*length(ncols_vector));
for i=1:length(nrows_vector)
    for k=1:length(ncols_vector)
        for j=1:size(neural_activity,1)
            sparsity_matrix(j,length(ncols_vector)*(i-1)+k)=calculateSparsity(neural_activity(j,:),position,nrows_vector(i),ncols_vector(k),trackwidth,trackheight);
        end
    end
end

sparsity=mean(sparsity_matrix,2);