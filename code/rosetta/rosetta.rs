// Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
use std::fs;

fn newton(f: impl Fn(f64) -> f64, df: impl Fn(f64) -> f64, mut x: f64) -> Option<(f64, u32)> {
    for k in 1..=50 {
        let step = f(x) / df(x);
        x -= step;
        if step.abs() < 1e-12 {
            return Some((x, k));
        }
    }
    None                                     // no convergence
}

fn trapezoid(f: impl Fn(f64) -> f64, a: f64, b: f64, n: u32) -> f64 {
    let h = (b - a) / n as f64;
    let inner: f64 = (1..n).map(|i| f(a + i as f64 * h)).sum();
    h * (0.5 * (f(a) + f(b)) + inner)
}

fn main() {
    let (root, iters) = newton(|x| x.powi(3) - 2.0 * x - 5.0, |x| 3.0 * x * x - 2.0, 2.0)
        .expect("Newton's method did not converge");
    println!("Newton:     root = {:.15} ({} iterations)", root, iters);
    println!("Trapezoid:  integral = {:.15} (n = 100)",
             trapezoid(f64::sin, 0.0, std::f64::consts::PI, 100));

    let text = fs::read_to_string("yield.txt").expect("cannot read yield.txt");
    let data: Vec<f64> = text.split_whitespace().map(|s| s.parse().unwrap()).collect();
    let n = data.len() as f64;
    let mean = data.iter().sum::<f64>() / n;
    let var = data.iter().map(|x| (x - mean).powi(2)).sum::<f64>() / (n - 1.0);
    println!("Statistics: n = {}, mean = {:.3}, std = {:.3}", data.len(), mean, var.sqrt());
}
