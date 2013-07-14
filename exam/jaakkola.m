function [ result ] = jaakkola( group1, group2 )
%% Calculates sigma_Jaakkola for the data of two given groups.
    G=[];

    for i=1:size(group1, 1)
       current=group1(i, :);
       for j=1:size(group2, 1)
           diff=current-group2(j, :);
           G=[G; sqrt(sum(diff.^2))];
       end
    end
    
    result=median(G);
end

