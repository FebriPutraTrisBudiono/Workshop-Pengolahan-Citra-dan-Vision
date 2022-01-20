function [ biner ] = Enhancement(img)

    [x, y] = size(img);
    threshold=150;
    biner=zeros(x,y);
    
    for i=1:x
        for j=1:y
            if img(i, j) >= threshold
                biner(i, j) = 1;
            else
                biner(i, j) = 0;
            end
        end
    end
    
    biner = imcomplement(biner);
end
