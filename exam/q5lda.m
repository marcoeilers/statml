disp('Question 5');
disp('LDA');
%% load data
traindata=load('trainInput.csv');
traintarget=load('trainTarget.csv');
testdata=load('testInput.csv');
testtarget=load('testTarget.csv');

traininput=[traindata, traintarget];
testinput=[testdata, testtarget];

%% get lda parameters
[means sigma pcs]=lda(traininput);
labels=min(traintarget):max(traintarget);


%% calculate errors
[trainerror, ~, trainclasses]=ldaerror(means, sigma, pcs, traininput, labels);
[testerror, ~, testclasses]=ldaerror(means, sigma, pcs, testinput, labels);

fprintf('LDA Training error: %d, test error: %d \n',trainerror, testerror);

%% plot test set result
[comps perc eigval]=pca(traindata);

comp1=comps(:,1);
comp2=comps(:,2);
reduced=zeros(0,2);
for i=1:size(testdata,1)
    newx1=comp1'*testdata(i,:)';
    newx2=comp2'*testdata(i,:)';
    reduced=[reduced; newx1, newx2];
end
plotclasses(reduced(:,1), reduced(:,2), testclasses);
xlabel('PC1');
ylabel('PC2');
legend('Class 0', 'Class 1', 'Class 2', 'Class 3', 'Class 4', 'Class 5', 'Class  6');
scale=axis;
axis([-0.4 0.5 scale(3) scale(4)]);
print -dpsc ldaplot.eps