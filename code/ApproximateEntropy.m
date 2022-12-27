function AE=ApproximateEntropy(data,m,r)  % 输入的时间序列data为列向量即可
    AE=ApproximateEntropy1(data,m,r);
end

function [apen] = ApproximateEntropy1(x,m,r)

r=r*std(x);
N=length(x);

for i=1:N-m+1
    Xm(i,:)=x(i:i+m-1);  % 嵌入m维度的相空间 Xm
end
for i=1:N-m
    Xm1(i,:)=x(i:i+m);   % 嵌入m+1维度的相空间 Xm1
end
% 相空间的  一行为一条轨线  行数为轨线数  列数为一条轨线的维度

correlation(1)=ccount(N,m,Xm,r); 
correlation(2)=ccount(N,m+1,Xm1,r); 
apen = correlation(1)-correlation(2);  
end

function correlation = ccount(N,m,Xm,r)
set = 0;
count = 0;
counter = 0;
NN=size(Xm,1);  % NN为轨线数量（N-m+1）
for i=1:NN
    current_window =Xm(i,:);      % current_window为第i条轨线
    for j=1:NN
        sliding_window =Xm(j,:);  % sliding_window为第j条轨线
        if (i~=j)  
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
    counter1 = count/(N-m); 
    counter(i) = log(counter1);
    count=0;
end
correlation = ((sum(counter))/(N-m+1));  % 对counter求和  再除以N-m+1
end