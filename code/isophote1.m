function V = isophote1(x,y, G, psi, mask)
[sizex, sizey] = size(mask);
G = double(G);

maxG = -1;
count=0;
Gx= 0;
Gy = 0;

for i = max(1, x-psi):min(sizex, x+psi)
    for j = max(1, y-psi):min(sizey, y+psi)
        if (mask(i,j) ~= 0)
            if(G(i,j,1)^2+G(i,j,2)^2 > maxG)
                maxG = G(i,j,1)^2+G(i,j,2)^2;
                Gx = G(i,j,1);
                Gy = G(i,j,2);
            end
%             Gx = Gx +G(i,j,1);
%             Gy = Gy + G(i,j,2);
            count= count+1;
        end
    end
end

Ix = -Gy;
Iy = Gx;

% Ix = -Gy/count;
% Iy = Gx/count;
V = [Ix Iy]';
end

% 

% temp = image(max(1, x-window):min(sizex, x+window), max(1, y-window):min(sizey, y+window), :);
% 
% 
% for i = max(1+1, x-window):min(sizex-1, x+window)
%     for j = max(1+1, y-window):min(sizey-1, y+window)
%         if (sum(sum(mask(i-1:i+1,j-1:j+1))) == 255*9)
%             temp = image(i-1:i+1,j-1:j+1,:);
%             Gx_p = sum(sum(sobel_x.*temp)); 
%             Gy_p = sum(sum(sobel_y.*temp));
%             
%             Gx_p = sum((Gx_p.^2),3);
%             Gy_p = sum((Gy_p.^2),3);
%             if(Gx_p+Gy_p > maxG)
%                 maxG =Gx_p+Gy_p;
%                 Gx = Gx_p;
%                 Gy = Gy_p;
%             end
%             count= count+1;
%         end
%     end
% end


