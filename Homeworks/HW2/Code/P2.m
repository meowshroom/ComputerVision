clear all; close all; clc; tic;

%% Environment
addpath('P2_stuff');

%% Output Directory
outputDir = 'P2_results';
if exist(outputDir) ~=7 ;
		mkdir(outputDir);
end

%% Load data : Image (and predifined "patch corner points")
% X是水平位置，最左欄為0，對應矩陣的第2個index
% Y是鉛直位置，最上列為0，對應矩陣的第1個index
load imgAndCorners;

%% Compute Homograpgy Matrix : hmgphyMat×左邊點=右邊點
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
masks = repmat(mask_L+mask_R, [1,1,3]) ; %特製的Mask，在前景的部分3個channel都有值

%% 直接處理
im1f = double(im1)/255;

figure;
subplot(1,3,1); imshow(im1f);

%雙線性內插
img_post_R = getPatchTransform( im1f, mask_R, inv(hmgphyMat), true ); %把左邊的貼到右邊
img_post_L = getPatchTransform( im1f, mask_L, hmgphyMat, true ); %把右邊的貼到左邊
img_post = img_post_R + img_post_L ;
subplot(1,3,2); imshow( img_post );

%加入背景
background = im1f;
img_post = (img_post .* masks) + (im1f .* (1-masks));
%background(masks~=0)=0;
%img_post = img_post + background;
subplot(1,3,3); imshow( img_post );
imwrite( img_post, strcat(outputDir, '/Result.jpg') );

%focused_patch
focused_patch = img_post( 400:600, 40:80, : );
imwrite(focused_patch, strcat(outputDir, '/focused_patch.jpg'));