% Limitet per kerkimin e koeficentave PID
lb = [0 0 0];      % lower bounds
ub = [50 50 10];   % upper bounds

% Run GA
opts = optimoptions('ga','Display','iter','PopulationSize',30,'MaxGenerations',20);
[x_opt, fval] = ga(@pidFitnessGA, 3, [], [], [], [], lb, ub, [], opts);

% Marrja e koeficenteve optimal PID
Kp_opt = x_opt(1);
Ki_opt = x_opt(2);
Kd_opt = x_opt(3);

fprintf('Optimal PID gains: Kp=%.4f, Ki=%.4f, Kd=%.4f\n', Kp_opt, Ki_opt, Kd_opt);
