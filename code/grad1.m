function G = grad1(image,sigma)
[x,y,z] = size(image);
sobel_x = [-1 0 1;-2 0 2;-1 0 1];
sobel_y = [1,2,1; 0,0,0; -1,-2,-1];
h = fspecial('gaussian', 3, sigma); %Hard coded Parameters here
image = imfilter(image,h);
Gx = imfilter(image,sobel_x);
Gy = imfilter(image,sobel_y);

G(:,:,1) = sum(Gx,3);
G(:,:,2) = sum(Gy,3);

% figure(1);
% imagesc(G(:,:,1));colormap(gray);
% figure(2);
% imagesc(G(:,:,2)); colormap(gray);
end