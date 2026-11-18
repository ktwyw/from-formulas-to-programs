// Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
package main

import (
	"errors"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

func newton(f, df func(float64) float64, x float64) (float64, int, error) {
	for k := 1; k <= 50; k++ {
		step := f(x) / df(x)
		x -= step
		if math.Abs(step) < 1e-12 {
			return x, k, nil
		}
	}
	return x, 50, errors.New("no convergence")
}

func trapezoid(f func(float64) float64, a, b float64, n int) float64 {
	h := (b - a) / float64(n)
	s := 0.5 * (f(a) + f(b))
	for i := 1; i < n; i++ {
		s += f(a + float64(i)*h)
	}
	return s * h
}

func main() {
	root, iters, err := newton(func(x float64) float64 { return x*x*x - 2*x - 5 },
		func(x float64) float64 { return 3*x*x - 2 }, 2.0)
	if err != nil {
		panic(err)
	}
	fmt.Printf("Newton:     root = %.15f (%d iterations)\n", root, iters)
	fmt.Printf("Trapezoid:  integral = %.15f (n = 100)\n", trapezoid(math.Sin, 0, math.Pi, 100))

	text, err := os.ReadFile("yield.txt")
	if err != nil {
		panic(err)
	}
	var data []float64
	for _, field := range strings.Fields(string(text)) {
		v, _ := strconv.ParseFloat(field, 64)
		data = append(data, v)
	}
	sum := 0.0
	for _, v := range data {
		sum += v
	}
	mean := sum / float64(len(data))
	ss := 0.0
	for _, v := range data {
		ss += (v - mean) * (v - mean)
	}
	fmt.Printf("Statistics: n = %d, mean = %.3f, std = %.3f\n", len(data), mean,
		math.Sqrt(ss/float64(len(data)-1)))
}
