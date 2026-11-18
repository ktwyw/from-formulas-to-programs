function vt = terminal_velocity(m, c, g)
%TERMINAL_VELOCITY  Terminal velocity of a body with quadratic air drag.
%   vt = TERMINAL_VELOCITY(m, c) uses g = 9.81 m/s^2.
%   vt = TERMINAL_VELOCITY(m, c, g) uses the given g.
%   m and c may be arrays of the same size (element-wise operation).
if nargin < 3
    g = 9.81;
end
if any(c(:) <= 0)
    error('terminal_velocity:badInput', 'Drag coefficient must be positive');
end
vt = sqrt(m .* g ./ c);
end
