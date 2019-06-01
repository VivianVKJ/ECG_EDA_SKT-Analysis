clc;
clear all;
load 'F:\Graduation Project\A Study Record\Week 12\order.mat';
SignalPath='F:\Graduation Project\A Study Record\Week 16\Data\';
TDFormat='.2d.mat';
VRFormat='.vr.mat';

orderChan=1;
tenSecChan=2;
videoChan=3;
EDAChan=3;
fSample=1000;

for People=9:9
    for TDVR=1:1   %2D=1; VR=2;
       %% 0. Load File 
        Name=num2str(People,'%02d');
        if TDVR==1
            Format=TDFormat;
        else
            Format=VRFormat;
        end
        FileName=[SignalPath,Name,Format];
        %disp ([Name,Format]);
        load (FileName); 
        
        %1-ecg 2-skt 3-eda 4-rr 5-rate 6-event
        ecg=data(:,1:1); 
        skt=data(:,2:2); 
        interval=data(:,4:4);
        rate=data(:,5:5);

        %% 1. Get Event Mark;
        eventMark=zeros(1,16);
        count=0;
        for i=2:length(ecg)
            if data(i,6)==double(1);
                count=count+1;
                eventMark(count)=i;
                fprintf('count=%d, %d\n',count,i);
            end
        end
        videos=count/2;  %num of video the person watched
        fprintf('count=%d, videos=%d\n',count,videos);
    end
end
