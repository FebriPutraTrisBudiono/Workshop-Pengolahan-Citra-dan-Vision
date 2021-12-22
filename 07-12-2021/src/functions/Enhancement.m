function [ ret ] = Enhancement(img, display_flag)
if nargin==1; display_flag=0; end
    if ndims(img) == 3; end
% Enhancement -------------------------------------------------------------
    if display_flag==1; fprintf('>> enhancing... '); end

    [ binim, ~, ~, ~, ~, orient_img_m ] = f_enhance(img);
    if display_flag==1
        imshow(binim);title('Filtered and Binarized Image');
    end
end

