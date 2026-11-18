! Three small numerical tasks: Newton's method, trapezoidal rule, statistics.
module tasks
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    abstract interface
        pure function func(x) result(y)
            import :: dp
            real(dp), intent(in) :: x
            real(dp) :: y
        end function func
    end interface
contains
    subroutine newton(f, df, x, iters)
        procedure(func) :: f, df
        real(dp), intent(inout) :: x
        integer, intent(out) :: iters
        real(dp) :: step
        do iters = 1, 50
            step = f(x) / df(x)
            x = x - step
            if (abs(step) < 1.0e-12_dp) return
        end do
        error stop "no convergence"
    end subroutine newton

    function trapezoid(f, a, b, n) result(s)
        procedure(func) :: f
        real(dp), intent(in) :: a, b
        integer, intent(in) :: n
        real(dp) :: s, h
        integer :: i
        h = (b - a) / n
        s = 0.5_dp * (f(a) + f(b))
        do i = 1, n - 1
            s = s + f(a + i * h)
        end do
        s = s * h
    end function trapezoid

    pure function cubic(x) result(y)
        real(dp), intent(in) :: x
        real(dp) :: y
        y = x**3 - 2.0_dp * x - 5.0_dp
    end function cubic

    pure function dcubic(x) result(y)
        real(dp), intent(in) :: x
        real(dp) :: y
        y = 3.0_dp * x**2 - 2.0_dp
    end function dcubic

    pure function mysin(x) result(y)
        real(dp), intent(in) :: x
        real(dp) :: y
        y = sin(x)
    end function mysin
end module tasks

program rosetta
    use tasks
    implicit none
    real(dp) :: x, data(1000), mean, std
    integer :: iters, n, u, ios

    x = 2.0_dp
    call newton(cubic, dcubic, x, iters)
    print '(a, f17.15, a, i0, a)', 'Newton:     root = ', x, ' (', iters, ' iterations)'
    print '(a, f17.15, a)', 'Trapezoid:  integral = ', &
          trapezoid(mysin, 0.0_dp, acos(-1.0_dp), 100), ' (n = 100)'

    open(newunit=u, file='yield.txt', status='old', action='read')
    n = 0
    do
        read(u, *, iostat=ios) data(n + 1)
        if (ios /= 0) exit
        n = n + 1
    end do
    close(u)
    mean = sum(data(1:n)) / n
    std = sqrt(sum((data(1:n) - mean)**2) / (n - 1))
    print '(a, i0, a, f0.3, a, f0.3)', 'Statistics: n = ', n, ', mean = ', mean, ', std = ', std
end program rosetta
