clc;
clear all;

Rranova=table(); %create empty table
path='F:\Graduation Project\A Study Record\Week 16\Result\';
%load 'F:\Graduation Project\A Study Record\Week 16\Result\SKT-Mean\Video00MeanSKT';

%% 0.SKT-Mean
for video=1:12;
    Name=num2str(video-1,'%02d');
    FileName=[path,'SKT-Mean\Video',Name,'MeanSKT.mat'];
    disp(FileName);
    load(FileName);
    people=num2str(SKT1(:,1));   %Important!
    t=table(people,SKT1(:,2),SKT1(:,3),'VariableNames',{'People','TD','VR'});
    Cond=dataset([1,2]','VarNames',{'Condition'});
    rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
    re = ranova(rm);
    disp(re);
    Rranova(video,:)=re(1,:);
end;

%% 1.SKT-Std
for video=1:12;
    Name=num2str(video-1,'%02d');
    FileName=[path,'SKT-Std\Video',Name,'StdSKT.mat'];
    disp(FileName);
    load(FileName);
    people=num2str(SKT2(:,1));   %Important!
    t=table(people,SKT2(:,2),SKT2(:,3),'VariableNames',{'People','TD','VR'});
    Cond=dataset([1,2]','VarNames',{'Condition'});
    rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
    re = ranova(rm);
    Rranova(13+video,:)=re(1,:);
end;

%% 2.ECG-Mean
for video=1:12;
    Name=num2str(video-1,'%02d');
    FileName=[path,'ECG-Mean\Video',Name,'MeanRate.mat'];
    disp(FileName);
    load(FileName);
    people=num2str(ECG1(:,1));   %Important!
    t=table(people,ECG1(:,2),ECG1(:,3),'VariableNames',{'People','TD','VR'});
    Cond=dataset([1,2]','VarNames',{'Condition'});
    rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
    re = ranova(rm);
    Rranova(26+video,:)=re(1,:);
end;

%% 3.ECG-Std
for video=1:12;
    Name=num2str(video-1,'%02d');
    FileName=[path,'ECG-Std\Video',Name,'StdRate.mat'];
    disp(FileName);
    load(FileName);
    people=num2str(ECG2(:,1));   %Important!
    t=table(people,ECG2(:,2),ECG2(:,3),'VariableNames',{'People','TD','VR'});
    Cond=dataset([1,2]','VarNames',{'Condition'});
    rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
    re = ranova(rm);
    Rranova(39+video,:)=re(1,:);
end;

%% 4.SDNN
for video=1:12;
    Name=num2str(video-1,'%02d');
    FileName=[path,'ECG-SDNN\Video',Name,'SDNN.mat'];
    disp(FileName);
    load(FileName);
    people=num2str(ECG3(:,1));   %Important!
    t=table(people,ECG3(:,2),ECG3(:,3),'VariableNames',{'People','TD','VR'});
    Cond=dataset([1,2]','VarNames',{'Condition'});
    rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
    re = ranova(rm);
    Rranova(52+video,:)=re(1,:);
end;

%% 5.SDSD
for video=1:12;
    Name=num2str(video-1,'%02d');
    FileName=[path,'ECG-SDSD\Video',Name,'SDSD.mat'];
    disp(FileName);
    load(FileName);
    people=num2str(ECG4(:,1));   %Important!
    t=table(people,ECG4(:,2),ECG4(:,3),'VariableNames',{'People','TD','VR'});
    Cond=dataset([1,2]','VarNames',{'Condition'});
    rm = fitrm(t,'TD-VR~People','WithinDesign',Cond);
    re = ranova(rm);
    Rranova(65+video,:)=re(1,:);
end;
disp(Rranova);
