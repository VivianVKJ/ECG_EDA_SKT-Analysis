clc;
close all;
clear all

load 'F:\Graduation Project\A Study Record\Week 12\order.mat';
load 'F:\Graduation Project\A Study Record\Week 12\order.mat';
SignalPath='F:\Graduation Project\A Study Record\Week 16\Data\';
TDFormat='.2d.mat';
VRFormat='.vr.mat';
RESULT=cell(1,30); %Final File for all results

% Initial Parameters
orderChan=1;
tenSecChan=2;
videoChan=3;
EDAChan=3;
fSample=1000;

for People=4:5
    for TDVR=1:2   %2D=1; VR=2;
       %% 0. Load File 
        Name=num2str(People,'%02d');
        if TDVR==1
            Format=TDFormat;
        else
            Format=VRFormat;
        end
        FileName=[SignalPath,Name,Format];
        disp ([Name,Format]);
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
            end
        end
        videos=count/2;  %num of video the person watched
        fprintf('count=%d, videos=%d\n',count,videos);
       %%  2.Order & TenSec
        RESULT{People}{TDVR}{orderChan}=Order(People,2+(TDVR-1)*8:videos+1+(TDVR-1)*8); %2d Order
        disp (RESULT{People}{TDVR}{orderChan});
        
        tenSec = zeros(1,videos);
        for event=1:videos
            tenSec(event)=fix((eventMark(2*event)-eventMark(2*event-1))/(10*fSample))+1;
        end
        RESULT{People}{TDVR}{tenSecChan}=tenSec(1:videos); 
        disp ( RESULT{People}{TDVR}{tenSecChan});
       %%  3.1 ECG: Scan RR-interval
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

        for event=1:videos
            video=RESULT{People}{TDVR}{orderChan}(1,event); %2d Order(event)=video num
            fprintf('event=%d,video=%d\n',event,video);
            ECG=zeros(tenSec(event),4);  % meanR || stdR || SDNN || SDSD 
            SKT=zeros(tenSec(event),2);  % meanST || stdST

            for i=1:tenSec(event)
                % direct signal front & tail
                front=eventMark(2*event-1)+i*(10*fSample);
                if i<(tenSec(event)-1)
                    tail=eventMark(2*event-1)+i*(10*fSample)+(10*fSample)-1;
                else 
                    tail=eventMark(2*event);
                end

                ECG(i,1)=mean(rate(front:tail)); %meanR
                ECG(i,2)=std(rate(front:tail));  %stdR

                SKT(i,1)=mean(skt(front:tail)); %meanST
                SKT(i,2)=std(skt(front:tail));  %stdST

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
                %fprintf('ffront=%d,ttail=%d\n',ffront,ttail); 
                %fprintf('front2=%d,tail2=%d\n\n',scanRR(ffront,3),scanRR(ttail,3)); 

                ECG(i,3)=std(scanRR(ffront:ttail,1:1)); %SDNN
                ECG(i,4)=std(scanRR(ffront:ttail,2:2)); %SDSD

            end
            
            
            %EDA
           eda=data(eventMark(event*2-1)-2*fSample:eventMark(event*2),EDAChan);

           [edaout]=eda_filt(eda,fSample,'default');   
           edr=eda_edr(edaout,fSample); %Electrodermal Response Detection
           EDA=(eda_saveraw(eda,fSample,edr))'; %tempR:7 Column
           %
           RESULT{People}{TDVR}{3}{video+1}={ECG,SKT,EDA};
        end;
        disp End;
    end 
end

