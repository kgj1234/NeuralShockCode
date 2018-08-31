function sparsity_matrix=shifted_sparsity(neural_activity,position,nrows,ncols,trackwidth,trackheight)
sparsity_matrix=zeros(size(neural_activity,1),200);
for i=1:200
    random_shift=floor(4000*(rand-1/2));
    while true
        if random_shift==0
            random_shift=floor(4000*(rand-1/2));
        else
            break
        end
    end
    if random_shift>0
        shifted_position=vertcat(position(random_shift+1:end,:),position(1:random_shift,:));
    else
        shifted_position=vertcat(position(end-abs(random_shift):end,:),position(1:end-abs(random_shift)-1,:));
    end
    for j=1:size(neural_activity,1)
        sparsity_matrix(j,i)=calculateSparsity(neural_activity(j,:),shifted_position,nrows,ncols,trackwidth,trackheight);
    end
end
        