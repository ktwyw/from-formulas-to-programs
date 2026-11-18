use std::time::Instant;
fn main(){ let n=10_000_000u64; let h=std::f64::consts::PI/n as f64; let t0=Instant::now();
 let mut s=0.0f64; for i in 1..n { s+=(i as f64*h).sin(); }
 s=h*(s+0.5*(0f64.sin()+std::f64::consts::PI.sin()));
 println!("{:.4} {:.12}", t0.elapsed().as_secs_f64(), s);}
