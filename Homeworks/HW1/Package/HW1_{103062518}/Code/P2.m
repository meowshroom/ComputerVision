%(50%) Detect the corners of the above two images by using the
%Harris corner detector. Perform the following step-by-step procedure: 

clear all; close all; clc;

disp('Preparing...\n');
tic;
%% Read Images
img1 = imread('data/im1.jpg');
img2 = imread('data/im2.jpg');
im1r = imread('data/im1r.jpg');
im1s = imread('data/im1s.jpg'); 
im2r = imread('data/im2r.jpg');
im2s = imread('data/im2s.jpg');


%% Output Directory
outputDirs = { 'P2_results_A', 'P2_results_B', 'P2_results_C', 'P2_results_D', 'P2_results_E'  };
for outI = 1 : 5
	if exist( outputDirs{outI} ) ~=7 ;
		mkdir( outputDirs{outI} );
	end
end
toc;

%% Execute P2a
disp('Executing P2_a...');
tic;
P2_a;
toc;

%% Execute P2b
disp('Executing P2_b...');
tic;
P2_b;
toc;

%% Execute P2c
disp('Executing P2_c...');
tic;
P2_c;
toc;

%% Execute P2d
disp('Executing P2_d...');
tic;
P2_d;
toc;

%% Execute P2e
disp('Executing P2_e...');
tic;
P2_e;
toc;


