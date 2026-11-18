import matplotlib.pyplot as plt
plt.rcParams.update({"font.family": "serif", "font.serif": ["TeX Gyre Pagella", "Palatino", "DejaVu Serif"], "font.size": 11})
rows = [l.split() for l in open("../code/bench/times.txt")]
labels = {"C#(Mono)": "C# (Mono)", "Python+NumPy": "Python + NumPy (vectorised)",
          "Python-loop": "Python (pure loop)", "Octave-vec": "Octave (vectorised)",
          "Octave-loop": "Octave (loop)", "R-vec": "R (vectorised)", "R-loop": "R (loop)"}
rows.sort(key=lambda r: float(r[1]))
names = [labels.get(r[0], r[0]) for r in rows]
t = [float(r[1]) for r in rows]
fig, ax = plt.subplots(figsize=(6.4, 4.4))
colors = ["#003d79" if ("loop" in n or "vector" not in n) and "NumPy" not in n else "#c49124" for n in names]
colors = ["#c8922a" if "vectorised" in n else "#12497a" for n in names]
hatch = ["" for n in names]
bars = ax.barh(range(len(t)), t, color=colors, edgecolor="none")
for b, h in zip(bars, hatch):
    b.set_hatch(h)
ax.set_yticks(range(len(t)), names, fontsize=10)
ax.invert_yaxis()
ax.set_xscale("log")
ax.set_xlabel("run time (s), log scale")
for i, v in enumerate(t):
    ax.text(v * 1.08, i, f"{v:.2f} s", va="center", fontsize=9)
ax.set_xlim(0.03, 80)
ax.tick_params(direction="in", top=True, right=True, which="both")
fig.tight_layout()
fig.savefig("benchmark.pdf")
