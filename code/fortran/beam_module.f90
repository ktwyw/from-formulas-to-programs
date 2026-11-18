! A module with physical constants and a routine for beam deflection.
module beam_mod
    implicit none
    private
    public :: dp, cantilever_deflection

    integer, parameter :: dp = selected_real_kind(15, 307)   ! ~16 digits

contains

    ! Deflection w(x) of a cantilever of length L with end load P:
    !   w(x) = P x^2 (3L - x) / (6 E I)
    elemental function cantilever_deflection(x, P, L, E, I) result(w)
        real(dp), intent(in) :: x, P, L, E, I
        real(dp) :: w
        w = P * x**2 * (3.0_dp*L - x) / (6.0_dp * E * I)
    end function cantilever_deflection

end module beam_mod


program beam
    use beam_mod
    implicit none
    real(dp), parameter :: L = 2.0_dp          ! m
    real(dp), parameter :: P = 1.0e3_dp        ! N
    real(dp), parameter :: E = 210.0e9_dp      ! Pa (steel)
    real(dp), parameter :: b = 0.05_dp, h = 0.10_dp
    real(dp) :: I, x(5), w(5)
    integer :: k

    I = b * h**3 / 12.0_dp                     ! second moment of area
    x = [(L * k / 4.0_dp, k = 0, 4)]           ! implied-do array constructor
    w = cantilever_deflection(x, P, L, E, I)   ! elemental: works on arrays

    print '(a, es10.3, a)', 'I = ', I, ' m^4'
    print '(a8, a14)', 'x (m)', 'w (mm)'
    do k = 1, 5
        print '(f8.2, f14.4)', x(k), 1000.0_dp * w(k)
    end do
    print '(a, f8.4, a)', 'Max deflection (formula PL^3/3EI): ', &
          1000.0_dp * P * L**3 / (3.0_dp * E * I), ' mm'
end program beam
