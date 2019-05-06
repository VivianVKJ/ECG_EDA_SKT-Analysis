clc;
close all;
clear all

%2D VIDEO RECORD

load 'F:\Graduation Project\A Study Record\Week 12\order.mat';
load 'F:\Graduation Project\A Study Record\Week 12\Cut\5.2d-RR.mat';  
%1-ecg 2-skt 3-eda 4-rr 5-rate 6-event
%% 0. ToDo: Batch Process
% Initial Parameters

ecg=data(:,1:1); 
skt=data(:,2:2); 
interval=data(:,4:4); 
rate=data(:,5:5);
EDAChan=3;
fSample=1000;

%% 1. Get Event Mark;
eventMark=zeros(1,16);
count=0;
for i=2:length(ecg)
    if data(i,6)==double(1);
        count=count+1;
        eventMark(count)=i;
    end
end

if length(eventMark)~=16
    error('EventMark Wrong');
end

%% 2. Create Record File;
%  2.1 ECG
tenSec = zeros(1,8);
disp(sum(tenSec));
for event=1:8
    tenSec(event)=fix((eventMark(2*event)-eventMark(2*event-1))/(10*fSample))+1;
end
RecordECG_SKT=zeros(sum(tenSec)+2,13); % [1(video)+6(2d)*2]
RecordECG_SKT(1:1,1:8)=Order(5:5,2:9);  %[PeopleIndex,2d(2:10)]
RecordECG_SKT(2:2,1:8)=tenSec(1:8);
%  2.2 EDA
RecordEDA=zeros(2,8); %video & index
RecordEDA(1,1:8)=Order(5:5,2:9);

%% 3.1 ECG: Scan RR-interval
scanRR = zeros(fix(length(interval)/fSample),3); %[RRi,RRi+1-RRi,sample]
j=1;   %index of scanRR
scanRR(j,1)=interval(1);
scanRR(j,3)=1;
for i=2:length(interval)  
    if(interval(i)~= scanRR(j,1))
        j=j+1;
        scanRR(j,1)=interval(i);
        scanRR(j,3)=i;
    end
end
scanRR(2:length(scanRR),2:2)=abs(diff(scanRR(:,1:1)));

%% 3.2. ECG Features: Rate: Mean/Std; RR: SDNN/SDSD
for event=1:8
    fprintf('event=%d,tenSec=%d\n',event,tenSec(event));
    % recordFront & recordTail
    if(event==1)
        recordFront=3;
    else
        recordFront=2+sum(tenSec(1:event-1))+1;
    end
    recordTail=2+sum(tenSec(1:event));
    fprintf('recordFront=%d,recordTail=%d\n',recordFront,recordTail);
    for index=recordFront:recordTail
        RecordECG_SKT(index,1)=RecordECG_SKT(1,event);
    end
    %   1   (||   2   ||  3   ||  4   ||  5   ||   6    ||  7   )
    % Index (|| meanR || stdR || SDNN || SDSD || meanST || stdST)

    for i=0:(tenSec(event)-1) 
        % direct signal front & tail
        front=eventMark(2*event-1)+i*(10*fSample);
        if i<(tenSec(event)-1)
            tail=eventMark(2*event-1)+i*(10*fSample)+(10*fSample)-1;
        else 
            tail=eventMark(2*event);
        end
        fprintf('front=%d,tail=%d\n',front,tail);        
        
        RecordECG_SKT(recordFront+i,2:2)=mean(rate(front:tail)); %meanR
        RecordECG_SKT(recordFront+i,3:3)=std(rate(front:tail));  %stdR
        RecordECG_SKT(recordFront+i,6:6)=mean(skt(front:tail)); %meanST
        RecordECG_SKT(recordFront+i,7:7)=std(skt(front:tail));  %stdST
        
        % indirect signal ffront & ttail
        [~,ffront]=min(abs(scanRR(:,3:3)-front)); 
        if scanRR(ffront,3)<front
            ffront = ffront-1;
        end
        [~,ttail]=min(abs(scanRR(:,3:3)-tail));
        if scanRR(ffront,3)<tail
            ttail = ttail-1;
        end
        if (ttail-ffront)<1
            ffront=ttail-1;   % NOT ACCURATE!
        end
        fprintf('ffront=%d,ttail=%d\n',ffront,ttail); 
        fprintf('front2=%d,tail2=%d\n\n',scanRR(ffront,3),scanRR(ttail,3)); 
        
        RecordECG_SKT(recordFront+i,4:4)=std(scanRR(ffront:ttail,1:1)); %SDNN
        RecordECG_SKT(recordFront+i,5:5)=std(scanRR(ffront:ttail,2:2)); %SDSD
        
        
    end
end    
disp ECGend;
%% 4 EDA
for event=1:8
   %fprintf('event=%d',event);
   front=event*2-1;
   tail=event*2;
   eda=data(eventMark(front)-2*fSample:eventMark(tail),EDAChan);
   
   %4.1 Default Filter
   [edaout]=eda_filt(eda,fSample,'default');   
   edr=eda_edr(edaout,fSample); %Electrodermal Response Detection

   %VideoNo.|Index|ValleyTime|tPeakTime|Amplitude|RiseTime|Slope|EDRtype
   VideoIndex=RecordEDA(1,event)*ones(numel(edr.iPeaks),1);
   RecordEDA(2,event)=numel(edr.iPeaks);
   tempR=(eda_saveraw(eda,fSample,edr))'; %tempR:7 Column
   tempR=cat(2,VideoIndex,tempR); %tempR:8 Column
   
   RecordEDA=cat(1,RecordEDA,tempR);
end
%disp(RecordEDA);
disp EDAEnd;
process={RecordECG_SKT,RecordEDA};



