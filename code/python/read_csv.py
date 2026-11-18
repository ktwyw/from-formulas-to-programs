"""Read tensile test results from a CSV file and compute statistics."""
import csv
import statistics

data = {}                        # material -> list of yield strengths
with open("../data/tensile.csv", newline="") as f:
    reader = csv.DictReader(f)
    for row in reader:
        data.setdefault(row["material"], []).append(float(row["yield_MPa"]))

with open("summary.txt", "w") as out:
    out.write("material   n   mean (MPa)   std (MPa)\n")
    for material, values in data.items():
        line = (f"{material:8s} {len(values):3d} {statistics.mean(values):12.2f}"
                f" {statistics.stdev(values):11.2f}")
        print(line)
        out.write(line + "\n")
print("Summary written to summary.txt")
