ori_imageName = {  'img1_Blur1_Win3', 'img1_Blur1_Win5', 'img1_Blur5_Win3', 'img1_Blur5_Win5', ...
								  'img2_Blur1_Win3', 'img2_Blur1_Win5', 'img2_Blur5_Win3', 'img2_Blur5_Win5' };

rot_imageName = {  'im1r_Blur1_Win3', 'im1r_Blur1_Win5', 'im1r_Blur5_Win3', 'im1r_Blur5_Win5', ...
								   'im2r_Blur1_Win3', 'im2r_Blur1_Win5', 'im2r_Blur5_Win3', 'im2r_Blur5_Win5'  };

sca_imageName = {	'im1s_Blur1_Win3', 'im1s_Blur1_Win5', 'im1s_Blur5_Win3', 'im1s_Blur5_Win5', ...
									'im2s_Blur1_Win3', 'im2s_Blur1_Win5', 'im2s_Blur5_Win3', 'im2s_Blur5_Win5' };
								
%% Compare ori and rot
figure;
for imgI = 1 : 8
	
	%Read Ori Images
	thisOriIimage = imread(  strcat(outputDirs{3}, '/P2_c_', ori_imageName{imgI}, '_b.jpg')  );
	
	%Rotate Ori Images¡AFor first image, Rotate 25 deg; 2nd, 30 deg
	if imgI <= 4
		thisOriImage_R = imrotate(thisOriIimage,25,'bicubic');
	else
		thisOriImage_R = imrotate(thisOriIimage,30,'bicubic');
	end
	
	%read Rotated Images
	thisRotImage = imread(  strcat(outputDirs{4}, '/P2_d_', rot_imageName{imgI}, '.jpg')  );
	
	%Compare Images
	clear compareImage;
	% Purple
	compareImage( :, :, 1) = thisOriImage_R;
	compareImage( :, :, 3) = thisOriImage_R;
	% Green
	compareImage( :, :, 2) = thisRotImage;
	
	%Compare Them
	subplot( 2, 4, imgI );
	imshow (compareImage);
	imwrite ( compareImage, strcat(outputDirs{5}, '/P2_e_[', ori_imageName{imgI}, ']v.s[', rot_imageName{imgI},']','.jpg') );
end


%% Compare ori and sca
figure;
for imgI = 1 : 8
	
	%Read Ori Images
	thisOriIimage = imread(  strcat(outputDirs{3}, '/P2_c_', ori_imageName{imgI}, '_b.jpg')  );
	
	%Rotate Ori Images¡AFor first image, Rotate 25 deg; 2nd, 30 deg
	if imgI <= 4
		thisOriImage_S = imresize(thisOriIimage,1.3,'bicubic');
	else
		thisOriImage_S = imresize(thisOriIimage,1.4,'bicubic');
	end
	
	%read Rotated Images
	thisRotImage = imread(  strcat(outputDirs{4}, '/P2_d_', sca_imageName{imgI}, '.jpg')  );

	%Compare Images
	clear compareImage;
	% Purple
	compareImage( :, :, 1) = thisOriImage_S;
	compareImage( :, :, 3) = thisOriImage_S;
	% Green
	compareImage( :, :, 2) = thisRotImage;
	
	%Compare Them
	subplot( 2, 4, imgI );
	imshow (compareImage);
	imwrite ( compareImage, strcat(outputDirs{5}, '/P2_e_[', ori_imageName{imgI}, ']v.s[', sca_imageName{imgI},']','.jpg') );
end




