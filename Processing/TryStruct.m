clc;
clear all;

People=cell(2,1);
TDVR=1;
orderChan=1;
tenSecChan=2;
videoChan=3;

People{TDVR}{orderChan}=[4,2,5,8,1,6,3,7]; %2d Order
People{TDVR}{tenSecChan}=[1,2,3,4,5,6,7,8]; %2d Tensec
People{TDVR}{videoChan}=cell(12,1);
video=5;
ECG=ones(3,4);
SKT=2*ones(3,2);
EDA=3*ones(7,7);

People{TDVR}{videoChan}{video}={ECG,SKT,EDA};



