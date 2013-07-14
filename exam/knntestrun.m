function [best error] = knntestrun(train, test, distfunc, Ks, silent)
%% knntest - run series of K-NN tests using one test set and different Ks,
%%   print out results
%%
%% train - training set, a NxM Matrix [xval yval class]
%% test - test set, a NxM Matrix [xval yval realclass]
%% distfunc - the function as metric
%% Ks - Nx1 matrix of different Ks for K-NN
%%
%% x = first k with minimal error rate

    %% minErr := [error-rate k]
    minErr = [2 -1];
    for k = Ks
        err = knntest(train, test, distfunc, k);
        if silent~=1
            disp(sprintf('%d-Nearest Neighbor error rate: %f', k, err));
        end
        if (err < minErr(1)) 
            minErr = [err k];
        end
    end
    best = minErr(2);
    error=minErr(1);
