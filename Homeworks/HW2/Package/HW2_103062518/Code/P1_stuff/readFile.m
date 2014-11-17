fileID = fopen('Pt2D.txt','r');
data_x = fscanf(fileID,'%f %f', [2 inf] );

fileID = fopen('Pt3D.txt','r');
data_X = fscanf(fileID,'%f %f', [3 inf] );