%Perform non-maximal suppression with appropriate gradient thresholding 
%for edge detection. (4 images) 

%% Generate Seeds
%seeds_1_5 第一張圖片，Gaussian sigma = 1的seed
seeds_1_1 = findLocalMax ( img1_Blurred1_gradient );
seeds_1_5 = findLocalMax ( img1_Blurred5_gradient );
seeds_2_1 = findLocalMax ( img2_Blurred1_gradient );
seeds_2_5 = findLocalMax ( img2_Blurred5_gradient );

%% Do non_maximal_suppersion
fprintf('1/4 ');
img1_Blurred1_edge = non_maximal_suppersion ( img1_Blurred1, 0.40, 0.15, seeds_1_1 );
fprintf('2/4 ');
img1_Blurred5_edge = non_maximal_suppersion ( img1_Blurred5, 0.20, 0.08, seeds_1_5 );
fprintf('3/4 ');
img2_Blurred1_edge = non_maximal_suppersion ( img2_Blurred1, 0.40, 0.15, seeds_2_1 );
fprintf('4/4 ');
img2_Blurred5_edge = non_maximal_suppersion ( img2_Blurred5, 0.20, 0.11, seeds_2_5 );
disp('');

%% Output edge Images
imwrite( img1_Blurred1_edge, strcat( outputDir, '/P1c_1.jpg' ) );
imwrite( img1_Blurred5_edge, strcat( outputDir, '/P1c_2.jpg' ) );
imwrite( img2_Blurred1_edge, strcat( outputDir, '/P1c_3.jpg' ) );
imwrite( img2_Blurred5_edge, strcat( outputDir, '/P1c_4.jpg' ) );

%% Show edge Images.
figure;
subplot (2, 2, 1); imshow(img1_Blurred1_edge);
subplot (2, 2, 2); imshow(img1_Blurred5_edge);
subplot (2, 2, 3); imshow(img2_Blurred1_edge);
subplot (2, 2, 4); imshow(img2_Blurred5_edge);