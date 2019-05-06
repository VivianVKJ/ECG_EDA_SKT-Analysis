clc;
clear all;
load 'F:\Graduation Project\A Study Record\Week 12\order.mat';
load 'F:\Graduation Project\A Study Record\Week 15\EDA-master\Data\5.2d-RR.mat';  %3-eda

eventMark=zeros(1,16);
RecordEDA=zeros(2,8); %video & index
RecordEDA(1,1:8)=Order(5:5,2:9);

count=0;
for i=2:length(data)
    if data(i,6)==double(1);
        count=count+1;
        eventMark(count)=i;
    end
end

nChan=3;
fs=1000;
for event=1:8
   %fprintf('event=%d',event);
   front=event*2-1;
   tail=event*2;
   eda=data(eventMark(front)-2000:eventMark(tail),nChan);
   [edaout]=eda_filt(eda,fs,'default');   
   edr=eda_edr(edaout,fs);
   disp edr;
   disp(edr);
   %VideoNo.|Index|ValleyTime|tPeakTime|Amplitude|RiseTime|Slope|EDRtype'
   VideoIndex=RecordEDA(1,event)*ones(numel(edr.iPeaks),1);
   RecordEDA(2,event)=numel(edr.iPeaks);
   disp(VideoIndex);
   tempR=(eda_saveraw(eda,fs,edr))'; %tempR:7 Column
   tempR=cat(2,VideoIndex,tempR); %tempR:8 Column
%    disp tempR;
%    disp(tempR);
   %cat record
   RecordEDA=cat(1,RecordEDA,tempR);
end
disp(RecordEDA);



