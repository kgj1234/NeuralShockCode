function sparsity=SparsityMain(neural_activity,position,nrows_vector,ncols_vector,trackwidth,trackheight)
sparsity_per_box=zeros(size(neural_activity,1),length(nrows_vector)*length(ncols_vector));

for i=1:length(nrows_vector)
    for j=1:length(ncols_vector)
        
        sparsity_mat=shifted_sparsity(neural_activity,position,nrows_vector(i),ncols_vector(j),trackwidth,trackheight);
        for k=1:size(neural_activity,1)
            sparsity_per_box(k,(length(nrows_vector)-1)*j+i)=calculateSparsity(neural_activity(k,:),position,nrows_vector(i),ncols_vector(j),trackwidth,trackheight);
        end
        size(sparsity_mat)
        stdev=std(sparsity_mat,0,2);
        sparsity_per_box(:,(length(nrows_vector)-1)*j+i)=(sparsity_per_box(:,(length(nrows_vector)-1)*j+i)-mean(sparsity_mat,2))./stdev;
    end
end

sparsity=mean(sparsity_per_box,2);

