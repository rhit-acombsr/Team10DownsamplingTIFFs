clear all
clc

% tiff = {f,p,X,MAP,loadedImage};

tiff1 = open_tiff();
f1 = tiff1{1};
p1 = tiff1{2};
X1 = tiff1{3};
MAP1 = tiff1{4};
loadedImage1 = tiff1{5};

tiff2 = open_tiff();
f2 = tiff2{1};
p2 = tiff2{2};
X2 = tiff2{3};
MAP2 = tiff2{4};
loadedImage2 = tiff2{5};

resolutionsEqual = isequal(X1,X2);
ratioX2toX1 = [(size(X2,1)/size(X1,1)) , (size(X2,2)/size(X1,2))];

function tiff = open_tiff()
    tiff = {};
    
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