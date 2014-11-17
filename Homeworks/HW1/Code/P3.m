%(10%) Implement the LBP feature vector, in its original form, using (8,1) 
%neighborhood on the above 2 images.

clear all; close all; clc;

disp('Preparing...\n');
tic;
%% Read Images
img1 = imread('data/im1.jpg');
img2 = imread('data/im2.jpg');

%% Output Directory
outputDir = 'P3_results';
if exist(outputDir) ~=7 ;
		mkdir(outputDir);
end
toc;

%% Execute P3a
disp('Executing P3_a...');
tic;
P3_a;
toc;