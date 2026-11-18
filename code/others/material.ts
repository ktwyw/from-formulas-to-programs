interface Material {
  name: string;
  density: number;        // kg/m^3
  youngsModulus: number;  // Pa
}

function specificStiffness(m: Material): number {
  return m.youngsModulus / m.density;
}

const al: Material = { name: "Al6061", density: 2700, youngsModulus: 69e9 };
specificStiffness(al);              // OK
specificStiffness({ name: "x" });   // compile-time error: properties missing
const s: number = "25";             // compile-time error: string is not a number
