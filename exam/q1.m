disp('Question 1');
%% load labels
traintarget=load('trainTarget.csv');

[N X]=hist(traintarget, 7);
hold off;

%% normalize and plot
bar(min(traintarget):max(traintarget), N./sum(N), 1, 'hist');
xlabel('Class');
ylabel('Probabilit density');
print -dpsc probdisthist.eps