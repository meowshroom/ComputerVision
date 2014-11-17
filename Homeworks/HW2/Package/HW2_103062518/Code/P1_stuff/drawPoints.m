figure;

subplot(1,2,1);
scatter ( data_x(1,:), data_x(2,:) );

subplot(1,2,2);
scatter3 ( data_X(1,:), data_X(2,:), data_X(3,:) );
camproj('perspective');