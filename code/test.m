clc;
clear all;
close all;
warning('off');
tic;
dir = '../data/c0';
image = imread( sprintf('%s%s',dir,'_input.png'));
figure(1);
imshow(image);

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
G = grad1(image(:,:,1),1);
% impixelinfo;
border_list = find_border(mask);
for i=1:100
    [y,x] = ginput(1);
    x = uint64(x);
    y= uint64(y);
    [x y]
    G(x,y,:);
%     norm_vector = norm_vec(border_list,[x,y],width)
    isophote1(x,y,G,grad_window,mask)
end