function [cp] = confidence(psi,x,y,confidence_mat)

%     confidence_mat = imread('../data/images/c2_mask.bmp');
%     psi = 9;
%     x = 13;
%     y=13;

    [rows,cols] = size(confidence_mat);

    min_x = max(1,x-psi);
    max_x = min(rows,x+psi);
    min_y = max(1,y-psi);
    max_y = min(cols,y+psi);

    cp =  sum(sum(confidence_mat(min_x:max_x,min_y:max_y)));
    cp = cp/((2*psi+1)^2);
%     confidence_mat(x,y) = cp;  
    
    
    
end