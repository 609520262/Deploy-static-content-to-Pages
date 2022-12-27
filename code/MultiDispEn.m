function [MDE]=MultiDispEn(data,m,nc,tau,scale)

MDE=[];
data=data';
for j=1:scale
   Xs = Multi(data,j,1);
    [de]=DisEn_NCDF(Xs',m,nc,tau);
    MDE=[MDE,de];
end
end

function M_Data = Multi(data,Scale,flag)
 [m,n]=size(data);      %如果只是向量的话，n=1
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

function [Out_DisEn, npdf]=DisEn_NCDF(x,m,nc,tau)
%
% This function calculates dispersion entropy (DisEn) of a univariate
% signal x, using normal cumulative distribution function (NCDF)
%
% Inputs:
%
% x: univariate signal - a vector of size 1 x N (the number of sample points)
% m: embedding dimension
% nc: number of classes (it is usually equal to a number between 3 and 9 - we used c=6 in our studies)
% tau: time lag (it is usually equal to 1)
%
% Outputs:
%
% Out_DisEn: scalar quantity - the DisEn of x
% npdf: a vector of length nc^m, showing the normalized number of disersion patterns of x

N=length(x);

sigma_x=std(x);
mu_x=mean(x);

y=normcdf(x,mu_x,sigma_x);

for i_N=1:N
    if y(i_N)==1
        y(i_N)=1-(1e-10);
    end
    
     if y(i_N)==0
        y(i_N)=(1e-10);
     end
end

z=round(y*nc+0.5);

all_patterns=[1:nc]';

for f=2:m
    temp=all_patterns;
    all_patterns=[];
    j=1;
    for w=1:nc
        [a,b]=size(temp);
        all_patterns(j:j+a-1,:)=[temp,w*ones(a,1)];
        j=j+a;
    end
end

for i=1:nc^m
    key(i)=0;
    for ii=1:m
        key(i)=key(i)*10+all_patterns(i,ii);   % key代表符号模式
    end
end


embd2=zeros(N-(m-1)*tau,1);
for i = 1:m
    embd2=[z(1+(i-1)*tau:N-(m-i)*tau)]'*10^(m-i)+embd2;    % embd2代表重构的相空间
end


pdf=zeros(1,nc^m);

for id=1:nc^m
    [R,C]=find(embd2==key(id));
    pdf(id)=length(R);
end

npdf=pdf/(N-(m-1)*tau);     %  括号里面N-(m-1)*tau表示相空间向量的总数
p=npdf(npdf~=0);
Out_DisEn = -sum(p .* log(p));
end