function patch_sim(x,y,image,mask,window,psi,confidence_mat)
% psi is the half-patch size
% window is the search window for similiar patches (half)
% x > psi and x < cols-psi and y > psi and y < rows-psi

    [rows cols] = size(mask);
    
    p = image(x-psi:x+psi,y-psi:y+psi);
    
    min_x = max(x-window,psi+1);
    max_x = min(x+window,cols-psi-1);
    min_y = max(y-window,psi+1);
    max_y = min(y+window,rows-psi-1);
    
    min_i = 0;
    min_j = 0;
    min_diff = 10000000;
    
    for i=min_x:max_x
        for j=min_y:max_y
           if sum(sum(mask(i-psi:i+psi,j-psi:j+psi))) >= 255*(2*psi+1)*(2*psi+1) 
               q = image(i-psi:i+psi,j-psi:j+psi);
               diff = sum(sum((p-q).^(2)));
               if min_diff > diff
                   min_i = i;
                   min_j = j;
                   min_diff = diff;
               end
           end
        end
    end
    
    assert(min_diff < 10000000);
    cp = confidence(psi,x,y,confidence_mat);
    
    for i=-psi:psi
        for j=-psi:psi
            if mask(x+i,y+j) == 0
               image(x+i,y+j) = image(min_i+i,min_j+j);
               mask(x+i,y+j)=255;
               confidence_mat(i,j) = cp;
            end
        end
    end
  
    
  


end