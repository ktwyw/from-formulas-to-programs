import math, time
n = 10_000_000; h = math.pi / n
t0 = time.perf_counter(); s = 0.0
for i in range(1, n): s += math.sin(i * h)
s = h * (s + 0.5 * (math.sin(0.0) + math.sin(math.pi)))
print(f"{time.perf_counter() - t0:.4f} {s:.12f}")
