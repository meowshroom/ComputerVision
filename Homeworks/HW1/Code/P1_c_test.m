dirname = {'P1_c_test_1_1', 'P1_c_test_1_5', 'P1_c_test_2_1', 'P1_c_test_2_5'};

%% Create Directories
for dirNameI = 1:4
	if exist(dirname{dirNameI}) ~=7 ;
		mkdir(dirname{dirNameI});
	end
end

%seeds_1_5 第一張圖片，Gaussian sigma = 1的seed
seeds_1_1 = findLocalMax ( img1_Blurred1_gradient );
seeds_1_5 = findLocalMax ( img1_Blurred5_gradient );
seeds_2_1 = findLocalMax ( img2_Blurred1_gradient );
seeds_2_5 = findLocalMax ( img2_Blurred5_gradient );


%% Gaussian sigma = 1
progress = 0;
verb = ''; %Prompt
clc;
for thr1 = 0.3 : 0.05 : 0.5
	for thr2 = 0.1 : 0.05 : 0.35
		progress = progress+1;
		
		%印提示訊息
		fprintf( repmat('\b',[1, length(verb)]) ); %印backSpaces
		verb = sprintf( 'Progress : %d / 30', progress ); %印真訊息
		fprintf(verb);
		
		%真的在做事情: img1_Blurred1_edge
		img1_Blurred1_edge = non_maximal_suppersion ( img1_Blurred1, thr1, thr2, seeds_1_1 );
		imwrite( img1_Blurred1_edge, sprintf('%s/[thr1 %.2f][thr2 %.2f].jpg',dirname{1}, thr1, thr2) );
		
		%真的在做事情: img2_Blurred1_edge
		img2_Blurred1_edge = non_maximal_suppersion ( img2_Blurred1, thr1, thr2, seeds_2_1 );
		imwrite( img2_Blurred1_edge, sprintf('%s/[thr1 %.2f][thr2 %.2f].jpg',dirname{3}, thr1, thr2) );
	end
end

%% Gaussian sigma = 5
progress = 0;
verb = ''; %Prompt
clc;
for thr1 = 0.15 : 0.05 : 0.35
	for thr2 = 0.08 : 0.03 : 0.23
		progress = progress+1;
		
		%印提示訊息
		fprintf( repmat('\b',[1, length(verb)]) ); %印backSpaces
		verb = sprintf( 'Progress : %d / 30', progress ); %印真訊息
		fprintf(verb);
		
		%真的在做事情: img1_Blurred5_edge
		img1_Blurred5_edge = non_maximal_suppersion ( img1_Blurred5, thr1, thr2, seeds_1_5 );
		imwrite( img1_Blurred5_edge, sprintf('%s/[thr1 %.2f][thr2 %.2f].jpg',dirname{2}, thr1, thr2) );
		
		%真的在做事情: img2_Blurred1_edge
		img2_Blurred5_edge = non_maximal_suppersion ( img2_Blurred5, thr1, thr2, seeds_2_5 );
		imwrite( img2_Blurred5_edge, sprintf('%s/[thr1 %.2f][thr2 %.2f].jpg',dirname{4}, thr1, thr2) );
	end
end
