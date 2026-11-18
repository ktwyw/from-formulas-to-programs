// Falling object with quadratic air drag, explicit Euler method.
package main

import (
	"fmt"
	"math"
)

const (
	m    = 80.0
	c    = 0.25
	g    = 9.81
	dt   = 0.5
	tEnd = 20.0
)

func acceleration(v float64) float64 {
	return g - (c/m)*v*v
}

func exactSpeed(t float64) float64 {
	vt := math.Sqrt(m * g / c)
	return vt * math.Tanh(g*t/vt)
}

func main() {
	nSteps := int(math.Round(tEnd / dt))
	v := make([]float64, nSteps+1) // a slice of zeros
	for n := 0; n < nSteps; n++ {
		v[n+1] = v[n] + dt*acceleration(v[n])
	}

	fmt.Printf("%6s %10s %10s %10s\n", "t (s)", "v_Euler", "v_exact", "error")
	for n := 0; n <= nSteps; n += 4 {
		t := float64(n) * dt
		ve := exactSpeed(t)
		fmt.Printf("%6.1f %10.4f %10.4f %10.2e\n", t, v[n], ve, v[n]-ve)
	}
	fmt.Printf("Terminal velocity: %.4f m/s\n", math.Sqrt(m*g/c))
}
