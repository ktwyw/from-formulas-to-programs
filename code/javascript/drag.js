// Falling object with quadratic air drag, explicit Euler method.
// Run with:  node drag.js
const m = 80.0, c = 0.25, g = 9.81;   // SI units
const dt = 0.5, tEnd = 20.0;

const acceleration = (v) => g - (c / m) * v ** 2;   // arrow function
const vt = Math.sqrt(m * g / c);
const exactSpeed = (t) => vt * Math.tanh(g * t / vt);

const nSteps = Math.round(tEnd / dt);
const t = new Float64Array(nSteps + 1);             // typed array of doubles
const v = new Float64Array(nSteps + 1);
for (let n = 0; n < nSteps; n++) {
  v[n + 1] = v[n] + dt * acceleration(v[n]);
  t[n + 1] = (n + 1) * dt;
}

// JavaScript has no printf: pad strings ourselves
const col = (x, width, digits) => x.toFixed(digits).padStart(width);
const sci = (x, width) => x.toExponential(2).padStart(width);

console.log(["t (s)".padStart(6), "v_Euler".padStart(10),
             "v_exact".padStart(10), "error".padStart(10)].join(" "));
for (let n = 0; n <= nSteps; n += 4) {
  const ve = exactSpeed(t[n]);
  console.log(`${col(t[n], 6, 1)} ${col(v[n], 10, 4)} ${col(ve, 10, 4)} ${sci(v[n] - ve, 10)}`);
}
console.log(`Terminal velocity: ${vt.toFixed(4)} m/s`);
