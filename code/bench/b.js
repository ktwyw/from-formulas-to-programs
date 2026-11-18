const n=10000000,h=Math.PI/n; let s=0; const t0=performance.now();
for(let i=1;i<n;i++) s+=Math.sin(i*h);
s=h*(s+0.5*(Math.sin(0)+Math.sin(Math.PI)));
console.log(((performance.now()-t0)/1000).toFixed(4), s.toFixed(12));
