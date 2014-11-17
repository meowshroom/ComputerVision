%%
testOutputDir = 'P2_test';
if exist(testOutputDir) ~=7 ;
		mkdir(testOutputDir);
end

%%
img_chessboard = imread('data/chessboard.jpg');
img_chessboard_blurred1 = good_GaussianFilter(img_chessboard, 11, 1);
[ic_1_s_3, ic_1_b_3] = getEigenImage(img_chessboard_blurred1, 5);

%% 較小的eigenVector所形成的圖片
h = size(img_chessboard,1);		w = size(img_chessboard,2);
merged = zeros( h, w, 3 );
merged2 = zeros( h, w, 3 );

ic_1_s_3 = ic_1_s_3/ max(max(ic_1_s_3));

ic_1_s_3(ic_1_s_3>0.05)=1;
imwrite ( ic_1_s_3, strcat(testOutputDir, '/P2_a_', 'Exp1-1_HThr', '.jpg') );
merged(:, :, 3) = ic_1_s_3;

ic_1_s_3(ic_1_s_3>0.02)=1;
imwrite ( ic_1_s_3, strcat(testOutputDir, '/P2_a_', 'Exp1-2_MThr', '.jpg') );
merged(:, :, 1) = ic_1_s_3;

ic_1_s_3(ic_1_s_3>0.005)=1;
imwrite ( ic_1_s_3, strcat(testOutputDir, '/P2_a_', 'Exp1-3_LThr', '.jpg') );
merged(:, :, 2) = ic_1_s_3;

%% 輸出
imwrite ( merged, strcat(testOutputDir, '/P2_a_', 'Exp1_Merged', '.jpg') );

%% Corner Response 公式
ic_1_c_3 = cornerResponse( ic_1_s_3, ic_1_b_3, 0.04 );

%% 輸出
imwrite ( ic_1_c_3, strcat(testOutputDir, '/P2_b_', 'Exp', '.jpg') );