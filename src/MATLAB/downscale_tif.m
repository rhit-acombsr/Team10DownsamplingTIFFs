clear all
clc

% Display uigetfile dialog
filterspec = {'*.jpg;*.tif;*.png;*.gif','All Image Files'};
[f, p] = uigetfile(filterspec);

% Make sure user didn't cancel uigetfile dialog
if (ischar(p))
    fname = [p f];
    old_fname = fname;
    
    try
        [X,MAP] = imread(fname);
        if (size(MAP) > 0)
            % ogImage = ind2rgb(X,MAP);
            loadedImage = im2gray(ind2rgb(X,MAP));
        else
            % ogImage = X;
            loadedImage = im2gray(X);
        end
    catch ME
        % If problem reading image, display error message
    end
    
    folderPath = p;
    save_filename = "new_" + f;
end
imshow([X,MAP])

% 1.2339e+03
% -3.4028e+38