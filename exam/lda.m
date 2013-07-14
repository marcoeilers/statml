function [means sigma pcs] = lda(A)
%% Performs linear discriminant analysis on input data for an arbitrary number of classes.
%% 
%% A - a NxM matrix containing corresponding values for x and the assigned class
%%
%% Returns the means and the common sigma for the resulting gaussian distrubution as well as
%% the general probability that any point, regardless of its coordinates, falls into a category.

    %% divide the data set into n parts for simplicity
    sets=dividedataset(A);

    %% get the mean for both classes
    for i=1:size(sets, 2)
       means{i}=mean(sets{i}); 
    end

    %% get the common sigma
    sum=zeros(size(A, 2)-1, size(A, 2)-1);
    
    for i=1:size(sets, 2)
       currentSet=sets{i};
       
       for j=1:size(currentSet, 1)
           difference=means{i}-currentSet(j,:);
           product=difference'*difference;
           sum=sum+product;
       end
    end
    
    for i=1:size(sets, 2)
       means{i}=means{i}'; 
    end
    
    sigma=sum/(size(A,1)-size(sets, 2));
    

    %% calculate Pr(Y=C_k) for all classes
    for i=1:size(sets, 2)
       pcs{i}=size(sets{i}, 1)/size(A,1);
    end

