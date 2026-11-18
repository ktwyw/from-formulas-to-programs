package main
import ("fmt";"math";"time")
func main(){ n:=10000000; h:=math.Pi/float64(n); s:=0.0; t0:=time.Now()
 for i:=1;i<n;i++ { s+=math.Sin(float64(i)*h) }
 s=h*(s+0.5*(math.Sin(0)+math.Sin(math.Pi)))
 fmt.Printf("%.4f %.12f\n", time.Since(t0).Seconds(), s)}
