%% Filter images
im1r_Blurred1 = good_GaussianFilter(im1r, 11, 1);
im1r_Blurred5 = good_GaussianFilter(im1r, 11, 5);
im1s_Blurred1 = good_GaussianFilter(im1s, 11, 1);
im1s_Blurred5 = good_GaussianFilter(im1s, 11, 5);


im2r_Blurred1 = good_GaussianFilter(im2r, 11, 1);
im2r_Blurred5 = good_GaussianFilter(im2r, 11, 5);
im2s_Blurred1 = good_GaussianFilter(im2s, 11, 1);
im2s_Blurred5 = good_GaussianFilter(im2s, 11, 5);

%EigenValues
%¸ÑÄÀÂ²ºÙ : i1_1_s_3 : image1, blur sigma=1, small eigenvalue, window size=3x3

disp('Processing image 1r (1/4)...\n');
[i1r_1_s_3, i1r_1_b_3] = getEigenImage(im1r_Blurred1, 3);
[i1r_1_s_5, i1r_1_b_5] = getEigenImage(im1r_Blurred1, 5);
[i1r_5_s_3, i1r_5_b_3] = getEigenImage(im1r_Blurred5, 3);
[i1r_5_s_5, i1r_5_b_5] = getEigenImage(im1r_Blurred5, 5);

disp('Processing image 1s (2/4)...\n');
[i1s_1_s_3, i1s_1_b_3] = getEigenImage(im1s_Blurred1, 3);
[i1s_1_s_5, i1s_1_b_5] = getEigenImage(im1s_Blurred1, 5);
[i1s_5_s_3, i1s_5_b_3] = getEigenImage(im1s_Blurred5, 3);
[i1s_5_s_5, i1s_5_b_5] = getEigenImage(im1s_Blurred5, 5);

disp('Processing image 2r (3/4)...\n');
[i2r_1_s_3, i2r_1_b_3] = getEigenImage(im2r_Blurred1, 3);
[i2r_1_s_5, i2r_1_b_5] = getEigenImage(im2r_Blurred1, 5);
[i2r_5_s_3, i2r_5_b_3] = getEigenImage(im2r_Blurred5, 3);
[i2r_5_s_5, i2r_5_b_5] = getEigenImage(im2r_Blurred5, 5);

disp('Processing image 2s (4/4)...\n');
[i2s_1_s_3, i2s_1_b_3] = getEigenImage(im2s_Blurred1, 3);
[i2s_1_s_5, i2s_1_b_5] = getEigenImage(im2s_Blurred1, 5);
[i2s_5_s_3, i2s_5_b_3] = getEigenImage(im2s_Blurred5, 3);
[i2s_5_s_5, i2s_5_b_5] = getEigenImage(im2s_Blurred5, 5);

%Corner from 2b : 
%i1r_1_b_3 : image1, rotation, gaussian sigma=1, Corner, window size 3x3 
i1r_1_c_3 = cornerResponse( i1r_1_s_3, i1r_1_b_3, 0.04 );
i1r_1_c_5 = cornerResponse( i1r_1_s_5, i1r_1_b_5, 0.04 );
i1r_5_c_3 = cornerResponse( i1r_5_s_3, i1r_5_b_3, 0.04 );
i1r_5_c_5 = cornerResponse( i1r_5_s_5, i1r_5_b_5, 0.04 );

i1s_1_c_3 = cornerResponse( i1s_1_s_3, i1s_1_b_3, 0.04 );
i1s_1_c_5 = cornerResponse( i1s_1_s_5, i1s_1_b_5, 0.04 );
i1s_5_c_3 = cornerResponse( i1s_5_s_3, i1s_5_b_3, 0.04 );
i1s_5_c_5 = cornerResponse( i1s_5_s_5, i1s_5_b_5, 0.04 );

i2r_1_c_3 = cornerResponse( i2r_1_s_3, i2r_1_b_3, 0.04 );
i2r_1_c_5 = cornerResponse( i2r_1_s_5, i2r_1_b_5, 0.04 );
i2r_5_c_3 = cornerResponse( i2r_5_s_3, i2r_5_b_3, 0.04 );
i2r_5_c_5 = cornerResponse( i2r_5_s_5, i2r_5_b_5, 0.04 );

i2s_1_c_3 = cornerResponse( i2s_1_s_3, i2s_1_b_3, 0.04 );
i2s_1_c_5 = cornerResponse( i2s_1_s_5, i2s_1_b_5, 0.04 );
i2s_5_c_3 = cornerResponse( i2s_5_s_3, i2s_5_b_3, 0.04 );
i2s_5_c_5 = cornerResponse( i2s_5_s_5, i2s_5_b_5, 0.04 );

corners_P2d = { i1r_1_c_3, i1r_1_c_5, i1r_5_c_3, i1r_5_c_5, i1s_1_c_3, i1s_1_c_5, i1s_5_c_3, i1s_5_c_5, ...
							i2r_1_c_3, i2r_1_c_5, i2r_5_c_3, i2r_5_c_5, i2s_1_c_3, i2s_1_c_5, i2s_5_c_3, i2s_5_c_5  };

%% Seeds
for seedI = 1 : 16
	seeds{seedI} = findLocalMax ( corners_P2d{seedI} );
end

%% Other Definitions
inputImages = { im1r_Blurred1, im1r_Blurred1, im1r_Blurred5, im1r_Blurred5, im1s_Blurred1, im1s_Blurred1, im1s_Blurred5, im1s_Blurred5,...
							im2r_Blurred1, im2r_Blurred1, im2r_Blurred5, im2r_Blurred5, im2s_Blurred1, im2s_Blurred1, im2s_Blurred5, im2s_Blurred5  };				
						
imageName = {  'im1r_Blur1_Win3', 'im1r_Blur1_Win5', 'im1r_Blur5_Win3', 'im1r_Blur5_Win5', ...
							'im1s_Blur1_Win3', 'im1s_Blur1_Win5', 'im1s_Blur5_Win3', 'im1s_Blur5_Win5', ...
							'im2r_Blur1_Win3', 'im2r_Blur1_Win5', 'im2r_Blur5_Win3', 'im2r_Blur5_Win5', ...
							'im2s_Blur1_Win3', 'im2s_Blur1_Win5', 'im2s_Blur5_Win3', 'im2s_Blur5_Win5', };
	
thresholds = [ 0.17, 0.06;		0.15, 0.05;		0.09, 0.04;		0.09, 0.04;		0.17, 0.06;		0.15, 0.05;		0.09, 0.04;		0.09, 0.04;...
						0.30, 0.05;		0.25, 0.04;		0.18, 0.04;		0.12, 0.09;		0.30, 0.05;		0.25, 0.04;		0.18, 0.04;		0.12, 0.09;  ];


%% Perform Non-maximal suppression and output images



for imgI = 1 : 16
	fprintf('%d/16 ', imgI);
	
	subplot(4,4,imgI);
	
	thr1 = thresholds( imgI );
	thr2 = thresholds( imgI );
	
	thisEdge = non_maximal_suppersion ( inputImages{imgI}, thr1, thr2, seeds{imgI} );
	imwrite ( thisEdge, strcat(outputDirs{4}, '/P2_d_', imageName{imgI}, '.jpg') );
	imshow ( thisEdge );
	
end
fprintf('\n');