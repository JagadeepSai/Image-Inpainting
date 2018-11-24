clc;
clear all;
close all;
warning('off');
tic;
dir = '../data/c0';
image = imread( sprintf('%s%s',dir,'_input.png'));
% image =  imgaussfilt(image,2);
% figure(1);
% imshow(image);
image=rgb2hsv(image);
image = double(image);
mask = imread(sprintf('%s%s',dir,'_mask.png'));
mask = double(mask);

debug = 0;
psi = 10;
psi1 = psi;
window = 50;
alpha=255;
width=3;
grad_window = 3;
f = 1.5;

[rows,cols] = size(mask);
confidence_mat = double(mask > 0);  
while 1
    priority_mat = zeros(rows,cols);
%     [bx,by] = find_border(mask);
%     border_list = [bx,by];
    border_list = find_border(mask);
    if size(border_list) == [0,0]
       break
    end
    
    [n,m] = size(border_list);
    max_p_x = 0;
    max_p_y = 0;
    max_p = -1;
    G = grad1(image,1); %Hard coded Parameters here
    
%     normals 
    [Nx, Ny] = gradient(double(~mask));
    for i = 1:n
        x = border_list(i,1);
        y = border_list(i,2);
        cp = confidence(psi,x,y,confidence_mat); 
        dt = isophote1(x,y,G,grad_window,mask);
        
        norm_vector = [Nx(x,y), Ny(x,y)]';
        norm_vector = norm_vector/norm(norm_vector);
        norm_vector(~isfinite(norm_vector)) = 0;
        
%         norm_vector = norm_vec(border_list,[x,y],width);
        dp = abs(dt'*norm_vector)/alpha;
%         prio = cp + f*dp;
        prio = cp*dp;
        priority_mat(x,y) = prio;
        if prio > max_p
            max_p_x = x;
            max_p_y = y;    
            max_p = prio;
        end
    end
    confidence_mat(max_p_x,max_p_y) = confidence(psi,max_p_x,max_p_y,confidence_mat);
    [min_i,min_j] = patch_fill(max_p_x,max_p_y,image,mask,window,psi1,confidence_mat);
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
 toc;
figure(2);
imshow(hsv2rgb((image)));

if(debug == 1) 
    figure(1);
    imshow(hsv2rgb(((image))));
    I = zeros(rows, cols);
    for i=1:rows
        for j=1:cols
            if(mask(i,j)==0)
                I(i,j) = norm(isophote(i, j, G, grad_window, mask));
            end
        end
    end
    % imshow(I); colormap(gray);

    figure(3);
    imagesc(priority_mat);colormap(gray);

    figure(4);
    imagesc(confidence_mat); colormap(gray);
end
end
imwrite(hsv2rgb(image), sprintf('%s%s',dir,'_output.png'));
% image= hsv2rgb(image);
toc;
