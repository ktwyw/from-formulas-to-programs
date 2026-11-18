// Array methods, objects and JSON.
const loads = [12.6, 14.0, 13.2, 15.8, 11.9];          // kN

const total = loads.reduce((sum, x) => sum + x, 0);
const mean = total / loads.length;
const big = loads.filter((x) => x > 13.0);
const inNewtons = loads.map((x) => x * 1000);
const sorted = [...loads].sort((a, b) => a - b);       // copy, then sort numerically

console.log("mean   :", mean.toFixed(2), "kN");
console.log("> 13 kN:", big);
console.log("in N   :", inNewtons);
console.log("sorted :", sorted);
console.log("max    :", Math.max(...loads));

// An object literal: like a Python dictionary
const steel = { name: "S275", density: 7850, E: 210e9 };
steel.yieldStrength = 275e6;                           // add a property
const { density, E } = steel;                          // destructuring
console.log(`${steel.name}: E/rho = ${(E / density / 1e6).toFixed(2)} MJ/kg`);

// JSON: the data-exchange format of the web
const text = JSON.stringify(steel);
console.log(text);
console.log(JSON.parse(text).density + 1);

// Beware of loose typing
console.log("3" + 4, "3" * 4, 0.1 + 0.2 === 0.3, [10, 9, 1].sort());
