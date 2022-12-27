function symbolSeq=SymbolGeneration(Data,partition)
%  Calculate the symbol of the Data 
%  Input:    Data: time series¡¡as a column Vector
%            numSymbol: the number of the symbol kinds
%  Output:   
%            symbol£ºthe symbol sequence of the time series
%¡¡code is arranged by yyt in 2016.06     yangyuantaohit@163.com
[a,~]=size(Data);
if a==1
   Data=Data';
end 

partition=[partition inf];
symbolSeq=zeros(length(Data),1);
for ii = 1:length(Data)
    for s=1:length(partition)
        if partition(s)>Data(ii)
            symbolSeq(ii)=s;
            break
        end        
    end
end
end
