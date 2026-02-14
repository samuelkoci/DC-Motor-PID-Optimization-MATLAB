% --- Load open-loop step response ---
y = out.out.Data;     % system output
t = out.t.Data;       % time vector

% --- Normalize output if needed ---
y = y - y(1);         % remove initial offset
y = y / max(y);       % normalize to 1

% --- Estimate θ (dead time) and τ (time constant) ---
% Use numerical derivative to find inflection point
dy = gradient(y)./gradient(t);
[~, idx_inflect] = max(dy);
t_inflect = t(idx_inflect);
y_inflect = y(idx_inflect);

% Fit tangent line at inflection point
slope = dy(idx_inflect);
y_tangent = slope * (t - t_inflect) + y_inflect;

% Find θ: time when tangent crosses y=0
theta_idx = find(y_tangent >= 0, 1, 'first');
theta = t(theta_idx);

% Find τ: time when tangent reaches y=1
tau_idx = find(y_tangent >= 1, 1, 'first');
tau = t(tau_idx) - theta;

% --- Ziegler–Nichols formulas ---
K = 1;  % assume unit step input
Kp_P   = tau / (K * theta);
Kp_PI  = 0.9 * tau / (K * theta);
Ti_PI  = theta / 0.3;
Kp_PID = 1.2 * tau / (K * theta);
Ti_PID = 2 * theta;
Td_PID = 0.5 * theta;

Ki_PI   = Kp_PI / Ti_PI;
Ki_PID  = Kp_PID / Ti_PID;
Kd_PID  = Kp_PID * Td_PID;

% --- Display results ---
fprintf('Estimated θ (dead time): %.4f s\n', theta);
fprintf('Estimated τ (time constant): %.4f s\n', tau);
fprintf('\n--- Ziegler–Nichols PID Coefficients ---\n');
fprintf('P:    Kp = %.4f\n', Kp_P);
fprintf('PI:   Kp = %.4f, Ki = %.4f\n', Kp_PI, Ki_PI);
fprintf('PID:  Kp = %.4f, Ki = %.4f, Kd = %.4f\n', Kp_PID, Ki_PID, Kd_PID);
