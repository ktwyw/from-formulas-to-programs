// Reading a CSV file and querying it with LINQ.
using System;
using System.IO;
using System.Linq;

class Specimen
{
    public string Id { get; }
    public string Material { get; }
    public double Diameter { get; }    // mm
    public double Yield { get; }       // MPa

    public Specimen(string id, string material, double diameter, double yield)
    {
        Id = id; Material = material; Diameter = diameter; Yield = yield;
    }

    public double YieldLoad => Yield * Math.PI * Diameter * Diameter / 4.0 / 1000.0;  // kN
}

class Tensile
{
    static void Main(string[] args)
    {
        string path = args.Length > 0 ? args[0] : "../data/tensile.csv";
        var specimens = File.ReadLines(path)
            .Skip(1)                                   // skip the header line
            .Select(line => line.Split(','))
            .Select(f => new Specimen(f[0], f[1], double.Parse(f[2]), double.Parse(f[3])))
            .ToList();

        var summary = specimens
            .GroupBy(s => s.Material)
            .Select(grp => new {
                Material = grp.Key,
                Count = grp.Count(),
                Mean = grp.Average(s => s.Yield),
                Max = grp.Max(s => s.Yield) });

        foreach (var row in summary)
            Console.WriteLine($"{row.Material,-8} n = {row.Count,2}  mean = {row.Mean:F2} MPa  max = {row.Max:F1} MPa");

        var strongest = specimens.OrderByDescending(s => s.YieldLoad).First();
        Console.WriteLine($"Largest yield load: {strongest.Id} ({strongest.YieldLoad:F2} kN)");
    }
}
