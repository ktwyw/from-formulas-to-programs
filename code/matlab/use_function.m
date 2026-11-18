% Call the function defined in terminal_velocity.m
masses = [60 80 100];                       % kg
vt = terminal_velocity(masses, 0.25);
fprintf('m = %3d kg  ->  vt = %.2f m/s\n', [masses; vt]);
vt_moon = terminal_velocity(80, 0.25, 1.62);
fprintf('With g = 1.62 m/s^2: %.2f m/s\n', vt_moon);
