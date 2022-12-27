function [DE]=DEparameter(data,m,tau,sigma)  % 输入的时间序列为列向量即可


%  Input:   data: time series;输入为列向量
%           m: embedding dimension;
%           tau: time delay;相空间重构时的步长 
%           sigma;sigma为将[-1,1]区间划分的数量

[DE]=diversityEn(data,m,tau,sigma);  % 加入尺度后的矩阵 再嵌入m维度,按步骤求出散度熵    
end

function [de] = diversityEn(x,m,tau,sigma)  %% 散度熵函数
N = length(x);
 % 此处x为时间序列，reconstitution的第一参数
    tempMat =reconstitution(x,m,tau);%tempMat就是当前维度的相空间，横着放的
     % 行数等于嵌入维度，列数等于轨线数量    
 for i=2:size(tempMat,2)  %% size(tempMat,2)为 仅仅计算相空间第二个维度的长度(列数)，即轨线的数量
  % dist(i-1)=1-pdist2(tempMat(:,i)',tempMat(:,i-1)', 'cosine');     
     dist(i-1)=cosinedistance(tempMat(:,i)',tempMat(:,i-1)');  %% 相邻两条轨线的余弦相似度
 end
      [A ]=histcounts(dist,-1:(2/sigma):1);%%分成100个小区间，统计每个小区间的出现频次
      % 上述histcounts函数将dist的值   从区间[-1,1]上,步长为2/sigma，划分的区间
      % 等号左边为[a,b],则a返回值为  dist内数据在每个区间出现的频数；b为区间的起始值
      % 等号左边仅有[A]时，返回值仅为在各个区间出现的频数
de = -nansum(A/sum(A).*log(A/sum(A)))/log(sigma);%%%%%矩阵中很有可能出现nan，所以用nansum
  % A/sum(A)其实就是Pk(出现在某区间上的概率)   
end

function X = reconstitution(data,m,tau)  %% 重构相空间函数
N=length(data);  %% 时间序列长度为N
    % m 为嵌入空间维数
    % tau 为时间延迟
    % data 为输入时间序列
    % tau=1时  如序列为1，2，3，4，5，6  m=2，有6-2+1条轨线12 23 34 45 56
    % tau=2的话，有6-(2-1)*2=4条轨线；   13 24 35 46    tau=3有6-(2-1)*3=3条轨线  14 25 46
    % X 为输出，是m*M维矩阵
M=N-(m-1)*tau;
    % 相空间中点的个数
    for j=1:M  %% j为轨线数量
        for i=1:m  %% i为第j条轨线上的第i个时间点  每条轨线都有m个点
            X(i,j)=data((i-1)*tau+j);
        end
    end
end

function cosd = cosinedistance(a,b)  %% 余弦相似度函数

cosd=dot(a,b)/(norm(a)*norm(b));  %% dot(a,b)为求向量a和b的点乘  norm(a)求向量a的模长

end