model FallingBody "Falling object with quadratic air drag"
  parameter Real m = 80 "mass (kg)";
  parameter Real c = 0.25 "drag coefficient (kg/m)";
  parameter Real g = 9.81 "gravitational acceleration (m/s2)";
  Real v(start = 0, fixed = true) "speed (m/s)";
  Real h(start = 3000, fixed = true) "height (m)";
equation
  m * der(v) = m * g - c * v^2;
  der(h) = -v;
end FallingBody;
