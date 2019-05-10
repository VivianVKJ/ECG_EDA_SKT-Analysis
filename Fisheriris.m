clc;
clear all;

% load fishseriris;
% t = table(species,meas(:,1),meas(:,2),meas(:,3),meas(:,4),'VariableNames',
% ...{'species','meas1','meas2','meas3','meas4'});
% Meas = dataset([1 2 3 4]','VarNames',{'Measurements'});
% rm = fitrm(t,'meas1-meas4~species','WithinDesign',Meas);
% _________________________________________________________________________

load 'F:\Graduation Project\A Study Record\Week 16\Result\SKT-Mean\Video00MeanSKT';
people=num2str(SKT1(:,1));   %Important!
t=table(people,SKT1(:,2),SKT1(:,3),'VariableNames',{'People','TD','VR'});
Cond=dataset([1,2]','VarNames',{'Condition'});
rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
re = ranova(rm);
disp(Rranova);
