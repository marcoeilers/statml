function [quotient errors classes] = ldaerror(means, sigma, pcs, A, classlabels)
%% Calculates the error percentate which results from classifying a data set 
%% with a linear discriminant analysis as well as the margin the LDA has for a given data set. 
%%
%% A - the data set to classify
    
    errors = 0;
    
    datadims=size(A, 2)-1;
    classfrom=min(classlabels);
    
    classes=zeros(0,1);
    

    % iterate through all points
    for i=1:length(A)
        % run all discrimination functions on the current point
        discrval=zeros(1,size(means, 2));
        
        for j=1:size(means, 2)
           discrval(1,j)=ldadiscrimination(A(i, 1:datadims)', means{j}, sigma, pcs{j}); 
        end
        
        [~, index]=max(discrval');
        
        % calculate the original class label
        
        class=index+classfrom-1;

        classes=[classes; class];

        % and add it to the error count if the classification was wrong
        errors = errors + (class ~= A(i, datadims+1));
        %fprintf('class %d prediction %d \n', A(i, datadims+1), class);
    end
    
    % calculate the error percentage
    quotient=errors/size(A, 1);
