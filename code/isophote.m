function V = isophote(x,y, G, psi, mask)
[sizex, sizey] = size(mask);
Gx = 0;
Gy = 0;
maxG = -1;
count=0;
for i = max(1, x-psi):min(sizex, x+psi)
    for j = max(1, y-psi):min(sizey, y+psi)
        if (mask(i,j) == 255)
%             if(G(i,j,1)^2+G(i,j,2)^2 > maxG)
%                 maxG = G(i,j,1)^2+G(i,j,2)^2;
%                 Gx = G(i,j,1);
%                 Gy = G(i,j,2);
%             end
            Gx = Gx +G(i,j,1);
            Gy = Gy + G(i,j,2);
            count= count+1;
        end
    end
end

% Ix = -Gy;
% Iy = Gx;
Ix = -Gy/count;
Iy = Gx/count;
V = [Ix Iy]';
end

% function [ isoV ] = isophote(x,y,G,window,im)
%     window = im(y - 1 : y + 1, x - 1 : x + 1);
%     center_value = window(2, 2);
%     window(window == -1) = center_value;
%     fx = window(2, 3) - window(2, 1);
%     fy = window(3, 2) - window(1, 2);
%     if fx == 0 && fy == 0
%        isoV = [0; 0]; 
%     else
%         I = sqrt(fx^2 + fy^2);
%         theta = acot(fy / fx);
%         [isoV_x, isoV_y] = pol2cart(theta, I); 
%         isoV = [isoV_x isoV_y]';
%     end
% end