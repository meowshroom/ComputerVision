%Q1:
%
%Perform the following steps sequentially to the two images below for edge 
%detection. Write each of the following steps as a separate function and show the 
%step-by-step results. 
%

clear all; close all; clc;

disp('Preparing...\n');
tic;

%% Read Images
img1 = imread('data/im1.jpg');
img2 = imread('data/im2.jpg');

%% Output Directory
outputDir = 'P1_results';
if exist(outputDir) ~=7 ;
		mkdir(outputDir);
end

%% Crop Images
img1h = size( img1, 1);			img1h_unit = round( img1h /4);
img1w = size( img1, 2);			img1w_unit = round( img1w /5);

img2h = size( img2, 1);			img2h_unit = round( img2h /4);
img2w = size( img2, 2);			img2w_unit = round( img2w /5);	

img1_Cropped = img1( 1:img1h_unit, img1w_unit*2:img1w_unit*4  );
img2_Cropped = img2( 1:img2h_unit, img2w_unit*2:img2w_unit*4  );

toc;
%% Execute P1a to get 
%[img1_Blurred1] 
%[img1_Blurred5] 
%[img2_Blurred1] 
%[img2_Blurred5]
disp('Executing P1_a...\n');
tic;
P1_a;
toc;

%% Execute P1b to get
%[img1_Blurred1_gradient] 
%[img1_Blurred5_gradient] 
%[img2_Blurred1_gradient] 
%[img2_Blurred5_gradient]
disp('Executing P1_b...\n');
tic;
P1_b;
toc;

%% Execute P1c to get
%[img1_Blurred1_edge] 
%[img1_Blurred5_edge] 
%[img2_Blurred1_edge] 
%[img2_Blurred5_edge]
disp('Executing P1_c...\n');
tic;
P1_c;
toc;