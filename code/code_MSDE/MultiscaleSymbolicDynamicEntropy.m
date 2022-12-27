function MSDE=MultiscaleSymbolicDynamicEntropy(data,m,Sym,scale)
%  Calculate the  (MSDE)
%  Input:   data: time series;
%           m: embedding dimension;
%           r: std of data;
%           scale: the scale factor;
%  Output: 
%           MFE: multiscale fuzzy entropy.
%  code is arranged by yyt in 2015.07     yangyuantaohit@163.com
MSDE=[];
data=data';
for j=1:scale
    Xs = Multi(data,j,2);
    SDE=SymbolDynamicEntropy(Xs,m,Sym);
    MSDE=[MSDE,SDE];
end
end


function M_Data = Multi(data,Scale,flag)
 [m,n]=size(data);      %���ֻ�������Ļ���n=1,������������
for k=1:n

%% Multi-    
if flag==1
    J = fix(m/Scale);
    M_Data=zeros(J,n);
    for i=1:J
        M_Data(i,k) = mean(data((i-1)*Scale+1:i*Scale,k));
    end
elseif flag==2
%% Modified Multi-
    J = m-Scale+1;
     M_Data=zeros(J,n);
     for i=1:J
        M_Data(i,k) = mean(data(i:i + Scale - 1,k));
     end
end   
end
end

function [apen] = SymbolDynamicEntropy(data,m,numSymbol)

    partition = PartitionGeneration(data,numSymbol);
    
   %% �ڶ��������ɷ������С�
    symbolSeq=SymbolGeneration(data,partition);  
   %% ��������������ŵ�SDF��ֵ
    apen = SymbolEntropy(symbolSeq, numSymbol, m);

end
