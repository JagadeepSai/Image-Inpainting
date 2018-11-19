function V = isophote(x,y, G, window, mask)
[sizex, sizey] = size(mask);
Gx = 0;
Gy = 0;
maxG = -1;
count=0;
for i = max(1, x-window):min(sizex, x+window)
    for j = max(1, y-window):min(sizey, y+window)
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