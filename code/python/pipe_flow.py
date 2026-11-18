"""Pressure drop in a pipe: an example of a class."""
import math


class Pipe:
    """A straight circular pipe."""

    def __init__(self, length, diameter, roughness=4.5e-5):
        self.length = length          # m
        self.diameter = diameter      # m
        self.roughness = roughness    # m (default: commercial steel)

    def area(self):
        return math.pi * self.diameter**2 / 4

    def reynolds(self, Q, rho=998.0, mu=1.0e-3):
        v = Q / self.area()
        return rho * v * self.diameter / mu

    def friction_factor(self, Re):
        """Darcy friction factor: laminar or Swamee-Jain (turbulent)."""
        if Re < 2300:
            return 64.0 / Re
        eps_D = self.roughness / self.diameter
        return 0.25 / math.log10(eps_D / 3.7 + 5.74 / Re**0.9) ** 2

    def pressure_drop(self, Q, rho=998.0, mu=1.0e-3):
        """Darcy-Weisbach pressure drop (Pa) for volumetric flow rate Q (m^3/s)."""
        v = Q / self.area()
        Re = self.reynolds(Q, rho, mu)
        fD = self.friction_factor(Re)
        return fD * (self.length / self.diameter) * rho * v**2 / 2

    def __repr__(self):
        return f"Pipe(L={self.length} m, D={self.diameter} m)"


pipes = [Pipe(50.0, 0.05), Pipe(50.0, 0.08), Pipe(120.0, 0.10)]
Q = 0.004   # m^3/s (4 litres per second)
for p in pipes:
    Re = p.reynolds(Q)
    dp = p.pressure_drop(Q)
    print(f"{p}: Re = {Re:9.0f}, dp = {dp/1000:8.2f} kPa")
