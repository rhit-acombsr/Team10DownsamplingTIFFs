clear all
clc

tiff1 = open_tiff();

tiff2 = open_tiff();

function tiff = open_tiff()
    tiff = cell(1,3);
    
    % Display uigetfile dialog
    filterspec = {'*.tif'};
    [f, p] = uigetfile(filterspec);
    
    % Make sure user didn't cancel uigetfile dialog
    if (ischar(p))
        fname = [p f];
        try
            [X,MAP] = imread(fname);
            if (size(MAP) > 0)
                loadedImage = im2gray(ind2rgb(X,MAP));
            else
                loadedImage = im2gray(X);
            end
        catch ME
            % If problem reading image, display error message
        end
    end
    % imshow([X,MAP])
    tiff{1} = f;
    tiff{2} = p;
    tiff{3} = X;
    tiff{4} = MAP;
    tiff{5} = loadedImage;
end