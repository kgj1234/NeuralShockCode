function velocity=calculate_velocity(position,dt)
xvel=(position(1:end-1,1)-position(2:end,1))/dt;
xvel(end+1)=xvel(end);
yvel=(position(1:end-1,2)-position(2:end,2))/dt;
yvel(end+1)=yvel(end);

velocity=sqrt(xvel.^2+yvel.^2);