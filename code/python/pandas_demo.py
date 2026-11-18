"""Tabular data with pandas: the same tensile data as read_csv.py."""
import pandas as pd

df = pd.read_csv("../data/tensile.csv")
print(df.head(3))
print()
df["area_mm2"] = 3.141592653589793 * df["diameter_mm"] ** 2 / 4
df["yield_load_kN"] = df["yield_MPa"] * df["area_mm2"] / 1000
summary = df.groupby("material")["yield_MPa"].agg(["count", "mean", "std", "min", "max"])
print(summary.round(2))
