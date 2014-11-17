clear all; close all; clc; tic;

%% Load Image
im1 = imread('im1.jpg');

%% GUI for point selection and preview
imshow(im1); hold on;

disp('Select 4 corner for the LEFT poster.');
[x_L,y_L]=ginput(4);
x_L(5)=x_L(1);
y_L(5)=y_L(1);

for pI = 1 : 4
	line( x_L(pI:pI+1), y_L(pI:pI+1), 'LineWidth',2, 'Color',[.4 .9 .6], 'LineSmoothing','on' );
end

disp('Select 4 corner for the RIGHT poster.');
[x_R,y_R]=ginput(4);
x_R(5)=x_R(1);
y_R(5)=y_R(1);

for pI = 1 : 4
	line( x_R(pI:pI+1), y_R(pI:pI+1), 'LineWidth',2, 'Color',[.4 .6 .9], 'LineSmoothing','on' );
end

%% Save all variables into data.mat
clear pI;
save data;