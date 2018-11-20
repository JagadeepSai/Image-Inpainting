function [border_list] =  find_border(image,mask)
    [rows cols] =  size(mask);
    border_mask = zeros(rows,cols);
    border_list = [];

    for i=1:rows
        for j=1:cols
            left_x = max(1,j-1);
            up_y = max(1,i-1);
            down_y = min(rows,i+1);
            right_x = min(cols,j+1);
            if mask(i,j) == 0
                if mask(i,left_x) > 0 || mask(i,right_x) > 0 || mask(up_y,j) > 0 || mask(down_y,j) > 0
                    border_mask(i,j) = 255;
                    x_y = zeros(1,2);
                    x_y(1,1) = i;
                    x_y(1,2) = j;
                    border_list = [border_list;x_y];
                end
            end
        end
    end
end