%Analysis Version 1.1 
%10sec & EDA Peaks
clc;
clear all;
load RESULT;
load 'F:\Graduation Project\A Study Record\Week 12\watched.mat';
load lenVideo.mat;

% Second Step: (Version 1.1)
% revise version I from the RESULT File

mea=1;std=2; SDNN=3; SDSD=4;
TD=1;VR=2;
ECG=1; SKT=2; EDA=3;
Index=1; ValleyTime=2; PeakTime=3; Amplitude=4; RiseTime=5; Slope=6;EDRType=7;
title={'People','2D','VR'};
group={'2d','vr'};
lenVideo =zeros(1,12); % 10sec 


avrpeaks=zeros(12,6);
avrAmp=zeros(12,2);
avrSlope=zeros(12,2);

for video=1:12
    
    len=zeros(2,watched(1,video));
    lenEDA=zeros(6,watched(1,video));
    noempty=0;
    watchp=0; %watchp: num of people who watched this video
    for people=1:30
        if ~isempty(RESULT{1,people}{1,1}{1,3}{1,video})
            watchp=watchp+1;
            for cond=1:2
                len(cond,watchp)=length(RESULT{people}{cond}{3}{video}{ECG}(:,mea:mea)); %min length
                if (~isempty(RESULT{people}{TD}{3}{video}{EDA}) && ~isempty(RESULT{people}{VR}{3}{video}{EDA}))
                    lenEDA(cond,watchp)=length(RESULT{people}{cond}{3}{video}{EDA}(:,mea:mea)); % peaks of EDA
                    lenEDA(cond+2,watchp)=mean(RESULT{people}{cond}{3}{video}{EDA}(:,Amplitude:Amplitude)); % amp of EDA
                    lenEDA(cond+4,watchp)=mean(RESULT{people}{cond}{3}{video}{EDA}(:,Slope:Slope)); % slope of EDA
                    %fprintf('video%d, people=%d,cond=%d, lenEDA=%d\n',video,people,cond, lenEDA(cond,watchp));
                end
            end
        end
        
    end
    
     lenVideo(1,video)=min(min(len));
     disp(video);
     disp(lenEDA);
     %delete
     id1=lenEDA(1,:)<=0 & lenEDA(1,:)>=0;   %zeros in row 1
     lenEDA(:,id1)=[]; %delete columns
     id2=lenEDA(2,:)<=0 & lenEDA(2,:)>=0;   %zeros in row 2
     lenEDA(:,id2)=[]; %delete columns
     disp after;
     disp(lenEDA);
     avrpeaks(video,:)=mean(lenEDA,2);
end
disp(avrpeaks);
for t=1:3
    [h,p,ci,stats]=ttest(avrpeaks(:,t*2-1),avrpeaks(:,t*2));
    disp(p);
    disp(stats);
end

