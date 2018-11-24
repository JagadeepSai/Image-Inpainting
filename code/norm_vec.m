function vec = norm_vec(counter_list,pixel,n)

x = pixel(1); y = pixel(2);
xlist = [];
ylist = [];
dist = floor(n/2);
for p = counter_list'
    x2 = p(1) - x;
    y2 = p(2) - y;
    if( (abs(x2) <= dist) && (abs(y2) <= dist))
        xlist = [xlist x2];
        ylist = [ylist y2];
    end
end

coeffs = polyfit(xlist, ylist, 1);
angle = atan(-1/coeffs(1))+pi/2;

fx = cos(angle);
fy = sin(angle);

vec = [fx; fy] / norm([fx; fy]);
end

