% Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
f  = @(x) x.^3 - 2*x - 5;
df = @(x) 3*x.^2 - 2;
x = 2.0;
for iters = 1:50
    step = f(x) / df(x);
    x = x - step;
    if abs(step) < 1e-12, break; end
end
if abs(step) >= 1e-12, error('no convergence'); end
fprintf('Newton:     root = %.15f (%d iterations)\n', x, iters);

n = 100;
xs = linspace(0, pi, n + 1);                 % n intervals, n+1 points
h = pi / n;
I = h * (sum(sin(xs)) - 0.5*(sin(xs(1)) + sin(xs(end))));
fprintf('Trapezoid:  integral = %.15f (n = %d)\n', I, n);   % or trapz(xs, sin(xs))

data = load('yield.txt');
fprintf('Statistics: n = %d, mean = %.3f, std = %.3f\n', numel(data), mean(data), std(data));
