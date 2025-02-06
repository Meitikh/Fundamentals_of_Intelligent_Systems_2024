% Define the data range
x = -10:0.5:10;
y = -10:0.5:10;
[X, Y] = meshgrid(x, y);

% Compute the values of the sinc function
R = sqrt(X.^2 + Y.^2);
Z = sinc(pi * R);

% Convert data to column format for ANFIS
L1 = reshape(X, [row*col, 1]);
L2 = reshape(Y, [row*col, 1]);
L3 = reshape(Z, [row*col, 1]);
data = [L1, L2, L3];

% Split the data into training and testing sets
train_ratio = 0.7; 
n_train = round(size(data, 1) * train_ratio);
idx = randperm(size(data, 1)); % Random permutation of indices
train_data = data(idx(1:n_train), :);
test_data = data(idx(n_train+1:end), :);

% Generate the initial fuzzy system
numMFs = 3; % Number of membership functions for each input
input_fis = genfis1(train_data, numMFs, 'gaussmf');

% Train the ANFIS model
epoch_n = 100; % Number of training epochs
anfis_model = anfis(train_data, input_fis, epoch_n);

% Predict on test data
test_input = test_data(:, 1:2);
test_target = test_data(:, 3);
predicted_output = evalfis(test_input, anfis_model);

% Compute RMSE
rmse = sqrt(mean((test_target - predicted_output).^2));
disp(['RMSE: ', num2str(rmse)]);

% Plot comparison chart
figure;
scatter3(test_data(:, 1), test_data(:, 2), test_target, 'r', 'filled');
hold on;
scatter3(test_data(:, 1), test_data(:, 2), predicted_output, 'b');
legend('Actual Data', 'ANFIS Prediction');
title('ANFIS Model vs Actual Data');
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;

% Display the surface of the actual and predicted functions
[X_test, Y_test] = meshgrid(x, y);
test_input_full = [X_test(:), Y_test(:)];
predicted_surface = evalfis(test_input_full, anfis_model);
predicted_surface = reshape(predicted_surface, size(X_test));

figure;
subplot(1, 2, 1);
surf(X, Y, Z);
title('Actual sinc Function');
xlabel('X');
ylabel('Y');
zlabel('Z');

subplot(1, 2, 2);
surf(X_test, Y_test, predicted_surface);
title('ANFIS Predicted Function');
xlabel('X');
ylabel('Y');
zlabel('Z');
