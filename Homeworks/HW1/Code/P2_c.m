% Perform non-maximal suppression on the results from II.a and II.b along with appropriate 
% thresholding for corner detection. Please discuss the results. (16 images) 

%% Generate Seeds
%seeds_a_1_1_3 : 使用3a的作法，第1張圖片，Gaussian sigma = 1，window size = 3x3 的seed

%Seed from 2a
seeds_a_1_1_3 = findLocalMax ( i1_1_s_3 );
seeds_a_1_1_5 = findLocalMax ( i1_1_s_5 );
seeds_a_1_5_3 = findLocalMax ( i1_5_s_3 );
seeds_a_1_5_5 = findLocalMax ( i1_5_s_5 );
seeds_a_2_1_3 = findLocalMax ( i2_1_s_3 );
seeds_a_2_1_5 = findLocalMax ( i2_1_s_5 );
seeds_a_2_5_3 = findLocalMax ( i2_5_s_3 );
seeds_a_2_5_5 = findLocalMax ( i2_5_s_5 );

%Seed from 2b
seeds_b_1_1_3 = findLocalMax ( i1_1_c_3 );
seeds_b_1_1_5 = findLocalMax ( i1_1_c_5 );
seeds_b_1_5_3 = findLocalMax ( i1_5_c_3 );
seeds_b_1_5_5 = findLocalMax ( i1_5_c_5 );
seeds_b_2_1_3 = findLocalMax ( i2_1_c_3 );
seeds_b_2_1_5 = findLocalMax ( i2_1_c_5 );
seeds_b_2_5_3 = findLocalMax ( i2_5_c_3 );
seeds_b_2_5_5 = findLocalMax ( i2_5_c_5 );

seeds = { seeds_a_1_1_3, seeds_a_1_1_5, seeds_a_1_5_3, seeds_a_1_5_5, seeds_a_2_1_3, seeds_a_2_1_5, seeds_a_2_5_3, seeds_a_2_5_5,...
			   seeds_b_1_1_3, seeds_b_1_1_5, seeds_b_1_5_3, seeds_b_1_5_5, seeds_b_2_1_3, seeds_b_2_1_5, seeds_b_2_5_3, seeds_b_2_5_5  };

inputImages = { img1_Blurred1, img1_Blurred1, img1_Blurred5, img1_Blurred5, img2_Blurred1, img2_Blurred1, img2_Blurred5, img2_Blurred5,...
							img1_Blurred1, img1_Blurred1, img1_Blurred5, img1_Blurred5, img2_Blurred1, img2_Blurred1, img2_Blurred5, img2_Blurred5  };

imageName = {  'img1_Blur1_Win3_a', 'img1_Blur1_Win5_a', 'img1_Blur5_Win3_a', 'img1_Blur5_Win5_a', ...
							'img2_Blur1_Win3_a', 'img2_Blur1_Win5_a', 'img2_Blur5_Win3_a', 'img2_Blur5_Win5_a', ...
							'img1_Blur1_Win3_b', 'img1_Blur1_Win5_b', 'img1_Blur5_Win3_b', 'img1_Blur5_Win5_b', ...
							'img2_Blur1_Win3_b', 'img2_Blur1_Win5_b', 'img2_Blur5_Win3_b', 'img2_Blur5_Win5_b', };
	
thresholds = [ 0.18, 0.07;		0.16, 0.06;		0.10, 0.05;		0.10, 0.05;		0.40, 0.06;		0.36, 0.05;		0.20, 0.05;		0.15, 0.11;...
						0.17, 0.06;		0.15, 0.05;		0.09, 0.04;		0.09, 0.04;		0.30, 0.05;		0.25, 0.04;		0.18, 0.04;		0.12, 0.09;  ];
						
						
%% Perform Non-maximal suppression and output images
for imgI = 1 : 16
	fprintf('%d/16 ', imgI);
	
	subplot(4,4,imgI);
	
	thr1 = thresholds( imgI );
	thr2 = thresholds( imgI );
	
	thisEdge = non_maximal_suppersion ( inputImages{imgI}, thr1, thr2, seeds{imgI} );
	imwrite ( thisEdge, strcat(outputDirs{3}, '/P2_c_', imageName{imgI}, '.jpg') );
	imshow ( thisEdge );
	
end
fprintf('\n');