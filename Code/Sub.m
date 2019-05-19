clc;
clear all;
load Subjective.mat;
load SSQ.mat;
SubResult=cell(2,2);
SubResult{1,1}='PANAS';
SubResult{1,2}='SSQ';

preTD=[]; poTD=[];
preVR=[]; poVR=[];

    for people=1:29
       preTD=cat(1,preTD,Sub((people-1)*4+1,:));
       poTD=cat(1,poTD,Sub((people-1)*4+2,:));
       preVR=cat(1,preVR,Sub((people-1)*4+3,:));
       poVR=cat(1,poVR,Sub(people*4,:));
    end  

    SubResult{2,1}{1,1}='pre2D';
    SubResult{2,1}{2,1}=preTD;

    SubResult{2,1}{1,2}='po2D';
    SubResult{2,1}{2,2}=poTD;

    SubResult{2,1}{1,3}='preVR';
    SubResult{2,1}{2,3}=preVR;

    SubResult{2,1}{1,4}='preVR';
    SubResult{2,1}{2,4}=poVR;


    for i=1:4
        disp(sum(SubResult{2,1}{2,i}(1:18,:)));
        SubResult{2,1}{3,i}=sum(SubResult{2,1}{2,i}(:,1:18));  %2*9 Items
    end

preTD=[]; poTD=[];
preVR=[]; poVR=[];
    
    for people=1:28
       preTD=cat(1,preTD,SSQ((people-1)*4+1,:));
       poTD=cat(1,poTD,SSQ((people-1)*4+2,:));
       preVR=cat(1,preVR,SSQ((people-1)*4+3,:));
       poVR=cat(1,poVR,SSQ(people*4,:));
    end  

    SubResult{2,2}{1,1}='pre2D';
    SubResult{2,2}{2,1}=preTD;

    SubResult{2,2}{1,2}='po2D';
    SubResult{2,2}{2,2}=poTD;

    SubResult{2,2}{1,3}='preVR';
    SubResult{2,2}{2,3}=preVR;

    SubResult{2,2}{1,4}='poVR';
    SubResult{2,2}{2,4}=poVR;

    for i=1:4
        disp(sum(SubResult{2,2}{2,i}(1:16,:)));
        SubResult{2,2}{3,i}=sum(SubResult{2,2}{2,i}(:,1:16));  %2*9 Items
    end

    
% %PANAS
% tcompare=zeros(1,18);
% group={'2d','vr'};
% tresult=zeros(2,18);
% 
% %求和做均值
% %去除基线做配对样本T检验
% [hPA,tPA]=ttest(SubResult{2,1}{3,2}(1,1:9)-SubResult{2,1}{3,1}(1,1:9),SubResult{2,1}{3,4}(1,1:9)-SubResult{2,1}{3,3}(1,1:9));
% [hNA,tNA]=ttest(SubResult{2,1}{3,2}(1,10:18)-SubResult{2,1}{3,1}(1,10:18),SubResult{2,1}{3,4}(1,10:18)-SubResult{2,1}{3,3}(1,10:18));
% 
% for item= 1:18
% %逐个item做配对样本T检验
%     [h1,tresult(1,item)]=ttest(SubResult{2,1}{2,1}(:,item),SubResult{2,1}{2,2}(:,item)); %pre2D--pre2D
%     [h2,tresult(2,item)]=ttest(SubResult{2,1}{2,3}(:,item),SubResult{2,1}{2,4}(:,item)); %preVR--poVR
% end

% SSQ

%   啥也没算出来！！！！！！！！
group={'2d','vr'};
tS=zeros(2,18);

% anova:            po-pre;  po-pre
[ps,tbs,stats]=anova1([(SubResult{2,2}{3,2}(1,:)-SubResult{2,2}{3,1}(1,:))',(SubResult{2,2}{3,4}(1,1:16)-SubResult{2,2}{3,3}(1,1:16))'],group,'off');
[hSS,pSS,ciSS,statsSS] =ttest(SubResult{2,2}{3,2}(1,1:16)-SubResult{2,2}{3,1}(1,1:16),SubResult{2,2}{3,4}(1,1:16)-SubResult{2,2}{3,3}(1,1:16));

anoSSQ=table();
for item= 1:16
%逐个item做配对样本T检验
    [h3,tS(1,item)]=ttest(SubResult{2,2}{2,1}(:,item),SubResult{2,2}{2,2}(:,item)); %pre2D--po2D
    [h4,tS(2,item)]=ttest(SubResult{2,2}{2,3}(:,item),SubResult{2,2}{2,4}(:,item)); %preVR--poVR
    %[p1,tb1]=anova1([SubResult{2,2}{2,1}(:,item),SubResult{2,2}{2,2}(:,item)],group,'off');
    [p2,tb2]=anova1([SubResult{2,2}{2,3}(:,item),SubResult{2,2}{2,4}(:,item)],group,'off');
    anoSSQ(item,:)=tb2(2,:);%????????????????????????????????????????????
end
    
