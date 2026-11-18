public class B { public static void main(String[] a){ int n=10000000; double h=Math.PI/n,s=0;
 long t0=System.nanoTime(); for(int i=1;i<n;i++) s+=Math.sin(i*h);
 s=h*(s+0.5*(Math.sin(0)+Math.sin(Math.PI)));
 System.out.printf("%.4f %.12f%n",(System.nanoTime()-t0)*1e-9,s);}}
