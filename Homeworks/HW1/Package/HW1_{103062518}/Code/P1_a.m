%a.  Perform the Gaussian smoothing of different scales ( £m  =1, 5).
%Show the results using kernel of size 11-by-11. (4 images) 

%% Create Gaussian filters
gFilter1 = fspecial('gaussian', [11 11], 1);
gFilter5 = fspecial('gaussian', [11 11], 5);

%% Show difference between "good Gaussian Filter" and "conventional Gaussian Filter"
figure; set(gcf,'color',[0.4 0.4 0.4]);
subplot (2,3,1);			imshow(img1_Cropped);
subplot (2,3,2);			imshow( imfilter(img1_Cropped, gFilter1, 'same') );
subplot (2,3,3);			imshow( imfilter(img1_Cropped, gFilter5, 'same') );

subplot (2,3,4);			imshow( img1_Cropped );
subplot (2,3,5);			imshow( good_GaussianFilter(img1_Cropped, 11, 1) );
subplot (2,3,6);			imshow( good_GaussianFilter(img1_Cropped, 11, 5) );

%% Filter images
img1_Blurred1 = good_GaussianFilter(img1, 11, 1);
img2_Blurred1 = good_GaussianFilter(img2, 11, 1);

img1_Blurred5 = good_GaussianFilter(img1, 11, 5);
img2_Blurred5 = good_GaussianFilter(img2, 11, 5);

%% Show Filtered images
figure; set(gcf,'color',[0.4 0.4 0.4]);
subplot (2,3,1);			imshow(img1);
subplot (2,3,2);			imshow(img1_Blurred1);
subplot (2,3,3);			imshow(img1_Blurred5);

subplot (2,3,4);			imshow(img2);
subplot (2,3,5);			imshow(img2_Blurred1);
subplot (2,3,6);			imshow(img2_Blurred5);

%% Output Filtered Images
imwrite( img1_Blurred1, strcat( outputDir, '/P1a_1.jpg' ) );
imwrite( img1_Blurred5, strcat( outputDir, '/P1a_2.jpg' ) );
imwrite( img2_Blurred1, strcat( outputDir, '/P1a_3.jpg' ) );
imwrite( img2_Blurred5, strcat( outputDir, '/P1a_4.jpg' ) );