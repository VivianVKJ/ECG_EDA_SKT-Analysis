%analysis 2
clc;
clear all;
load RESULT;
load 'F:\Graduation Project\A Study Record\Week 12\watched.mat';
load lenVideo.mat;

% Second Step: (Version 1.2)
% Creat RESULT2.mat
% mean of all participants

mea=1;std=2; SDNN=3; SDSD=4;
TD=1;VR=2;
ECG=1; SKT=2; EDA=3;
title={'People','2D','VR'};
group={'2d','vr'};
lenVideo =zeros(1,12);


for video=1:12
    len=zeros(2,watched(1,video));
    watchp=0;
    for people=1:30
        if ~isempty(RESULT{1,people}{1,1}{1,3}{1,video})
            watchp=watchp+1;
            for cond=1:2
                len(cond,watchp)=length(RESULT{people}{cond}{3}{video}{ECG}(:,mea:mea));
            end
        end
    end
    lenVideo(1,video)=min(min(len));
end
RESULT2=cell(1,12);
% 每个视频：30个人的平均
compare=3;
cond=1; %2d
for cond=1:2
    for video=1:12
        temp=[];
        watchp=0;
        for people=1:30
            if ~isempty(RESULT{1,people}{1,1}{1,3}{1,video})   %非空，就把
                watchp=watchp+1;
                temp1=cat(2,temp,(RESULT{people}{cond}{3}{video}{ECG}(1:lenVideo(video),mea:mea)));
                temp2=cat(2,temp,(RESULT{people}{cond}{3}{video}{ECG}(1:lenVideo(video),std:std)));
                temp3=cat(2,temp,(RESULT{people}{cond}{3}{video}{ECG}(1:lenVideo(video),SDNN:SDNN)));
                temp4=cat(2,temp,(RESULT{people}{cond}{3}{video}{ECG}(1:lenVideo(video),SDSD:SDSD)));
                temp5=cat(2,temp,(RESULT{people}{cond}{3}{video}{SKT}(1:lenVideo(video),mea:mea)));
                temp6=cat(2,temp,(RESULT{people}{cond}{3}{video}{SKT}(1:lenVideo(video),std:std)));  
            end
        end
        RESULT2{video}{cond}{ECG}{mea}=temp1; 
        RESULT2{video}{cond}{ECG}{std}=temp2; 
        RESULT2{video}{cond}{ECG}{SDNN}=temp3; 
        RESULT2{video}{cond}{ECG}{SDSD}=temp4; 
        RESULT2{video}{cond}{SKT}{mea}=temp5; 
        RESULT2{video}{cond}{SKT}{std}=temp6;         
    end
end

%整体全部求平均的方法
ano=table();
tECGSKT=zeros(6,12);

%SKT
for fea=1:2
    for video=1:12
        %mean(A,2)=mean of column
        if ~isempty(RESULT2{video}{TD}{SKT}{fea})             
            %disp(mean(RESULT2{video}{TD}{ECG}{mea}));
            RESULT2{video}{compare}{fea}=cat(2,mean(RESULT2{video}{TD}{SKT}{fea},2),mean(RESULT2{video}{VR}{SKT}{fea},2));
%             [p,tb1]=anova1( RESULT2{video}{compare}{fea+4},group,'off');
%             ano((fea-1)*13+video,:)=tb1(2,:);
            tECGSKT(fea,video)=ttest(mean(RESULT2{video}{TD}{SKT}{fea},2),mean(RESULT2{video}{VR}{SKT}{fea},2));
        end
    end
end
for fea=1:4
    for video=1:12
        %mean(A,2)=mean of column
        if ~isempty(RESULT2{video}{TD}{ECG}{fea})             
            %disp(mean(RESULT2{video}{TD}{ECG}{mea}));
             RESULT2{video}{compare}{fea}=cat(2,mean(RESULT2{video}{TD}{ECG}{fea},2),mean(RESULT2{video}{VR}{ECG}{fea},2));
%             [p,tb1]=anova1( RESULT2{video}{compare}{fea},group,'off');
%             ano((fea+1)*13+video,:)=tb1(2,:);
            tECGSKT(fea+2,video)=ttest(mean(RESULT2{video}{TD}{ECG}{fea},2),mean(RESULT2{video}{VR}{ECG}{fea},2));
        end
    end
end
disp(tECGSKT);

% displayMean=cell(1,2);
% mECGALL=[];
% mSKTALL=[];
% for video=1:12
%     mECGALL=cat(1,mECGALL,RESULT2{video}{compare}{1});
%     mSKTALL=cat(1,mSKTALL,RESULT2{video}{compare}{5});
% end
% displayMean{1}=mECGALL;
% displayMean{2}=mSKTALL;
% xlswrite('F:\Graduation Project\A Study Record\Week 16\Result\Ranova.xlsx',mECGALL,5);
% xlswrite('F:\Graduation Project\A Study Record\Week 16\Result\Ranova.xlsx',mSKTALL,6);
% for video=1:12
%     subplot(2,6,video)
%     plot(RESULT2{video}{compare}{1})
% end

% for video=1:12
%     subplot(2,6,video)
%     plot(RESULT2{video}{compare}{5})
% end