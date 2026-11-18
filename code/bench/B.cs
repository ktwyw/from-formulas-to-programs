using System; using System.Diagnostics;
class B{ static void Main(){ int n=10000000; double h=Math.PI/n,s=0; var sw=Stopwatch.StartNew();
 for(int i=1;i<n;i++) s+=Math.Sin(i*h); s=h*(s+0.5*(Math.Sin(0)+Math.Sin(Math.PI)));
 Console.WriteLine($"{sw.Elapsed.TotalSeconds:F4} {s:F12}");}}
