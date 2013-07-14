disp('Question 6');

%% Load datasets

traindata=load('trainInputBinary.csv');
traintarget=load('trainTargetBinary.csv');
testdata=load('testInputBinary.csv');
testtarget=load('testTargetBinary.csv');

traininput=[traindata, traintarget];
testinput=[testdata, testtarget];

%% calculate initial gamma

[trainclass1 trainclass2]=dividebinary(traininput);

sigmajaak=jaakkola(trainclass1, trainclass2)
gammajaak=1/(2*sigmajaak^2)

%% I choose b=2
b=2

Cs=[b^-1, 1, b, b^2, b^3];
i=-3:3;
gammas=gammajaak*b.^i;


maxp = 0;
for c = Cs
    for g = gammas
        fprintf('C: %d, gamma: %f ', c, g);
        p = crossval(5, traindata, traintarget, c, g);
        if maxp < p
            C = c;
            gamma = g;
            maxp = p;
        end
    end
end

fprintf('Optimal C: %f, optimal gamma: %f \n', C, gamma);

model=train(traindata, traintarget, C, gamma);
disp('Classifying the train data');
classify(traindata, model, traintarget);

disp('Classifying the test data');
classify(testdata, model, testtarget);