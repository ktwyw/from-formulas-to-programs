// Falling object with quadratic air drag, explicit Euler method.
const M: f64 = 80.0;
const C: f64 = 0.25;
const G: f64 = 9.81;
const DT: f64 = 0.5;
const T_END: f64 = 20.0;

fn acceleration(v: f64) -> f64 {
    G - (C / M) * v * v
}

fn exact_speed(t: f64) -> f64 {
    let vt = (M * G / C).sqrt();
    vt * (G * t / vt).tanh()
}

fn main() {
    let n_steps = (T_END / DT).round() as usize;
    let mut v = vec![0.0_f64; n_steps + 1];   // `mut`: this vector may change
    for n in 0..n_steps {                       // 0, 1, ..., n_steps-1
        v[n + 1] = v[n] + DT * acceleration(v[n]);
    }

    println!("{:>6} {:>10} {:>10} {:>10}", "t (s)", "v_Euler", "v_exact", "error");
    for n in (0..=n_steps).step_by(4) {         // ..= includes the end
        let t = n as f64 * DT;
        let ve = exact_speed(t);
        println!("{:6.1} {:10.4} {:10.4} {:10.2e}", t, v[n], ve, v[n] - ve);
    }
    println!("Terminal velocity: {:.4} m/s", (M * G / C).sqrt());
}
