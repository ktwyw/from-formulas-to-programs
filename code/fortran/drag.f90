! Falling object with quadratic air drag, explicit Euler method.
!   m dv/dt = m g - c v^2,  v(0) = 0
program drag
    implicit none
    integer, parameter :: dp = kind(1.0d0)      ! double precision kind
    real(dp), parameter :: m = 80.0_dp, c = 0.25_dp, g = 9.81_dp
    real(dp), parameter :: dt = 0.5_dp, t_end = 20.0_dp
    integer :: n, n_steps
    real(dp), allocatable :: t(:), v(:)
    real(dp) :: ve

    n_steps = nint(t_end / dt)
    allocate(t(0:n_steps), v(0:n_steps))       ! arrays indexed 0..n_steps
    t(0) = 0.0_dp
    v(0) = 0.0_dp
    do n = 0, n_steps - 1
        v(n+1) = v(n) + dt * acceleration(v(n))
        t(n+1) = (n + 1) * dt
    end do

    write(*, '(a6, 3a11)') 't (s)', 'v_Euler', 'v_exact', 'error'
    do n = 0, n_steps, 4
        ve = exact_speed(t(n))
        write(*, '(f6.1, 2f11.4, es11.2)') t(n), v(n), ve, v(n) - ve
    end do
    write(*, '(a, f0.4, a)') 'Terminal velocity: ', sqrt(m*g/c), ' m/s'

contains

    pure function acceleration(v) result(a)
        real(dp), intent(in) :: v
        real(dp) :: a
        a = g - (c / m) * v**2
    end function acceleration

    pure function exact_speed(t) result(v)
        real(dp), intent(in) :: t
        real(dp) :: v, vt
        vt = sqrt(m * g / c)
        v = vt * tanh(g * t / vt)
    end function exact_speed

end program drag
