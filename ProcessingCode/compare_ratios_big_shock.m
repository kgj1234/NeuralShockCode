function compare_ratios_big_shock(bigbox,shockbox,field,flatten_option)
%flatten_option one of 5 strings:
%mean,mean_positive,sum,sum_positive,sum_spikes


main_path='C:\Users\kgj1234\Desktop\mouse0\Data\Firing Rate Comparisons\';
mkdir(horzcat(main_path,'ShockBox BigBox Comparisons'), horzcat('Comparison',field,flatten_option,'Ratio'));
Comparison_Path=horzcat(main_path,'ShockBox BigBox Comparisons\', horzcat('Comparison',field,flatten_option,'Ratio\'));
bigboxval=zeros(length(bigbox),size(bigbox{1}.C,1));
shockboxval=zeros(length(shockbox),size(shockbox{1}.C,1));
for i=1:length(bigbox);
    
    neural_activity1=getfield(bigbox{i},field);
    neural_activity2=getfield(shockbox{i},field);
    if isequal(flatten_option,'mean')
        bigboxval(i,:)=mean(neural_activity1,2);
        shockboxval(i,:)=mean(neural_activity2,2);
    elseif isequal(flatten_option,'sum')    
        bigboxval(i,:)=sum(neural_activity1,2);
        shockboxval(i,:)=sum(neural_activity2,2);
    elseif isequal(flatten_option,'mean_positive')
        for j=1:size(neural_activity1,1)
            bigboxval(i,j)=mean(neural_activity1(j,neural_activity1(j,:)>0));
            shockboxval(i,j)=mean(neural_activity2(j,neural_activity2(j,:)>0));
        end
    elseif isequal(flatten_option,'sum_positive')
        for j=1:size(neural_activity1,1)
            bigboxval(i,j)=sum(neural_activity1(j,neural_activity1(j,:)>0));
            shockboxval(i,j)=sum(neural_activity2(j,neural_activity2(j,:)>0));
        end
    else
        
        bigboxval(i,:)=sum(neural_activity1>0,2);
        shockboxval(i,:)=sum(neural_activity2>0,2);
    end
    
end

save(horzcat(main_path,'Big Box\Data\','bigbox',field,flatten_option,'.mat'),'bigboxval')
save(horzcat(main_path,'Shock Box\Data\','shockbox',field,flatten_option,'.mat'),'shockboxval')
figs=plot_heatmap(bigboxval,'neurons','experiments',flatten_option,false);
saveas(figs,horzcat(main_path,'Big Box\Figures\','bigbox',field,flatten_option,'.png'),'png')
close all


figs=plot_heatmap(bigboxval,'neurons','experiments',flatten_option,true);
saveas(figs,horzcat(main_path,'Big Box\Figures\','bigbox',field,flatten_option,'Normalized.png'),'png')
close all
figs=plot_heatmap(shockboxval,'neurons','experiments',flatten_option,false);
saveas(figs,horzcat(main_path,'Shock Box\Figures\','shockbox',field,flatten_option,'.png'),'png')
close all


figs=plot_heatmap(shockboxval,'neurons','experiments',flatten_option,true);
saveas(figs,horzcat(main_path,'Shock Box\Figures\','shockbox',field,flatten_option,'Normalized.png'),'png')
close all

Comparisonbigovershock=bigboxval./shockboxval;

Comparisonbigovershock(Comparisonbigovershock>30)=30;
Comparisonbigovershock(isnan(Comparisonbigovershock))=1;

Comparisonshockoverbig=shockboxval./bigboxval;

Comparisonshockoverbig(Comparisonshockoverbig>30)=30;
Comparisonshockoverbig(isnan(Comparisonshockoverbig))=1;

mkdir(Comparison_Path, 'Data');
mkdir(Comparison_Path, 'Figures');
save(horzcat(Comparison_Path,'Data\','ratiobigovershock.mat'),'Comparisonbigovershock')
save(horzcat(Comparison_Path,'Data\','ratioshockoverbig.mat'),'Comparisonshockoverbig')

figs=plot_heatmap(Comparisonbigovershock,'neuron','experiment','Ratio bigbox over shockbox',false);
saveas(figs,horzcat(Comparison_Path,'Figures\','ratiobigovershock.png'),'png');
close all
figs=plot_heatmap(Comparisonshockoverbig,'neuron','experiment','Ratio shockbox over bigbox',false);
saveas(figs,horzcat(Comparison_Path,'Figures\','ratioshockoverbig.png'),'png')
close all
Comparisonbigovershockcapped=Comparisonbigovershock;

Comparisonbigovershockcapped(Comparisonbigovershockcapped>12)=12;
Comparisonshockoverbigcapped=Comparisonshockoverbig;

Comparisonshockoverbigcapped(Comparisonshockoverbigcapped>12)=12;

figs=plot_heatmap(Comparisonbigovershockcapped,'neuron','experiment','Ratio bigbox over shockbox: Capped',false);
saveas(figs,horzcat(Comparison_Path,'Figures\','ratiobigovershockcapped.png'),'png');
close all
figs=plot_heatmap(Comparisonshockoverbig,'neuron','experiment','Ratio shockbox over bigbox: Capped',false);
saveas(figs,horzcat(Comparison_Path,'Figures\','ratioshockoverbigcapped.png'),'png')
close all


Comparisonbigovershockmean=mean(Comparisonbigovershockcapped,1);
Comparisonshockoverbigmean=mean(Comparisonshockoverbigcapped,1);
save(horzcat(Comparison_Path,'Data\','ratiobigovershockmean.mat'),'Comparisonbigovershockmean')
save(horzcat(Comparison_Path,'Data\','ratioshockoverbigmean.mat'),'Comparisonshockoverbigmean')

figs=histogram(Comparisonbigovershockmean);
title('big over shock mean')
xlabel('ratio values')
ylabel('number of neurons')
saveas(figs,horzcat(Comparison_Path,'Figures\','histogrammeanbigboxovershockbox.png'),'png')
close all
figs=histogram(Comparisonshockoverbigmean);
title('shock over big mean')
xlabel('ratio values')
ylabel('number of neurons')

saveas(figs,horzcat(Comparison_Path,'Figures\','histogrammeanshockboxoverbigbox.png'),'png')
close all
perc=floor(.1*length(Comparisonbigovershockmean));
Comparisonbigovershockmean=vertcat(Comparisonbigovershockmean,1:length(Comparisonbigovershockmean))';
Comparisonbigovershockmean=sortrows(Comparisonbigovershockmean,1);
bigboxpreferential=Comparisonbigovershockmean(end-perc:end,2)';
save(horzcat(Comparison_Path,'Data\bigboxpreferential.mat'),'bigboxpreferential')
Comparisonshockoverbigmean=vertcat(Comparisonshockoverbigmean,1:length(Comparisonshockoverbigmean))';
Comparisonshockoverbigmean=sortrows(Comparisonshockoverbigmean,1);
shockboxpreferential=Comparisonshockoverbigmean(end-perc:end,2)';
save(horzcat(Comparison_Path,'Data\shockboxpreferential.mat'),'shockboxpreferential')

mkdir(horzcat(Comparison_Path, 'Figures'), 'ShockBoxPreferential')
mkdir(horzcat(Comparison_Path,'Figures'),'BigboxPreferential')
for i=bigboxpreferential
    figs=figure();
    plot(smooth(Comparisonbigovershockcapped(:,i)))
    title(horzcat('Neuron', num2str(i)));
    xlabel('experiments')
    ylabel('ratio')
    saveas(figs,horzcat(Comparison_Path,'Figures/BigBoxPreferential/Neuron',num2str(i),'.png'),'png')
    close all
end
for i=shockboxpreferential
    figs=figure();
    plot(smooth(Comparisonshockoverbigcapped(:,i)))
    title(horzcat('Neuron', num2str(i)));
    xlabel('experiments')
    ylabel('ratio')
    saveas(figs,horzcat(Comparison_Path,'Figures/ShockBoxPreferential/Neuron',num2str(i),'.png'),'png')
    close all
end

    
