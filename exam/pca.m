function [ components percentages eigval ] = pca( data )
%% Returns all principal components, sorted so that the most
%% influential ones, i.e. the ones with the highest variance, come first

    mu=mean(data);
    sigma=cov(data);
    
    [eigvec eigval]=eig(sigma);
    
    eigval=max(eigval)';
    percentages=eigval./sum(eigval);
    
    eigval=sort(eigval, 1, 'descend');
    [percentages indices]=sort(percentages, 1, 'descend');
    
    components=zeros(size(eigvec, 1),0);
    for i=1:size(indices, 1)
        currentvec=eigvec(:,indices(i));
        components=[components, currentvec];
    end
end

