clc;
close all;
clear all

%LOAD 2D VIDEO RECORD

load 'F:\Graduation Project\A Study Record\Week 12\order.mat';
load 'F:\Graduation Project\A Study Record\Week 12\Cut\5.2d-RR.mat';  
%1-ecg 2-skt 3-eda 4-rr 5-rate 6-event
%% 0. ToDo: Batch Process
% initialize parameters
ecg=data(:,1:1); %ecg:channel 1
interval=data(:,4:4); %rr-interval channel 4
rate=data(:,5:5); %ecg:channel 5

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

%% 2. Scan RR-interval
scanRR = zeros(fix(length(interval)/1000),3); %[RRi,RRi+1-RRi,sample]
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

%% 3. Create Record File;
tenSec = zeros(1,8);
disp(sum(tenSec));
for event=1:8
    tenSec(event)=fix((eventMark(2*event)-eventMark(2*event-1))/10000)+1;
end
recordFile=zeros(sum(tenSec)+2,9); % Column=[1(video)+4(2d)+4(vr)]
recordFile(1:1,1:8)=Order(5:5,2:9);  %[PeopleIndex,2d(2:10)]
recordFile(2:2,1:8)=tenSec(1:8);

%% 4. Features: Rate: Mean/Std; RR: SDNN/SDSD
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
        recordFile(index,1)=recordFile(1,event);
    end
    %   1   ||   2   ||  3   ||  4   ||  5
    % Index || meanR || stdR || SDNN || SDSD
    for i=0:(tenSec(event)-1) 
        % signal front & tail
        front=eventMark(2*event-1)+i*10000;
        if i<(tenSec(event)-1)
            tail=eventMark(2*event-1)+i*10000+9999;
        else 
            tail=eventMark(2*event);
        end
        fprintf('front=%d,tail=%d\n',front,tail);        
        
        recordFile(recordFront+i,2:2)=mean(rate(front:tail)); %meanR
        recordFile(recordFront+i,3:3)=std(rate(front:tail));  %stdR

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
        
        recordFile(recordFront+i,4:4)=std(scanRR(ffront:ttail,1:1)); %SDNN
        recordFile(recordFront+i,5:5)=std(scanRR(ffront:ttail,2:2)); %SDSD
        
    end
end    
disp ECGend;

