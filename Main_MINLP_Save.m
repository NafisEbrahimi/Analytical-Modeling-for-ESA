clc;
clear;
close all;

%% Initialization
%       Npl             D_magnet 
x0 = [   27      ;      7     ]; % Initial Points
lb = [   26      ;      5     ]; % Lower Bounds
ub = [   80      ;      20    ]; % Upper Bounds

% Variable types: 1 = continuous, 2 = integer
xtype = 'IC'; % 'I' for Npl (integer), 'C' for D_magnet (continuous)

% Nonlinear constraints
nlrhs = [0; 0];        % Right-hand side for inequality constraints
nle = [-1; -1];        % Types: -1 = <=

% Create OPTI problem
Opt = opti( 'fun', @(x) objective(x), ...   % Objective function
                   'nlcon', @(x) constr(x), ...    % Constraints
                   'nlrhs', nlrhs, ...                     % RHS of inequality constraints
                   'nle', nle, ...                           % Inequality constraint types
                   'bounds', lb, ub, ...                % Variable bounds
                   'xtype', xtype, ...                   % Variable types
                   'x0', x0, ...                             % Initial guess
                   'options', optiset('display', 'iter', ... % Use MINLP solver
                              'tolrfun', 1e-6, ...
                              'tolafun', 1e-6, ...
                              'maxtime', 500, ...
                              'maxiter', 500)); % Increased iterations for robustness

%% Vector to Save Parameters
global paramVector; 
paramVector = []; % Initialize an empty vector

%% Solve the Problem
global L Nl Npl Lact; % Declare Nl as global to access it outside the function
[~, fopt, exitflag, info] = solve(Opt);

%% Optimal Results
% Find the row in paramVector with the maximum force
[M, I] = max(paramVector(:, end)); % Find max force (last column of paramVector)

% Extract the optimal values
optimalParams = paramVector(I, :); % The row with the maximum force
Npl_opt = optimalParams(1);       % Optimal Number of Turns per Layer
dm_opt = optimalParams(2) * 1e3;  % Optimal Diameter (convert to mm)
Lact_opt = optimalParams(3);      % Lact (total length of the coil)
Nact_opt = optimalParams(4);      % Nact (total number of turns)
Nl_opt = optimalParams(5);        % Optimal Number of Layers
di_opt = optimalParams(6);        % Inner diameter
Fmax = optimalParams(end);        % Maximum Force (already negated in optimization)

% Display the results
disp(['Optimal Number of Turns per Layer: ', num2str(floor(Npl_opt)), ' Turns']);
disp(['Optimal Diameter (dm): ', num2str(dm_opt), ' mm']);
disp(['Number of Layers: ', num2str(Nl_opt), ' Layers']);
disp(['Lact: ', num2str(Lact_opt), ' m']);
disp(['Nact: ', num2str(Nact_opt), ' Turns']);
disp(['Inner Diameter (di): ', num2str(di_opt), ' m']);
disp(['Maximum Force: ', num2str(Fmax), ' mN']);

% Save parameter vector to a file
save('paramVector.mat', 'paramVector');

%% Constraints Function
function [c, ceq] = constr(x)
global L Nl Npl Lact paramVector; % Declare as global
    % Inputs (scaled)
    Npl = x(1); % Number of Turns which is needed to create a layer of coil
    dm = x(2) * 1e-3; % Permanent Magnet diameter in m

    % Fixed Parameters
    L = 10; % Total length (fixed) in m
    g = 0.2e-3; % Air gap between coil and core in m
    dw = 0.160e-3; % Wire diameter in m

    % Derived Parameters
    di = dm + 2 * g; % Inner diameter
    maxLayers = floor(L / (Npl * pi * di)); % Max number of layers
    layerLengths = zeros(1, maxLayers); % Initialize array for layer lengths
    Lact = 0; % Initialize total length
    numofLayers = 0; % Initialize layer count

    for i = 1:maxLayers
        % Calculate the length of the current layer
        layerLengths(i) = Npl * pi * (di + (i - 1) * dw);
        % Check if adding this layer length keeps Lact <= L
        if Lact + layerLengths(i) <= L
            Lact = Lact + layerLengths(i); % Update Lact
            numofLayers = numofLayers + 1;     % Count this layer
        else
            break; % Exit loop if adding the next layer exceeds L
        end
    end

    Nl = numofLayers;
    Nact = Nl * Npl;
    Nmax = L / (pi * di);

    % Store key parameters in a vector
    paramVector = [paramVector; Npl, dm, Lact, Nact, Nl, di, NaN]; % Placeholder for Force

    % Inequality Constraints (c <= 0)
    c = [Lact - L; ...          % Ensure Lact <= L
            Nact - Nmax]; % Ensure Nact <= theoretical max number of turns

    % Equality Constraints (none in this case)
    ceq = [mod(Nact, 1)];

end

%% Objective Function
function Force_area = objective(x)

global L Nl Npl Lact paramVector; % Declare as global

    % Inputs (scaled)
    Npl = x(1); % Number of Turns which is needed to create a layer of coil
    dm = x(2) * 1e-3; % Permanent Magnet diameter in m

    % Fixed Parameters
    I_0 = 0.33;
    I = I_0 * sqrt(L / Lact); % Coil current
    g = 0.2e-3; % Air gap between coil and core
    dw = 0.1601e-3; % Wire diameter
    Br = 1; % Magnetic remanence
    % Calculate force using a custom function
    Force = -multi_current_loop_force_mvp(0, (dm / 2 + g), dm / 2, Br, I, dw, Npl, Nl);
    R_ext=dm/2+g+Nl*dw;
    area=pi*(R_ext)^2*1e6; % unit is mm^2
    Force_area= Force/area;        % Force / Area , mN/mm^2

    % Update Force in the parameter vector
    if ~isempty(paramVector)
        paramVector(end, end) = -Force_area; % Update Force in the last entry
    end
end