function vec = norm_vec(counter_list,pixel,n)

%constant 
clc;
clear;

% testing 
% pixel = [2,2];
% cl1 = [ 1,1; 2,2; 3,3];
% cl2 = [ 2,1;2,2;2,3];
% cl3 = [ 2,2;3,2;3,3];
% cl4 = [ 2,2;3,2;1,3];
% w1 = [ 0, 0, 0; 1, 1, 1; 1,1,1];
% w2 = [ 0, 1, 1; 0, 1, 1; 0,1,1];
% w3 = [ 1, 0, 0; 1, 1, 0; 1,1,1];
% w4 = [ 0,0,1;0,1,1;1,1,1];
% window = w2;
% counter_list = cl4;
% n = 3;
%----

x = pixel(1); y = pixel(2);
xlist = [];
ylist = [];
% window = zeros([n,n]);
dist = floor(n/2);
for p = counter_list'
    x2 = p(1) - x;
    y2 = p(2) - y;
    if( (abs(x2) <= dist) && (abs(y2) <= dist))
%         window(dist+1+x2,dist+1+y2) = 1;
        xlist = [xlist x2];
        ylist = [ylist y2];
    end
end

coeffs = polyfit(xlist, ylist, 1);
angle = atan(-1/coeffs(1))+pi;

fx = cos(angle);
fy = sin(angle);

vec = [fx; fy] / norm([fx; fy]);
end

