i1_1_c_3 = cornerResponse( i1_1_s_3, i1_1_b_3, 0.04 );
i1_1_c_5 = cornerResponse( i1_1_s_5, i1_1_b_5, 0.04 );
i1_5_c_3 = cornerResponse( i1_5_s_3, i1_5_b_3, 0.04 );
i1_5_c_5 = cornerResponse( i1_5_s_5, i1_5_b_5, 0.04 );
i2_1_c_3 = cornerResponse( i2_1_s_3, i2_1_b_3, 0.04 );
i2_1_c_5 = cornerResponse( i2_1_s_5, i2_1_b_5, 0.04 );
i2_5_c_3 = cornerResponse( i2_5_s_3, i2_5_b_3, 0.04 );
i2_5_c_5 = cornerResponse( i2_5_s_5, i2_5_b_5, 0.04 );

%% Collection
small_corner_images = { i1_1_c_3, i1_1_c_5, i1_5_c_3, i1_5_c_5, i2_1_c_3, i2_1_c_5, i2_5_c_3, i2_5_c_5 };
thresholds = [ 0.05, 0.2, 0.001, 0.01, 0.2, 0.9, 0.0001, 0.002 ];

imageName = {  'img1_Blur1_Win3', 'img1_Blur1_Win5', 'img1_Blur5_Win3', 'img1_Blur5_Win5', ...
							'img2_Blur1_Win3', 'img2_Blur1_Win5', 'img2_Blur5_Win3', 'img2_Blur5_Win5' };
						
%% Show Images
figure;
for imgI = 1 : 8
	subplot(4,4,imgI*2-1);
	imshow ( small_corner_images{imgI} );
	imwrite ( small_corner_images{imgI}, strcat(outputDirs{2}, '/P2_b_', imageName{imgI}, '.jpg') );
	
	subplot(4,4,imgI*2);
	small_corner_images{imgI} ( small_corner_images{imgI}>thresholds(imgI) ) =1;
	small_corner_images{imgI} ( small_corner_images{imgI}<=thresholds(imgI) ) =0;
	imshow ( small_corner_images{imgI} );
	imwrite ( small_corner_images{imgI}, strcat(outputDirs{2}, '/P2_b_', imageName{imgI}, '_binarized.jpg') );
end
