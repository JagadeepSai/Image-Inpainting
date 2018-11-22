clc;
clear all;
close all;
tic;

image = imread('../data/images/c5.jpg');
% image =  imgaussfilt(image,2);
image=rgb2ycbcr(image);
image = double(image);

mask = imread('../data/images/c5_mask.bmp');
mask = double(mask);

psi = 5;
window = 50;
alpha=255;
width=3;
grad_window = 48;
f = 2.5;

[rows,cols] = size(mask);
confidence_mat = mask > 0;  
    
while 1
    priority_mat = zeros(rows,cols);
    border_list = find_border(mask);
    if size(border_list) == [0,0]
       break
    end
    
    [n,m] = size(border_list);
    max_p_x = 0;
    max_p_y = 0;
    max_p = -1;
    G = grad(image);
    
    %normals 
    [Nx, Ny] = gradient(double(~mask));
%     toc;
    for i = 1:n
        x = border_list(i,1);
        y = border_list(i,2);
        cp = confidence(psi,x,y,confidence_mat);
        dt = isophote(x,y,G,psi,mask);
        
        norm_vector = [Nx(x,y), Ny(x,y)]';
        norm_vector = norm_vector/norm(norm_vector);
        norm_vector(~isfinite(norm_vector)) = 0;
        
%         norm_vector = norm_vec(border_list,[x,y],width);
        dp = abs(dt'*norm_vector)/alpha;
%         prio = cp*dp;
%           prio = cp*dp;
        prio = [cp; f*dp];
        prio = sum(prio);

        priority_mat(x,y) = prio;
        if prio > max_p
            max_p_x = x;
            max_p_y = y;    
            max_p = prio;
        end
    end
%     toc;
    confidence_mat(max_p_x,max_p_y) = confidence(psi,max_p_x,max_p_y,confidence_mat);
    [min_i,min_j] = patch_fill(max_p_x,max_p_y,image,mask,window,psi,confidence_mat);
    cp = confidence(psi,max_p_x,max_p_y,confidence_mat);
%     toc;
    
    
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
 toc;
figure(1);
imshow(ycbcr2rgb((uint8(image))));

% figure(2);
% [rows,cols] = size(mask);
I = zeros(rows, cols);
for i=1:rows
    for j=1:cols
        if(mask(i,j)==0)
            I(i,j) = norm(isophote(i, j, G, psi, mask));
        end
    end
end
% imshow(I); colormap(gray);

% figure(3);
% imshow(priority_mat);colormap(gray);

% figure(4);
% imshow(confidence_mat); colormap(gray);
end
% image= hsv2rgb(image);
toc;
