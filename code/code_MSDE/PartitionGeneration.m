function partition = PartitionGeneration(PartitionData,numSymbol)
%  generate the partition vector
%  Input:    PartitionData: time series¡¡as a column Vector
%            numSymbol: the number of the symbol kinds
%  Output:   
%            partition£ºthe patition value of the time series
[m,n] = size(PartitionData);
data = reshape(PartitionData,m*n,1);  %change into long vector
partition = maxEntropyPartition(data,numSymbol);
end

function partition = maxEntropyPartition(data,numSymbol)
%  generate the partition vector
%  Input:    PartitionData: time series¡¡as a column Vector
%            numSymbol: the number of the symbol kinds
%  Output:   
%            partition£ºthe patition value of the time series
x = sort(data);
k = max(size(x));
partition = zeros(1, numSymbol-1);
for i=1:numSymbol-1
    partition(1,i) = x(floor(i*k/numSymbol));
end
end