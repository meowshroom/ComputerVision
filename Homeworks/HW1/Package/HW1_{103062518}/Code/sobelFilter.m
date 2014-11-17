function filteredImage =  sobelFilter( img )

h = size(img,1);		w = size(img,2);

sobelFilter_UD = fspecial('sobel');
sobelFilter_DU = flipud(sobelFilter_UD);
sobelFilter_LR = sobelFilter_UD';
sobelFilter_RL = fliplr(sobelFilter_LR);

filteredImage_LR = double( imfilter(img, sobelFilter_LR, 'same') )/255;
filteredImage_RL = double( imfilter(img, sobelFilter_RL, 'same') )/255;
filteredImage_V = filteredImage_LR + filteredImage_RL;

filteredImage_UD = double( imfilter(img, sobelFilter_UD, 'same') )/255;
filteredImage_DU = double( imfilter(img, sobelFilter_DU, 'same') )/255;
filteredImage_H = filteredImage_UD + filteredImage_DU;


filteredImage = ( filteredImage_V.^2 + filteredImage_H.^2 ).^0.5;

%四個邊緣設成0
filteredImage( 1, 1:w ) = filteredImage( 2, 1:w );
filteredImage( h, 1:w ) = filteredImage( h-1, 1:w );
filteredImage( 1:h, 1 ) = filteredImage( 1:h, 2 );
filteredImage( 1:h, w ) = filteredImage( 1:h, w-1 );
