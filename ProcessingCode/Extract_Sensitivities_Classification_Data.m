function []=Extract_Sensitivities_Classification_Data(bigbox,shockbox,len,folds,field,model_directory,neuron_subset)
%Saving Folders
sensitivity_folder='C:\Users\kgj1234\Desktop\mouse0\Data\ClassificationResults\SensitivityScores\';
accuracy_folder='C:\Users\kgj1234\Desktop\mouse0\Data\ClassificationResults\ClassificationScores\';
model_name=horzcat('Forest',field,'Length',num2str(len),'Folds',num2str(folds));
if isdir(horzcat(accuracy_folder,model_directory))==0
    mkdir(horzcat(accuracy_folder,model_directory));
    mkdir(horzcat(accuracy_folder,model_directory,'\Data\'));
    mkdir(horzcat(accuracy_folder,model_directory,'\Figures\'));
end    
if isdir(horzcat(sensitivity_folder,model_directory))==0
    mkdir(horzcat(sensitivity_folder,model_directory));
    mkdir(horzcat(sensitivity_folder,model_directory,'\Data\'));
    mkdir(horzcat(sensitivity_folder,model_directory,'\Figures\'));
end   
class_data_path=horzcat(accuracy_folder,model_directory,'\Data\');
class_figure_path=horzcat(accuracy_folder,model_directory,'\Figures\');
sens_data_path=horzcat(sensitivity_folder,model_directory,'\Data\');
sens_figure_path=horzcat(sensitivity_folder,model_directory,'\Figures\');
if isdir(horzcat(sens_figure_path,'SensitivityHistograms'))==0
    mkdir(horzcat(sens_figure_path,'SensitivityHistograms\'));
end
if isdir(horzcat(sens_figure_path,'SensitivityHeatmaps'))==0
    mkdir(horzcat(sens_figure_path,'SensitivityHeatmaps'));
end
Hist_path=horzcat(sens_figure_path,'SensitivityHistograms\');
Heat_path=horzcat(sens_figure_path,'SensitivityHeatmaps');



[acc,sens]=extract_train_test(bigbox,shockbox,len,folds,field,neuron_subset);
save(horzcat(class_data_path,model_name,'.mat'),'acc')
figs=figure();
plot(mean(acc,1));
title('Classification Accuracy')
ylabel('Accuracy')
xlabel('Experiment')
saveas(figs,horzcat(class_figure_path,model_name,'Mean.png'),'png')
close all
figs=figure();
plot(smooth(mean(acc,1)));
title('Classification Accuracy')
ylabel('Accuracy')
xlabel('Experiment')
saveas(figs,horzcat(class_figure_path,model_name,'MeanSmooth.png'),'png')
close all

save(horzcat(sens_data_path,model_name,'.mat'),'sens')
means=mean(sens,1);
save(horzcat(sens_data_path,model_name,'mean','.mat'),'means');
figs=imagesc(sens);
title('Sensitivities')
ylabel('Experiment')
xlabel('Neuron')
saveas(figs,horzcat(Heat_path,model_name,'.png'),'png')
close all
figs=imagesc(sens./max(sens,[],2));
title('Sensitivities Normalized')
ylabel('Experiment')
xlabel('Neuron')
saveas(figs,horzcat(Heat_path,model_name,'Normalized.png'),'png')
close all
figs=histogram(means);
ylabel('number of neurons');
ylabel('sensitivity')
saveas(figs,horzcat(Hist_path,model_name,'Histogram.png'),'png')
close all
means=vertcat(means,1:length(means))';
means=sortrows(means,1);
keep=floor(.1*size(means,1));
sensitivity=means(end-keep+1:end,2);
save(horzcat(sens_data_path,model_name,'sensitive.mat'),'sensitivity')


