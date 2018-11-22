clc;
clear all;
close all;
tic;
image = imread('../data/images/c2.jpg');
image =  imgaussfilt(image,3);
 
image=rgb2ycbcr(image);
image = double(image);


mask = imread('../data/images/c2_mask.bmp');

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