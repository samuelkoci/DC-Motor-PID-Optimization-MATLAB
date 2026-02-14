function J = pidFitnessGA(x)
    % x = [Kp, Ki, Kd]
    Kp = x(1); Ki = x(2); Kd = x(3);

    % Vendojsa e gaineve per modelin e workspaceit ne simulink
    assignin('base','Kp',Kp);
    assignin('base','Ki',Ki);
    assignin('base','Kd',Kd);

    try
       
        simOut = sim('pid_circuit_dcmotorr','ReturnWorkspaceOutputs','on');

        % Marrja e te dhenave
        y = simOut.out.Data;
        t = simOut.t.Data;
        ref = 1;

        % Metriksi i Performances
        overshoot = max(0, (max(y)-ref)/ref*100);   % clamp to nonnegative
        steady_error = abs(ref - y(end));

        % Settling time (2% band)
        idx = find(abs(y-ref) > 0.02*ref, 1, 'last');
        if isempty(idx)
            settling_time = 0;
        else
            settling_time = t(idx);
        end

        % Funsksioni i kostit te peshuar
        alpha = 0.3;   % overshoot weight
        beta  = 0.5;   % settling time weight
        gamma = 0.2;   % steady-state error weight

        %Penallti nese settling time kalon 2s
        lambda = 100;
        penalty = 0;
        if settling_time > 2
            penalty = lambda;
        end

        J = alpha*overshoot + beta*settling_time + gamma*steady_error + penalty;

    catch
        % Nese simulimi krashon kthe nje pergjigje te madhe
        J = 1e6;
    end
end
