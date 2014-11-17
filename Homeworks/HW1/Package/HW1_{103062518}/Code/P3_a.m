%(10%) Implement the LBP feature vector, in its original form, using (8,1) 
%neighborhood on the above 2 images.
[ h1, w1 ] = size(img1);
[ h2, w2 ] = size(img2);

imgs = { img1, img2 };
for imgI = 1 : 2

	thisImg_Center_lbp = getLBP( imgs{imgI}, 1 );
	thisImg_Center_lbp_rotated = rotateLBP( thisImg_Center_lbp );
	
	subplot( 2, 2, imgI*2-1 );
	imshow( thisImg_Center_lbp/255 );
	imwrite ( thisImg_Center_lbp/255, sprintf( '%s/P3_equal1_img%d.jpg', outputDir, imgI ) );
	
	subplot( 2, 2, imgI*2 );
	imshow( thisImg_Center_lbp_rotated/255 );
	imwrite ( thisImg_Center_lbp_rotated/255, sprintf( '%s/P3_equal1_rotated_img%d.jpg', outputDir, imgI ) );
	
	imgs_LBP{imgI} = thisImg_Center_lbp;
	imgs_LBP_rotated{imgI} = thisImg_Center_lbp_rotated;
end

figure;
whitebg([0.6 0.6 0.6]);
set(gca,'FontSize',18);


subplot( 2, 2, 1 );
histMeow = reshape( imgs_LBP{1}, [(h1-2)*(w1-2), 1] );
hist( histMeow, 256 );
xlabel( 'LBP of Image 1' , 'FontSize', 20, 'fontWeight','bold');

subplot( 2, 2, 2 );
histMeow = reshape( imgs_LBP_rotated{1}, [(h1-2)*(w1-2), 1] );
hist( histMeow, 256 );
xlabel( 'Rotated LBP of Image 1' , 'FontSize', 20, 'fontWeight','bold' );

subplot( 2, 2, 3 );
histMeow = reshape( imgs_LBP{2}, [(h2-2)*(w2-2), 1] );
hist( histMeow, 256 );
xlabel( 'LBP of Image 2' , 'FontSize', 20, 'fontWeight','bold' );

subplot( 2, 2, 4 );
histMeow = reshape( imgs_LBP_rotated{2}, [(h2-2)*(w2-2), 1] );
hist( histMeow, 256 );
xlabel( 'Rotated LBP of Image 2' , 'FontSize', 20, 'fontWeight','bold' );

set(gcf,'color',[0.8 0.8 0.8]);