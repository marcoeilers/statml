disp('Question 2');

%% load data
data=load('trainInput.csv');
target=load('trainTarget.csv');

[comps perc eigval]=pca(data);

%% plot eigenspectrum
x=1:length(eigval);
hold off;
semilogy(x, eigval);
xlabel('Index of eigenvalues (ordered)');
ylabel('Eigenvalue');
print -dpsc eigenspectrum.eps

%% calculate cumulated percentages
cumperc=cumsum(perc.*100);

%% output number of needed pcs
i=1;
while cumperc(i)<90  
    i=i+1;
end
fprintf('%f principal components are needed to give us more than 90 percent of the variance: they give us %f percent.\n', i, cumperc(i));

%% plot cumulated percentages
plot(x, cumperc, 'r');
hold on;
plot(x, ones(size(eigval)).*90, 'k');
xlabel('Index of eigenvalues (ordered)');
ylabel('Cumulated sum of eigenvalues 1..i');
print -dpsc pcscumulatedperc.eps
hold off;

%% plot to first two pcs
comp1=comps(:,1);
comp2=comps(:,2);
reduced=zeros(0,2);
for i=1:size(data,1)
    newx1=comp1'*data(i,:)';
    newx2=comp2'*data(i,:)';
    reduced=[reduced; newx1, newx2];
end

plotclasses(reduced(:,1), reduced(:,2), target);
xlabel('PC1');
ylabel('PC2');
legend('Class 0', 'Class 1', 'Class 2', 'Class 3', 'Class 4', 'Class 5', 'Class  6');
scale=axis;
axis([-0.4 0.5 scale(3) scale(4)]);
print -dpsc pcaplot.eps

disp('Question 3');
%% run kmeans
[idx clustermeans]=kmeans(data, 7, 'Distance', 'sqEuclidean', 'Start', 'sample');

redcm=zeros(0,2);
for i=1:size(clustermeans,1)
    newx1=comp1'*clustermeans(i,:)';
    newx2=comp2'*clustermeans(i,:)';
    redcm=[redcm; newx1, newx2];
end

plot(redcm(:,1), redcm(:,2), 'k+', 'markersize', 20);
legend('Class 0', 'Class 1', 'Class 2', 'Class 3', 'Class 4', 'Class 5', 'Class  6', 'Cluster Centers');
print -dpsc 7meansclusters.eps


