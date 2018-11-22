% clc;
% clear all;
% close all;
% tic;
% image = imread('../data/images/c8.png');
% image =  imgaussfilt(image,2);
% image=rgb2ycbcr(image);
% image = double(image);

% figure(1), hold off, imagesc(image);

% [x, y] = ginput;                                                              
% mask = 255-255*poly2mask(x, y, size(image, 1), size(image, 2)); 


mask = imread('../data/images/c1_mask.pgm');
mask = 255-mask;
mask = double(mask);

% mask = 255-mask;
mask = double(mask);
inv_mask = 255-mask;
image_temp = image;
% image = image.*mask/255; %hsv

psi = 6;
window = 40;
alpha=255;

[rows,cols] = size(mask);
confidence_mat = ones(rows,cols);

for i=1:rows
    for j=1:cols
        if mask(i,j) == 0
           confidence_mat(i,j) = 0;
        end
    end
end

G= grad1(image);
I = zeros(rows, cols);
for i=1:rows
    for j=1:cols
        I(i,j) = norm(isophote1(i, j, G, psi, mask));
        
    end
end