function [mutual]=mutualPlaceCells(infoscore1,infoscore2,num)
infoscore1=vertcat(1:length(infoscore1),transpose(infoscore1));
infoscore2=vertcat(1:length(infoscore2),transpose(infoscore2));
infoscore1=sortrows(transpose(infoscore1),2);
infoscore2=sortrows(transpose(infoscore2),2);
infoscore1=infoscore1(end-num:end,1);
infoscore2=infoscore2(end-num:end,1);
mutual=intersect(infoscore1,infoscore2);


