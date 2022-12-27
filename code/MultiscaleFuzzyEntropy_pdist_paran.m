function MFE=MultiscaleFuzzyEntropy_pdist_paran(data,m,n,r,scale)
%  Calculate the Multiscale Sample Entropy (MSE)
%  Input:   data: time series;
%           m: embedding dimension;
%           r: std of data;
%           scale: the scale factor;
%  Output: 
%           MFE: multiscale fuzzy entropy.
%  code is arranged by yyt in 2015.07     yangyuantaohit@163.com
MFE=[];

for j=1:scale
    Xs = Multi(data,j);
    FE=FuzzyEntropy(Xs,m,n,r);
    MFE=[MFE,FE];
end
end


function M_Data = Multi(data,scale)
%  generate the consecutive coarse-grained time series
%  Input:   data: time series;
%           scale: the scale factor;
%  Output: 
%           M_Data: the coarse-grained time series at the scale factor S.
L = length(data);
J = fix(L/scale);

for i=1:J
    M_Data(i) = mean(data((i-1)*scale+1:i*scale));
end
end

function [apen] = FuzzyEntropy(data,m,n,r)
%  Calculate the fuzzy entropy
%  Input:   data: time series;
%           m: embedding dimension;
%           r: std of data 
%  Output:  
%           apen: fuzzy entropy.
%  code is arranged by yyt in 2015.07   yangyuantaohit@163.com
r=r*std(data);
N=length(data);

for i=1:N-m
    u=sum(data(i:i+m-1))/m;
    Xm(i,:)=data(i:i+m-1)-u;
    u=sum(data(i:i+m))/(m+1);
    Xm1(i,:)=data(i:i+m)-u;
end

correlation(1)=ccount(N,m,n,Xm,r);
correlation(2)=ccount(N,m+1,n,Xm1,r);
apen = log(correlation(1)/correlation(2));
end

function correlation = ccount(N,m,n,Xm,r)
counter = 0;

y=pdist(Xm,'chebychev'); %计算切比雪夫距离，计算距离的时候，是每一  行   之间的距离！计算出来的是一个对角阵的距离
Z=squareform(y);

% For a given threshold r and fuzzy power n, define a global quantity fi_m1
y=exp(-(y./r).^n);  %%%%%%%%原公式相当于exp(-(y/r)^2);
correlation=sum(y)*n/((N-m)*(N-m-1));
end