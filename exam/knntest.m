function t = knntest(train, test, distfunc, k)
%% knntest - run a test set on the  K-NN classifier
%%
%% train - training set, a NxM Matrix [xval yval class]
%% test - test set, a NxM Matrix [xval yval realclass]
%% distfunc - the function as metric
%% k - how many nearest neighbors to use for classification
%%
%% t = error rate of this test set using train set with k neighbors
    
    datadims=size(train, 2)-1;
    errors = 0;
    for i = 1:size(test, 1)
        cl = knn(train, test(i, 1:datadims)', distfunc, k);

        %% add an error, if predicted class and real class don't match
        errors = errors + (cl ~= test(i, datadims+1));
    end
    t = errors/size(test, 1);
