clc;
clear all;
load RESULT;

mean=1;std=2; SDNN=3; SDSD=4;
TD=1;VR=2;
ECG=1; SKT=2; EDA=3;
Index=1; ValleyTime=2; PeakTime=3; Amplitude=4; RiseTime=5; Slope=6;EDRType=7;
title={'People','2D','VR'};

for video=1:12
     ECG1=[]; ECG2=[]; ECG3=[]; ECG4=[];
     SKT1=[]; SKT2=[];
     for people=1:30
        %% ECG & SKT
        if ~isempty(RESULT{1,people}{1,TD}{1,3}{1,video});

             lenthTD=length(RESULT{people}{TD}{3}{video}{ECG}(:,mean:mean));
             lenthVR=length(RESULT{people}{VR}{3}{video}{ECG}(:,mean:mean));
             lenthMin=min(lenthTD,lenthVR);
             index=people*ones(lenthMin,1);

             ECG1TD=RESULT{people}{TD}{3}{video}{ECG}(1:lenthMin,mean:mean);
             ECG1VR=RESULT{people}{VR}{3}{video}{ECG}(1:lenthMin,mean:mean);
             tempECG1=cat(2,index,ECG1TD,ECG1VR);
             ECG1=cat(1,ECG1,tempECG1);

             ECG2TD=RESULT{people}{TD}{3}{video}{ECG}(1:lenthMin,std:std);
             ECG2VR=RESULT{people}{VR}{3}{video}{ECG}(1:lenthMin,std:std);             
             tempECG2=cat(2,index,ECG1TD,ECG1VR);
             ECG2=cat(1,ECG2,tempECG2);

             ECG3TD=RESULT{people}{TD}{3}{video}{ECG}(1:lenthMin,SDNN:SDNN);
             ECG3VR=RESULT{people}{VR}{3}{video}{ECG}(1:lenthMin,SDNN:SDNN);             
             tempECG3=cat(2,index,ECG3TD,ECG3VR);
             ECG3=cat(1,ECG3,tempECG3);

             ECG4TD=RESULT{people}{TD}{3}{video}{ECG}(1:lenthMin,SDSD:SDSD);
             ECG4VR=RESULT{people}{VR}{3}{video}{ECG}(1:lenthMin,SDSD:SDSD);             
             tempECG4=cat(2,index,ECG4TD,ECG4VR);
             ECG4=cat(1,ECG4,tempECG4);

             SKT1TD=RESULT{people}{TD}{3}{video}{SKT}(1:lenthMin,mean:mean);
             SKT1VR=RESULT{people}{VR}{3}{video}{SKT}(1:lenthMin,mean:mean);             
             tempSKT1=cat(2,index,SKT1TD,SKT1VR);
             SKT1=cat(1,SKT1,tempSKT1);

             SKT2TD=RESULT{people}{TD}{3}{video}{SKT}(1:lenthMin,std:std);
             SKT2VR=RESULT{people}{VR}{3}{video}{SKT}(1:lenthMin,std:std);             
             tempSKT2=cat(2,index,SKT2TD,SKT2VR);
             SKT2=cat(1,SKT2,tempSKT2);
         end
     end
     fprintf('video%02d\n',video-1);
     %% Save File
     Name=num2str(video-1,'%02d');
%      Path='F:\Graduation Project\A Study Record\Week 16\Result\ECG\ECG-Mean\';
%      FileName=[Path,'Video',Name,'MeanRate.mat'];
%      save(string(FileName),'ECG1');
     
     Path2='F:\Graduation Project\A Study Record\Week 16\Result\ECG-Std\';
     FileName2=[Path2,'Video',Name,'StdRate.mat'];
     save(string(FileName2),'ECG2');

     Path3='F:\Graduation Project\A Study Record\Week 16\Result\ECG-SDNN\';
     FileName3=[Path3,'Video',Name,'SDNN.mat'];
     save(string(FileName3),'ECG3');
     
     Path4='F:\Graduation Project\A Study Record\Week 16\Result\ECG-SDSD\';
     FileName4=[Path4,'Video',Name,'SDSD.mat'];
     save(string(FileName4),'ECG4'); 
     
     Path5='F:\Graduation Project\A Study Record\Week 16\Result\SKT-Mean\';
     FileName5=[Path5,'Video',Name,'MeanSKT.mat'];
     save(string(FileName5),'SKT1'); 
     
     Path6='F:\Graduation Project\A Study Record\Week 16\Result\SKT-Std\';
     FileName6=[Path6,'Video',Name,'StdSKT.mat'];
     save(string(FileName6),'SKT2');      
end

            