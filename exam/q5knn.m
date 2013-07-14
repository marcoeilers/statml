disp('kNN');
% load data
traindata=load('trainInput.csv');
traintarget=load('trainTarget.csv');
testdata=load('testInput.csv');
testtarget=load('testTarget.csv');

traininput=[traindata, traintarget];
testinput=[testdata, testtarget];

% grid search
Ks = [20 50];
euclid = @(x,y) eudist(x,y);

% we want 5-fold cross-validation, so we need 5 groups
disp('Cross-validation');
c=cell(1,5);
for i=1:5
   c{i}=zeros(0,size(traininput, 2)); 
end

for i=1:size(traindata, 1)
   index=mod(i,5);
   if index==0
       index=5;
   end
   c{index}=[c{index}; traininput(i,:)];
end

for i=1:length(Ks)
   fprintf('K is %f \n', Ks(i));
   error=0;
   for j=1:5
       input=zeros(0,size(traininput, 2));
       for k=1:5
           if k~=j
              input=[input; c{k}]; 
           end
       end
       [~, err]=knntestrun(input, c{j}, euclid, Ks(i), 1)
       error=error+err;
   end
   fprintf('Error is %f \n', error/5)
end

% just for fun: calculate errors for different k's
disp('Calculating results for different values of k');
Ks = [1 2 3 5 7 9 20 50];
disp('Test Set')
knntestrun(traininput, testinput, euclid, Ks)
disp('Training set')
knntestrun(traininput, traininput, euclid, Ks)