function [DE]=DEparameter(data,m,tau,sigma)  % �����ʱ������Ϊ����������


%  Input:   data: time series;����Ϊ������
%           m: embedding dimension;
%           tau: time delay;��ռ��ع�ʱ�Ĳ��� 
%           sigma;sigmaΪ��[-1,1]���仮�ֵ�����

[DE]=diversityEn(data,m,tau,sigma);  % ����߶Ⱥ�ľ��� ��Ƕ��mά��,���������ɢ����    
end

function [de] = diversityEn(x,m,tau,sigma)  %% ɢ���غ���
N = length(x);
 % �˴�xΪʱ�����У�reconstitution�ĵ�һ����
    tempMat =reconstitution(x,m,tau);%tempMat���ǵ�ǰά�ȵ���ռ䣬���ŷŵ�
     % ��������Ƕ��ά�ȣ��������ڹ�������    
 for i=2:size(tempMat,2)  %% size(tempMat,2)Ϊ ����������ռ�ڶ���ά�ȵĳ���(����)�������ߵ�����
  % dist(i-1)=1-pdist2(tempMat(:,i)',tempMat(:,i-1)', 'cosine');     
     dist(i-1)=cosinedistance(tempMat(:,i)',tempMat(:,i-1)');  %% �����������ߵ��������ƶ�
 end
      [A ]=histcounts(dist,-1:(2/sigma):1);%%�ֳ�100��С���䣬ͳ��ÿ��С����ĳ���Ƶ��
      % ����histcounts������dist��ֵ   ������[-1,1]��,����Ϊ2/sigma�����ֵ�����
      % �Ⱥ����Ϊ[a,b],��a����ֵΪ  dist��������ÿ��������ֵ�Ƶ����bΪ�������ʼֵ
      % �Ⱥ���߽���[A]ʱ������ֵ��Ϊ�ڸ���������ֵ�Ƶ��
de = -nansum(A/sum(A).*log(A/sum(A)))/log(sigma);%%%%%�����к��п��ܳ���nan��������nansum
  % A/sum(A)��ʵ����Pk(������ĳ�����ϵĸ���)   
end

function X = reconstitution(data,m,tau)  %% �ع���ռ亯��
N=length(data);  %% ʱ�����г���ΪN
    % m ΪǶ��ռ�ά��
    % tau Ϊʱ���ӳ�
    % data Ϊ����ʱ������
    % tau=1ʱ  ������Ϊ1��2��3��4��5��6  m=2����6-2+1������12 23 34 45 56
    % tau=2�Ļ�����6-(2-1)*2=4�����ߣ�   13 24 35 46    tau=3��6-(2-1)*3=3������  14 25 46
    % X Ϊ�������m*Mά����
M=N-(m-1)*tau;
    % ��ռ��е�ĸ���
    for j=1:M  %% jΪ��������
        for i=1:m  %% iΪ��j�������ϵĵ�i��ʱ���  ÿ�����߶���m����
            X(i,j)=data((i-1)*tau+j);
        end
    end
end

function cosd = cosinedistance(a,b)  %% �������ƶȺ���

cosd=dot(a,b)/(norm(a)*norm(b));  %% dot(a,b)Ϊ������a��b�ĵ��  norm(a)������a��ģ��

end