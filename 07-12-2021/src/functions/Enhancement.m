function [ ret ] = Enhancement(img, display_flag)
if nargin==1; display_flag=0; end
    if ndims(img) == 3; end
    block_size_c = 24; YA=0; YB=0; XA=0; XB=0;
% Enhancement -------------------------------------------------------------
    if display_flag==1; fprintf('>> enhancing... '); end
    yt=1; xl=1; yb=size(img,2); xr=size(img,1); 
    
    % find the number of pixels in rows 1-55 with values less that 8
    % if they are less than 8, then we make them 255. This is done to
    % clear the area to the left of the input fingerprint. This is repeated
    % for rows 225-end, columns 200-end and columns 1-75
    for x=1:55
        if numel(find(img(x,:)<200)) < 8
           img(1:x,:) = 255;
           yt=x;
        end
    end
    for x=225:size(img,1)
        if numel(find(img(x,:)<200)) < 3
           img(x-17:size(img,1),:) = 255;
           yb=x;
           break
        end
    end
    for y=200:size(img,2)
        if numel(find(img(:,y)<200)) < 1
           img(:,y:size(img,2)) = 255;
           xr=y;
           break
        end
    end
    for y=1:75
        if numel(find(img(:,y)<200)) < 1
           img(:,1:y) = 255;
           xl=y;
        end	
    end
    [ binim, mask, cimg, cimg2, orient_img, orient_img_m ] = f_enhance(img);
    if display_flag==1
        imshow(binim);title('Thresholding');
    end;
end

