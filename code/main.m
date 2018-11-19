clc;
clear all;
tic;
image = imread('../data/images/c3.bmp');
image=rgb2hsv(image);
% figure(1), hold off, imagesc(image);

% [x, y] = ginput;                                                              
% mask = 255-255*poly2mask(x, y, size(image, 1), size(image, 2)); 


mask = imread('../data/images/c3_mask.bmp');
% mask = 255-mask;


psi = 5;
window = 60;
alpha=255;
width=3;

[rows,cols] = size(mask);
confidence_mat = ones(rows,cols);

for i=1:rows
    for j=1:cols
        if mask(i,j) == 0
           confidence_mat(i,j) = 0;
        end
    end
end
    
while 1
    border_list = find_border(image,mask);
    if size(border_list) == [0,0]
       break
    end
    
    [n,m] = size(border_list);
    max_p_x = 0;
    max_p_y = 0;
    max_p = -1;
    G = grad(image);
    
    for i = 1:n
        x = border_list(i,1); 
        y = border_list(i,2);
        cp = confidence(psi,x,y,confidence_mat);
        dt = isophote(x,y,G,1,mask);
        norm = norm_vec(border_list,[x,y],width);
        dp = abs(dt.*norm)/alpha;
%         prio = cp*dp;
        prio = cp + dp;
        if prio > max_p
            max_p_x = x;
            max_p_y = y;    
            max_p = prio;
        end
    end
    

    confidence_mat(max_p_x,max_p_y) = confidence(psi,max_p_x,max_p_y,confidence_mat);
    [min_i,min_j] = patch_fill(max_p_x,max_p_y,image,mask,window,psi,confidence_mat);
    cp = confidence(psi,max_p_x,max_p_y,confidence_mat);
    
    
    top = max_p_x-max(max_p_x-psi,1);
    bottom = min(max_p_x+psi,rows)-max_p_x;
    left = max_p_y-max(max_p_y-psi,1);
    right = min(max_p_y+psi,cols)-max_p_y;
    
    for i=-top:bottom
        for j=-left:right
            if mask(max_p_x+i,max_p_y+j) == 0
               image(max_p_x+i,max_p_y+j,:) = image(min_i+i,min_j+j,:);
               mask(max_p_x+i,max_p_y+j)=255;
               confidence_mat(max_p_x+i,max_p_y+j) = cp;
            end
        end
    end
image= hsv2rgb(image);
imshow(image)
image = rgb2hsv(image);
end
image= hsv2rgb(image);
toc;
