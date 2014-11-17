%b.  Apply the Sobel masks to the above Gaussian smoothed images and 
%compute the magnitude of gradient images.  (4 images) 

img1_Blurred1_gradient = sobelFilter( img1_Blurred1 );
img1_Blurred5_gradient = sobelFilter( img1_Blurred5 );
img2_Blurred1_gradient = sobelFilter( img2_Blurred1 );
img2_Blurred5_gradient = sobelFilter( img2_Blurred5 );


%Show the Filtered result
figure; set(gcf,'color',[0.4 0.4 0.4]);
subplot (2,3,1);			imshow(img1);
subplot (2,3,2);			imshow(img1_Blurred1_gradient);
subplot (2,3,3);			imshow(img1_Blurred5_gradient);

subplot (2,3,4);			imshow(img2);
subplot (2,3,5);			imshow(img2_Blurred1_gradient);
subplot (2,3,6);			imshow(img2_Blurred5_gradient);

%% Output Filtered Images
imwrite( img1_Blurred1_gradient, strcat( outputDir, '/P1b_1.jpg' ) );
imwrite( img1_Blurred5_gradient, strcat( outputDir, '/P1b_2.jpg' ) );
imwrite( img2_Blurred1_gradient, strcat( outputDir, '/P1b_3.jpg' ) );
imwrite( img2_Blurred5_gradient, strcat( outputDir, '/P1b_4.jpg' ) );