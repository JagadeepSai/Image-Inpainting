function vec = norm_vec(counter_list,pixel)

%constant 
% counter_list = [ 1,1 ; 2,2 ; 3,3]';
% pixel = [2,2];
n = 3;
sigma = 5;
%----
x = pixel(1); y = pixel(2);
window = zeros([n,n]);
dist = floor(n/2);
for p = counter_list'
    x2 = p(1) - x;
    y2 = p(2) - y;
    if( (abs(x2) <= dist) && (abs(y2) <= dist))
        window(dist+1+x2,dist+1+y2) = 1;
    end
end

window = imgaussfilt(window,sigma);
% window
[fgrad_x,fgrad_y] = gradient(window);

fx = fgrad_x(1);
fy = fgrad_y(1);

if fx == 0 && fy == 0
    vec = [1; 1] / norm([1; 1]); 
else
    vec = [fx; fy] / norm([fx; fy]);
end
end
