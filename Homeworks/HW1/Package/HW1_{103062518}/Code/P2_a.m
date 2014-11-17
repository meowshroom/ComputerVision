%a.  Use the Sobel gradient images of two different scales from problem I.b to 
%compute the structure tensor of a pixel H. Show the images of the smaller 
%eigenvalue of H for window size 3-by-3 and 5-by-5, respectively. (8 images) 

%% 4 input images
img1_Blurred1 = good_GaussianFilter(img1, 11, 1);
img1_Blurred5 = good_GaussianFilter(img1, 11, 5);
img2_Blurred1 = good_GaussianFilter(img2, 11, 1);
img2_Blurred5 = good_GaussianFilter(img2, 11, 5);

%% Calculate smaller eigenValue
%¸ÑÄÀÂ²ºÙ : i1_1_s_3 : image1, blur sigma=1, small eigenvalue, window size=3x3
disp('Processing image 1 (1/4)...\n');
[i1_1_s_3, i1_1_b_3] = getEigenImage(img1_Blurred1, 3);
[i1_1_s_5, i1_1_b_5] = getEigenImage(img1_Blurred1, 5);
disp('Processing image 1 (2/4)...\n');
[i1_5_s_3, i1_5_b_3] = getEigenImage(img1_Blurred5, 3);
[i1_5_s_5, i1_5_b_5] = getEigenImage(img1_Blurred5, 5);
disp('Processing image 2 (3/4)...\n');
[i2_1_s_3, i2_1_b_3] = getEigenImage(img2_Blurred1, 3);
[i2_1_s_5, i2_1_b_5] = getEigenImage(img2_Blurred1, 5);
disp('Processing image 2 (4/4)...\n');
[i2_5_s_3, i2_5_b_3] = getEigenImage(img2_Blurred5, 3);
[i2_5_s_5, i2_5_b_5] = getEigenImage(img2_Blurred5, 5);

%% Collection
small_eig_images = { i1_1_s_3, i1_1_s_5, i1_5_s_3, i1_5_s_5, i2_1_s_3, i2_1_s_5, i2_5_s_3, i2_5_s_5 };

big_eig_images = { i1_1_b_3, i1_1_b_5, i1_5_b_3, i1_5_b_5, i2_1_b_3, i2_1_b_5, i2_5_b_3, i2_5_b_5 };

imageName = {  'img1_Blur1_Win3', 'img1_Blur1_Win5', 'img1_Blur5_Win3', 'img1_Blur5_Win5', ...
							'img2_Blur1_Win3', 'img2_Blur1_Win5', 'img2_Blur5_Win3', 'img2_Blur5_Win5' };

%% Show Images
figure;
for imgI = 1 : 8
	subplot(4,4,imgI*2-1);
	imshow ( small_eig_images{imgI} );
	imwrite ( small_eig_images{imgI}, strcat(outputDirs{1}, '/P2_a_', imageName{imgI}, '.jpg') );
	%imwrite ( big_eig_images{imgI}, strcat(outputDir, '/P2_a_Øp', imageName{imgI}, '.jpg') );
	
	subplot(4,4,imgI*2);
	small_eig_images{imgI}(small_eig_images{imgI}>0.1)=1;
	imshow ( small_eig_images{imgI} );
	imwrite ( small_eig_images{imgI}, strcat(outputDirs{1}, '/P2_a_', imageName{imgI}, '_binarized.jpg') );
	
	%big_eig_images{imgI}(big_eig_images{imgI}>0.1)=1;
	%imwrite ( big_eig_images{imgI}, strcat(outputDir, '/P2_a_Øp', imageName{imgI}, '_binarized.jpg') );
end

