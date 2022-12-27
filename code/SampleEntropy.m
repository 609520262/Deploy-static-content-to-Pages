function SE=SampleEntropy(data,m,r)  % 输入的时间序列data为列向量即可
%  Calculate the Multiscale Sample Entropy (MSE)
%  Input:   data: time series;
%           m: embedding dimension;
%           r: std of data;
%           scale: the scale factor;
%  Output: 
%           MSE: multiscale sample entropy.
%  code is arranged by yyt in 2015.07     yangyuantaohit@163.com
    SE=SampleEntropy1(data,m,r);
end



function [apen] = SampleEntropy1(x,m,r)
%  Calculate the sample entropy
%  Input:   data: time series;
%           m: embedding dimension;
%           r: std of data;
%  Output:  
%           apen: sample entropy.
%  code is arranged by yyt in 2015.07   yangyuantaohit@163.com
r=r*std(x);
N=length(x);

for i=1:N-m
    Xm(i,:)=x(i:i+m-1);  % 嵌入m维度的相空间 Xm
    Xm1(i,:)=x(i:i+m);   % 嵌入m+1维度的相空间 Xm1
end
% 相空间的  一行为一条轨线  行数为轨线数  列数为一条轨线的维度

correlation(1)=ccount(N,m,Xm,r);     % Bm(r)
correlation(2)=ccount(N,m+1,Xm1,r);  % Bm+1(r)
apen = log(correlation(1)/correlation(2));  % 同 -log(Bm+1(r)/Bm(r))
end

function correlation = ccount(N,m,Xm,r)
set = 0;
count = 0;
counter = 0;
NN=size(Xm,1);  % NN为轨线数量（N-M）
for i=1:NN
    current_window =Xm(i,:);      % current_window为第i条轨线
    for j=1:NN
        sliding_window =Xm(j,:);  % sliding_window为第j条轨线
        if (i~=j)  % SE不包含自我匹配
            for k=1:m
                if((abs(current_window(k)-sliding_window(k))>r) && set == 0)
                    set = 1;    % 只要两条轨线的坐标有一组差值绝对值大于r  也就是切比雪夫距离大于r  那么set就为1   否则为0
                end
            end
            if(set==0&&i~=j) 
               count = count+1;  % count就是统计了所有轨线之间切比雪夫距离小于r的数量
            end
          set = 0; 
        end 
    end 
       counter(i)=count/(N-m-1);  % counter中  共有i=N-m个
       count=0;
end

correlation = ((sum(counter))/(N-m));  % 对counter求和  再除以N-m
end