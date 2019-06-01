clc;
clear all;
load RESULT;

TD=1;VR=2;
EDAchan=3;
title={'People','2D','VR'};
Feature=char('Index','TValley','TPeak','Amplitude','RiseTime','Slope','EDRtype');
lenF=[5,7,5,9,8,5];
Index=1; ValleyTime=2; PeakTime=3; Amplitude=4; RiseTime=5; Slope=6;EDRType=7;
Path='F:\Graduation Project\A Study Record\Week 16\Result\';

% for f=2:6
%     disp(lenF(f));
%     disp(Feature(f,1:lenF(f)));
%     folder=[Path,'EDA-',Feature(f,1:lenF(f)),'\'];
%     disp(folder);
%     mkdir(string(folder));
% end
for f=2:6
    for video=1:12
        EDA=[];
        Name=num2str(video-1,'%02d');
        disp(Name);
        % Result\EDA-TValley
        for people=1:30
            %% EDA
            if ~isempty(RESULT{1,people}{1,TD}{1,3}{1,video});
                lenthTD=length(RESULT{people}{TD}{3}{video}{EDAchan}(:,Index));
                lenthVR=length(RESULT{people}{VR}{3}{video}{EDAchan}(:,Index));
                lenthMin=min(lenthTD,lenthVR);
                if lenthMin>0 
                    %match nearest? & flag mark
                    for numpeak=1:lenthMin
                      
%                     noP=people*ones(lenthMin,1);
%                         EDATD=RESULT{people}{TD}{3}{video}{EDAchan}(1:lenthMin,f);
%                         EDAVR=RESULT{people}{VR}{3}{video}{EDAchan}(1:lenthMin,f);
%                         tempEDA=cat(2,noP,EDATD,EDAVR);
%                         %disp(tempEDA);
%                         EDA=cat(1,EDA,tempEDA);
                    end
                end  %endif
            end        
        end %30 people end
        %disp(Feature(f,:));
        %disp(EDA);
        %save file
        presult=[Path,'EDA-',Feature(f,1:lenF(f)),'\'];
        file=[presult,'Video',Name,Feature(f,1:lenF(f)),'.mat'];
        disp(file);
        FilePath=string(file);
        save(FilePath,'EDA');
    end
end
            