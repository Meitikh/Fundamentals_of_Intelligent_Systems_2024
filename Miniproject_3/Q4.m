% ----------------- MahdiKhalilzadeh/9932213 -----------------

%% defining the function

% g function
function g = g_u(u)
    g = 0.6 * sin(pi * u) + 0.3 * sin(3 * pi * u) + 0.1 * sin(5 * pi * u);
end

%% training
M = 6; 
num_train = 150; 
total_data_points = 500; 
lambda = 0.99; 
initial_weight_variance = 100;

u_values = linspace(0, 1, total_data_points);
g_values = arrayfun(@g_u, u_values); 

train_indices = linspace(1, total_data_points, num_train);
test_indices = setdiff(1:total_data_points, round(train_indices));

% Training data
train_u_values = u_values(round(train_indices));
train_g_values = g_values(round(train_indices));

% Testing data
test_u_values = u_values(test_indices);
test_g_values = g_values(test_indices);

% Initialize fuzzy model parameters
initial_centers = linspace(0, 1, M); 
initial_sigmas = 0.1 * ones(1, M); 
initial_weights = rand(1, M); 

% Initialize RLS parameters
P = initial_weight_variance * eye(M);
theta = initial_weights(:);

% Prepare storage for model outputs
fuzzy_values_rls = zeros(size(train_u_values));

% Train model using Recursive Least Squares algorithm
for t = 1:num_train
    % Current input and desired output
    u_t = train_u_values(t);
    g_t = train_g_values(t);
    
    % Calculate the membership functions for the current input
    phi_t = zeros(M, 1); 
    for l = 1:M
        phi_t(l) = exp(-((u_t - initial_centers(l))^2) / (2 * initial_sigmas(l)^2));
    end
    
    % Model output (current approximation)
    f_t = phi_t' * theta;
    fuzzy_values_rls(t) = f_t;
    
    % Error between desired and approximated output
    e_t = g_t - f_t;
    
    % Recursive update of parameters
    K_t = (P * phi_t) / (lambda + phi_t' * P * phi_t); % Gain vector
    theta = theta + K_t * e_t; % Update parameters
    P = (P - K_t * phi_t' * P) / lambda; % Update covariance matrix
end

% Compute the model output for the testing data
test_fuzzy_values = zeros(size(test_u_values));
for i = 1:length(test_u_values)
    u = test_u_values(i);
    phi = zeros(M, 1);
    for l = 1:M
        phi(l) = exp(-((u - initial_centers(l))^2) / (2 * initial_sigmas(l)^2));
    end
    test_fuzzy_values(i) = phi' * theta;
end

% Compute the model output for all data points (for plotting purposes)
identified_output = zeros(size(u_values));
for i = 1:length(u_values)
    u = u_values(i);
    phi = zeros(M, 1);
    for l = 1:M
        phi(l) = exp(-((u - initial_centers(l))^2) / (2 * initial_sigmas(l)^2));
    end
    identified_output(i) = phi' * theta;
end

% Calculate Errors
train_errors = train_g_values - fuzzy_values_rls; % Training errors
test_errors = test_g_values - test_fuzzy_values;  % Testing errors

%% plots

% Plot 1: Desired Output vs. Identified Model Output (All Data)
figure;
plot(1:total_data_points, g_values, 'b-', 'LineWidth', 2); hold on; 
plot(1:total_data_points, identified_output, 'r--', 'LineWidth', 2);
xlabel('Data Points');
ylabel('Output');
legend('Desired Output', 'Identified Model Output', 'Location', 'Best');
title('Plant Output vs. Identified Model Output');
grid on;

% Plot 2: Identification Error (Training & Testing Errors)
figure;
plot(train_u_values, train_errors, 'm-', 'LineWidth', 2); hold on;
plot(test_u_values, test_errors, 'c-', 'LineWidth', 2);
xlabel('u');
ylabel('Error');
legend('Training Errors', 'Testing Errors');
title('Identification Errors (Training & Testing)');
grid on;

% Plot 3: Initial vs. Final Membership Functions
figure;
u_range = linspace(0, 1, 500); 
colors = lines(M); 
hold on;

for l = 1:M
    % Initial membership functions
    initial_membership = exp(-((u_range - initial_centers(l)).^2) / (2 * initial_sigmas(l)^2));
    plot(u_range, initial_membership, 'Color', colors(l, :), 'LineStyle', '--', 'LineWidth', 1.5); 
end

for l = 1:M
    % Final membership functions
    final_membership = exp(-((u_range - initial_centers(l)).^2) / (2 * initial_sigmas(l)^2));
    plot(u_range, final_membership, 'Color', colors(l, :), 'LineStyle', '-', 'LineWidth', 1.5);
end

xlabel('u');
ylabel('Membership Value');
title('Initial vs. Final Membership Functions');
legend(arrayfun(@(l) sprintf('Membership %d', l), 1:M, 'UniformOutput', false), 'Location', 'Best');
grid on;
hold off;
