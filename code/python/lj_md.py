"""A minimal molecular dynamics simulation: Lennard-Jones particles in 2D.

Reduced units (sigma = epsilon = mass = 1). Velocity Verlet integration,
periodic boundaries, minimum-image convention, no cut-off.
"""
import numpy as np

rng = np.random.default_rng(seed=1)

# --- set-up: 25 particles on a square lattice -------------------------
n_side = 5
N = n_side**2
L = 7.5                                  # box length
dt = 0.005                               # time step
n_steps = 2000

grid = (np.arange(n_side) + 0.5) * (L / n_side)
pos = np.array([[x, y] for x in grid for y in grid])
vel = rng.normal(0.0, 1.0, size=(N, 2))
vel -= vel.mean(axis=0)                  # zero total momentum


def forces_and_energy(pos):
    """Return the force on every particle and the total potential energy."""
    d = pos[:, None, :] - pos[None, :, :]          # all pair separations
    d -= L * np.round(d / L)                       # minimum image
    r2 = np.sum(d**2, axis=2)
    np.fill_diagonal(r2, np.inf)                   # no self-interaction
    inv6 = 1.0 / r2**3
    U = 0.5 * np.sum(4.0 * (inv6**2 - inv6))       # each pair counted twice
    fmag = 24.0 * (2.0 * inv6**2 - inv6) / r2      # |F|/r for each pair
    F = np.sum(fmag[:, :, None] * d, axis=1)
    return F, U


F, U = forces_and_energy(pos)
print(" step   kinetic   potential     total")
for step in range(n_steps + 1):
    if step % 250 == 0:
        K = 0.5 * np.sum(vel**2)
        print(f"{step:5d} {K:9.4f} {U:11.4f} {K + U:9.4f}")
    # velocity Verlet
    vel += 0.5 * dt * F
    pos += dt * vel
    pos %= L                                       # wrap into the box
    F, U = forces_and_energy(pos)
    vel += 0.5 * dt * F
