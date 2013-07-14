function [class1 class2] = dividebinary (A)
%% Divides a given set of two dimensional classification data into one set for each class.
%% The classes must be encoded by being 1 for the first class and different from one for the second.
%% 
%% A - the input data set
    datadims=size(A, 2)-1;
    
    class1=ones(0,datadims);
    class2=ones(0,datadims);
    for i=1:length(A)
        if A(i,datadims+1)==1
            class1=[class1;A(i,1:datadims)];
        else
            class2=[class2;A(i,1:datadims)];
        end
    end