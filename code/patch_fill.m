function [min_i,min_j] = patch_fill(x,y,image,mask,window,psi,confidence_mat)
% psi is the half-patch size
% window is the search window for similiar patches (half)
    [rows cols] = size(mask);
%     assert(x> psi);
%     assert(x< rows - psi);
%     assert(y>psi);
%     assert(y<cols-psi);
   
    top = x-max(x-psi,1);
    bottom = min(x+psi,rows)-x;
    left = y-max(y-psi,1);
    right = min(y+psi,cols)-y;
    
    
    
  
    p = image(x-top:x+bottom,y-left:y+right,:);
    mask_p = double(mask(x-top:x+bottom,y-left:y+right));
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
           q = image(i-top:i+bottom,j-left:j+right, :);
           
           diff = sum(sum((sum((p(:,:,1)-q(:,:,1)).^(2), 3).*mask_p)./255));
           
           
%            diff = diff + corr2(rgb2gray(p),rgb2gray(q));

%            [c1,n]=imhist(p(:,:,1));
%            c1=c1/size(i1,1)/size(i1,2);
%            [c2,n2]=imhist(q(:,:,1));
%            c2=c2/size(i2,1)/size(i2,2);
%            
%            diff = pdist2(c1,c2,'chisq');
%            
%            [c1,n]=imhist(p(:,:,1));
%            c1=c1/size(i1,1)/size(i1,2);
%            [c2,n2]=imhist(q(:,:,1));
%            c2=c2/size(i2,1)/size(i2,2);
%            
%            diff = diff + pdist2(c1,c2,'chisq');
%            
%            [c1,n]=imhist(p(:,:,2));
%            c1=c1/size(i1,1)/size(i1,2);
%            [c2,n2]=imhist(q(:,:,2));
%            c2=c2/size(i2,1)/size(i2,2);
%            
%            diff = diff + pdist2(c1,c2,'chisq');
%            
%            [c1,n]=imhist(p(:,:,3));
%            c1=c1/size(i1,1)/size(i1,2);
%            [c2,n2]=imhist(q(:,:,3));
%            c2=c2/size(i2,1)/size(i2,2);
           
%            diff = diff + pdist2(c1,c2,'chisq');
       
<<<<<<< HEAD
%            q = image(i-psi:i+psi,j-psi:j+psi, :);
%            p = p(:);
%            q = q(:);
%            diff = ( ( p - mean(p) )/var(p) ) * ( ( q - mean(q) )/var(q) );
%            diff = sum(sum(sum((p-q).^2, 3).*mask_p))/255;
           
%            diff = corrcoef(p,q);
%            diff = diff(1,2);
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