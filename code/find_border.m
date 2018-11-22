function [front_x,front_y] =  find_border(mask)
    front = imdilate(mask, ones(3,3)) & ~mask;
    [front_x, front_y] = find(front);
end