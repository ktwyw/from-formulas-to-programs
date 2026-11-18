program b
 implicit none
 integer, parameter :: dp=kind(1d0)
 integer(8) :: i, n=10000000, c0, c1, rate
 real(dp) :: h, s, pi
 pi=acos(-1.0_dp); h=pi/n; s=0
 call system_clock(c0,rate)
 do i=1,n-1
   s=s+sin(i*h)
 end do
 s=h*(s+0.5_dp*(sin(0.0_dp)+sin(pi)))
 call system_clock(c1)
 print '(f0.4,1x,f0.12)', real(c1-c0,dp)/rate, s
end program
