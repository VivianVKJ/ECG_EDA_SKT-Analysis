clc;
clear all;

title={'People','2D','VR'};
for video=10:12
    disp(video);
    Name=num2str(video-1,'%02d');
    
%     Path='F:\Graduation Project\A Study Record\Week 16\Result\ECG\ECG-Mean\';
%     FileName=[Path,'Video',Name,'MeanRate.mat'];
%     File=[Path,'MeanRate.xlsx'];
%     load (FileName);
%     cell_ECG1=num2cell(ECG1);
%     MeanRate=[title;cell_ECG1];
%     xlswrite(File,MeanRate,video);
    
    Path2='F:\Graduation Project\A Study Record\Week 16\Result\ECG-Std\';
    FileName2=[Path2,'Video',Name,'StdRate.mat'];
    File2=[Path2,'StdRate.xlsx'];
    load (FileName2);
    cell_ECG2=num2cell(ECG2);
    StdRate=[title;cell_ECG2];
    xlswrite(File2,StdRate,video);    
    
    Path3='F:\Graduation Project\A Study Record\Week 16\Result\ECG-SDNN\';
    FileName3=[Path3,'Video',Name,'SDNN.mat'];
    File3=[Path3,'SDNN.xlsx'];
    load (FileName3);
    cell_ECG3=num2cell(ECG3);
    SDNN=[title;cell_ECG3];
    xlswrite(File3,SDNN,video);  
    
    Path4='F:\Graduation Project\A Study Record\Week 16\Result\ECG-SDSD\';
    FileName4=[Path4,'Video',Name,'SDSD.mat'];
    File4=[Path4,'SDSD.xlsx'];
    load (FileName4);
    cell_ECG4=num2cell(ECG4);
    SDSD=[title;cell_ECG4];
    xlswrite(File4,SDSD,video);
    
    Path5='F:\Graduation Project\A Study Record\Week 16\Result\SKT-Mean\';
    FileName5=[Path5,'Video',Name,'MeanSKT.mat'];
    File5=[Path5,'MeanSKT.xlsx'];
    load (FileName5);
    cell_SKT1=num2cell(SKT1);
    MeanSKT=[title;cell_SKT1];
    xlswrite(File5,MeanSKT,video);
    
    Path6='F:\Graduation Project\A Study Record\Week 16\Result\SKT-Std\';
    FileName6=[Path6,'Video',Name,'StdSKT.mat'];
    File6=[Path6,'StdSKT.xlsx'];
    load (FileName6);
    cell_SKT2=num2cell(SKT2);
    StdSKT=[title;cell_SKT2];
    xlswrite(File6,StdSKT,video);    
end
disp end;