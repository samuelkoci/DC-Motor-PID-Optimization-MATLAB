% Extract data if out.out and out.t are timeseries
y = out.out.Data;
t = out.t.Data;

% Reference input (adjust if your step is not to 1)
ref = 1;

% Steady-state value
y_final = y(end);

% Steady-state error
steady_error = abs(ref - y_final);

% Overshoot
overshoot = (max(y) - ref) / ref * 100;

% Settling time (2% band)
tol = 0.02 * ref;
idx = find(abs(y - ref) > tol);
if isempty(idx)
    settling_time = 0;
else
    settling_time = t(idx(end));
end

fprintf('Settling Time: %.4f s\n', settling_time);
fprintf('Overshoot: %.2f %%\n', overshoot);
fprintf('Steady-State Error: %.4f\n', steady_error);
