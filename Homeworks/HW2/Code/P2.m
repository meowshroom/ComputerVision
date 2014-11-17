clear all; close all; clc; tic;

%% Environment
addpath('P2_stuff');

%% Output Directory
outputDir = 'P2_results';
if exist(outputDir) ~=7 ;
		mkdir(outputDir);
end

%% Load data : Image (and predifined "patch corner points")
% X�O������m�A�̥��欰0�A�����x�}����2��index
% Y�O�]����m�A�̤W�C��0�A�����x�}����1��index
load imgAndCorners;

%% Compute Homograpgy Matrix : hmgphyMat�ѥ����I=�k���I
[ leftPoint_Homo, rightPoint_Homo, hmgphyMat ] = getHomographyMat( [x_L;y_L], [x_R;y_R] );
a = hmgphyMat * [74; 336; 1];
a = a ./ repmat( a(3,:), [3 1] );

%% Get 2 masks, in which 1 means the corresponding pixel needs homography transforming
mask_L = rgb2gray( imread('Lmask.png') );
mask_L = double(mask_L)/255;
mask_L = mask_L / max(max(mask_L));
mask_R = rgb2gray( imread('Rmask.png') );
mask_R = double(mask_R)/255;
mask_R = mask_R / max(max(mask_R));
masks = repmat(mask_L+mask_R, [1,1,3]) ; %�S�s��Mask�A�b�e��������3��channel������

%% �����B�z
im1f = double(im1)/255;

figure;
subplot(1,3,1); imshow(im1f);

%���u�ʤ���
img_post_R = getPatchTransform( im1f, mask_R, inv(hmgphyMat), true ); %�⥪�䪺�K��k��
img_post_L = getPatchTransform( im1f, mask_L, hmgphyMat, true ); %��k�䪺�K�쥪��
img_post = img_post_R + img_post_L ;
subplot(1,3,2); imshow( img_post );

%�[�J�I��
background = im1f;
img_post = (img_post .* masks) + (im1f .* (1-masks));
%background(masks~=0)=0;
%img_post = img_post + background;
subplot(1,3,3); imshow( img_post );
imwrite( img_post, strcat(outputDir, '/Result.jpg') );

%focused_patch
focused_patch = img_post( 400:600, 40:80, : );
imwrite(focused_patch, strcat(outputDir, '/focused_patch.jpg'));