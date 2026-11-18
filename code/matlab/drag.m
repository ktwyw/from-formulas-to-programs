% Falling object with quadratic air drag, explicit Euler method.
%   m dv/dt = m g - c v^2,  v(0) = 0
clear; clc;

m = 80.0;  c = 0.25;  g = 9.81;      % SI units
dt = 0.5;  t_end = 20.0;

acceleration = @(v) g - (c/m) * v.^2;      % anonymous functions
vt = sqrt(m*g/c);
exact_speed = @(t) vt * tanh(g*t/vt);

t = 0:dt:t_end;                     % row vector 0, 0.5, ..., 20 (end included)
v = zeros(size(t));                 % preallocate
for n = 1:numel(t)-1                % MATLAB indices start at 1
    v(n+1) = v(n) + dt * acceleration(v(n));
end

ve = exact_speed(t);                % vectorised: exact speed at ALL times at once
fprintf('%6s %10s %10s %10s\n', 't (s)', 'v_Euler', 'v_exact', 'error');
idx = 1:4:numel(t);                 % every 4th point
fprintf('%6.1f %10.4f %10.4f %10.2e\n', [t(idx); v(idx); ve(idx); v(idx)-ve(idx)]);
fprintf('Terminal velocity: %.4f m/s\n', vt);

% Plot (uncomment in MATLAB to see the figure)
% plot(t, ve, '-', t, v, 'o'); xlabel('t (s)'); ylabel('v (m/s)');
% legend('exact', 'Euler', 'Location', 'southeast'); box on; grid on;
