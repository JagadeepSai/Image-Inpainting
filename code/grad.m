function G = grad(image)
[x,y,z] = size(image);
G = zeros(x,y,2);
for i = 1:z
    [Gx1,Gy1] = imgradientxy(image(:,:,z));
    G(:,:,1) = G(:,:,1) + Gx1;
    G(:,:,2) = G(:,:,2) + Gy1;
end

end