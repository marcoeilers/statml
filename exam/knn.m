function y = knn(data, input, distfunc, k)
%% k-NN classifier
%%
%% data - the 'training' data for the model, an NxM matrix.
%% input - the (single) point to classify. A 1xM vector.
%% distfunc - the metric to use.
%% k - how many neighbours to inspect.

    datadims=size(data, 2)-1;
    d = [];

    for i = 1:size(data, 1)
        d(i, 1:2) = [distfunc(data(i, 1:datadims)', input) data(i, datadims+1)];
    end
    
    d = sortrows(d, [1, 2]);
    d = d(1:k, 2);
    
    
   
    %% find most common class value
    %% if tied, finds the smallest one
    %% that's probably not the best solution

    y = mode(d);
    
