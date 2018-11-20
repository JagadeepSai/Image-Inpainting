function [min_i,min_j] = patch_fill(x,y,image,mask,window,psi,confidence_mat)
% psi is the half-patch size
% window is the search window for similiar patches (half)
% x > psi and x < cols-psi and y > psi and y < rows-psi
    x
    y
    [rows cols] = size(mask);
    assert(x> psi);
    assert(x< rows - psi);
    assert(y>psi);
    assert(y<cols-psi);
    
    p = image(x-psi:x+psi,y-psi:y+psi,:);
    mask_p = double(mask(x-psi:x+psi,y-psi:y+psi));
    min_x = max(x-window,psi+1);
    max_x = min(x+window,rows-psi-1);
    min_y = max(y-window,psi+1);
    max_y = min(y+window,cols-psi-1);
    
    
    min_i = 0;
    min_j = 0;
    min_diff = 10000000;
    
    for i=min_x:max_x
        for j=min_y:max_y
            flag = 0;
            for i1 = i-psi:i+psi
                for j1 = j-psi:j+psi
                    if mask(i1, j1) == 0
                        flag=1;
                    end
                end
            end
            if flag==1
                continue;
            end
%            if sum(sum(mask(i-psi:i+psi,j-psi:j+psi))) >= 255*(2*psi+1)*(2*psi+1) 
           q = image(i-psi:i+psi,j-psi:j+psi, :);
           
           diff = sum(sum((sum((p-q).^(2), 3).*mask_p)./255));
           if min_diff > diff
               min_i = i;
               min_j = j;
               min_diff = diff;
           end
%            end
        end
    end
    
    assert(min_diff < 10000000);

end