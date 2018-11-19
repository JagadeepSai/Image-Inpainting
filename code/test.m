clc;
clear all;
tic;
image = imread('../data/images/c1.jpg');
image=rgb2hsv(image);
mask = imread('../data/images/c1_mask.pgm');
% mask = 255-mask;

psi = 4;
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

G= grad(image);
I = zeros(rows, cols);
for i=1:rows
    for j=1:cols
        I(i,j) = norm(isophote(i, j, G, 1, mask));
        
    end
end