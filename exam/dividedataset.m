function [sets, ids] = dividedataset (A)
%% Divides a given set of arbitrary dimensional classification data into one set for each class.
%% Returns a cell array of the data points and the respective class ID.
%% A - the input data set
    
    datadims=size(A, 2)-1;
    from=min(A(:,datadims+1));
    to=max(A(:,datadims+1));

    for i=1:(to-from+1)
       sets{i}=zeros(0, datadims); 
    end
    
    for i=1:size(A,1)
        currentClass=A(i,datadims+1)-from+1;
        sets{currentClass}=[sets{currentClass}; A(i,1:datadims)];
    end
    
    ids=from:to;