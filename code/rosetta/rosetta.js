// Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
const fs = require("fs");

function newton(f, df, x, tol = 1e-12, maxIter = 50) {
  for (let k = 1; k <= maxIter; k++) {
    const step = f(x) / df(x);
    x -= step;
    if (Math.abs(step) < tol) return [x, k];
  }
  throw new Error("no convergence");
}

function trapezoid(f, a, b, n) {
  const h = (b - a) / n;
  let s = 0.5 * (f(a) + f(b));
  for (let i = 1; i < n; i++) s += f(a + i * h);
  return s * h;
}

const [root, iters] = newton((x) => x ** 3 - 2 * x - 5, (x) => 3 * x ** 2 - 2, 2.0);
console.log(`Newton:     root = ${root.toFixed(15)} (${iters} iterations)`);
console.log(`Trapezoid:  integral = ${trapezoid(Math.sin, 0, Math.PI, 100).toFixed(15)} (n = 100)`);

const data = fs.readFileSync("yield.txt", "utf8").split("\n")
  .filter((line) => line.trim() !== "").map(Number);
const mean = data.reduce((s, x) => s + x, 0) / data.length;
const std = Math.sqrt(data.reduce((s, x) => s + (x - mean) ** 2, 0) / (data.length - 1));
console.log(`Statistics: n = ${data.length}, mean = ${mean.toFixed(3)}, std = ${std.toFixed(3)}`);
