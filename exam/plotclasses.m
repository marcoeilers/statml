function plotclasses(x, y, label)
%% Plots 2D points using different colors for each group. Works for a maximum of
%% seven groups. Used to plot principal components.
    

    minlbl=min(label);
    maxlbl=max(label);
    range=maxlbl-minlbl+1;
    
    for i=1:range
       c{i}=zeros(0,2); 
    end
    
    for i=1:length(label)
        index=label(i)-minlbl+1;
        c{index}=[c{index}; x(i), y(i)];
    end
    
    params=['r', 'b', 'g', 'c', 'm', 'y', 'k'];
    clf;
    hold on;
    for i=1:range
        cur=c{i};
        param=[params(i), 'x'];
        plot(cur(:,1), cur(:,2), param); 
    end

end