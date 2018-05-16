function plottingFiringBehaviorSpatialForSingleData(neuron,behav,firingRate,segment,threshFiring,temp,threshSpatial,experimentName)

%% This function is used to overlay the neuron activity onto behaviors
% Inputs:
%        (1) neuron: a source2D variable, including identified neurons with traces and spatial information, which is obtained by runing cnmfe codes
%        (2) behav: behavior information, which is obtained by using Tristan's code
%        (3) Segment: a vector, e.g,1:10 (display the traces of the first 10 identified neurons)
%        (4) downsampling rate [e.g., by a factor of 2]

% Important parameter in the code: thresh, the threshold above which the neuron is active. By default, it is 10% of the maximum trace value of each neuron
if ~exist('temp','var') || isempty(temp)
    temp = 'S';
end
if strcmpi(temp,'trace')
    dataFiring = neuron.trace;
elseif strcmpi(temp,'S')
    dataFiring = neuron.S;
end

% close all
folderName = 'FiguresFiringBehaviorSpatial';
if ~exist(folderName,'dir')
    mkdir(folderName);
end
fpath=folderName;

% figure

downsampling = length(neuron.time)/size(neuron.trace,2);
if downsampling ~= 1
    %     downsampling == 2
    neuron.time = double(neuron.time);
    neuron.time = neuron.time(1:downsampling:end);
end
temp = find(diff(behav.time)<=0);
behav.time(temp+1) = behav.time(temp)+1;
neuron.pos = interp1(behav.time,behav.position,neuron.time); %%

%
% thresh = 0;
numFig = 10;
k = 0;kk = 0;
for i = segment
    kk = kk+1;
    if mod(kk-1,numFig) == 0
        ax = figure;
        set(ax, 'Position', [100, 100, 600, 1000]);
        k = 0;
    end
    
    
    %   thresh = (max(neuron.S(i,:))-min(neuron.S(i,:)))*0.1; % the threshold above which the neuron is active
    thresh = threshFiring(i);
     k = k+1;

    idx = dataFiring(i,:)>thresh;
    %% ploting raw trace and its firing
    %     subplot(length(segment),3,3*k-2)
    subplot(numFig,3,3*k-2)
    %     subplot(5,2,plotPositionFiring)
    plot(neuron.trace(i,:), 'b')
    hold on
    plot(neuron.S(i,:),'r')
    title(['Cell' num2str(i)],'FontSize',8,'FontName','Arial')
    set(gca,'FontSize',8)
    %     plot([0 neuron.num2read],thresh*[1 1],'k--')
    axis tight
    %     xlim([0 neuron.num2read]);
    %     ylim([min([neuron.trace(i,:);neuron.firing(:,i)]) max([neuron.trace(:,i);neuron.firing(:,i)])])
    % ylim([min([ms.trace(:,i)]) max([ms.trace(:,i)])])
    hold off
    set(gca,'Xtick',[])
    if mod(kk,numFig) == 0 || kk == max(segment)
        set(gca,'Xtick',[1 ceil(neuron.num2read/2) neuron.num2read])
    end
    
    %% plotting animal behavior trajectries
    %     subplot(length(segment),3,3*k-1)
    subplot(numFig,3,3*k-1)
    %     subplot(5,2,plotPositionPos)
    plot(neuron.pos(:,1),neuron.pos(:,2),'k')
    hold on
    plot(neuron.pos(idx,1),neuron.pos(idx,2),'r.')
    title(['Cell' num2str(i)],'FontSize',8,'FontName','Arial')
    set(gca,'FontSize',8)
    axis image
    %     xlim([min(neuron.pos(:,1)) max(neuron.pos(:,1))]);
    %     ylim([min(neuron.pos(:,2)) max(neuron.pos(:,2))]);
    %     plot(ms.pos(idx2,1),ms.pos(idx2,2),'r.')
    hold off
    set(gca,'Xtick',[])
    if mod(kk,numFig) == 0 || kk == max(segment)
        set(gca,'Xtick',[1 ceil(neuron.num2read/2) neuron.num2read])
    end
    
    %% plot cell firing map
    maxCount = threshSpatial;
    firingRateSmoothing = filter2DMatrices(firingRate{i}, 1);
    firingRateSmoothing2 = nan(size(firingRateSmoothing)+1);
    firingRateSmoothing2(1:end-1,1:end-1) = firingRateSmoothing;
    %      subplot(length(segment),3,3*k)
    subplot(numFig,3,3*k)
    try
        pcolor(firingRateSmoothing2);
        
        colormap(jet)
        caxis([0,max(maxCount)])
%         colorbar('eastoutside');
        % set(gca, 'color', 'w', 'ydir', 'reverse')
        shading flat;
%         axis square
%         axis image
        % axis off
        title(['Cell #', num2str(i)],'FontName','Arial','FontSize',8,'FontWeight','bold')
        hold off

        if mod(kk,numFig) ~= 0 
            set(gca,'Xtick',[])
        end
        if mod(kk,numFig) == 0 
            colorbar('eastoutside');
        end
    catch
        continue;
    end
        
    if mod(kk,numFig) == 0 || kk == max(segment)
%         saveas(gcf,fullfile(fpath,strcat(experimentName,'CellFiringBeaviorSpatial',num2str(i),'.fig')))
        saveas(gcf,fullfile(fpath,strcat(experimentName,'CellFiringBeaviorSpatial',num2str(i),'.tif')))
    end
    
end
%     saveas(gcf,fullfile(fpath,strcat('CellFiringBeaviorSpatial','.tif')))
%     saveas(gcf,fullfile(fpath,strcat('CellFiringBeaviorSpatial','.fig')))

