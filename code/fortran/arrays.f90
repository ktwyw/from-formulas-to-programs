! Whole-array operations and intrinsic functions in modern Fortran.
program arrays
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    real(dp) :: A(3,3), b(3), x(3), T(6)
    integer :: i

    T = [20.0_dp, 35.5_dp, 50.2_dp, 64.8_dp, 80.1_dp, 95.0_dp]
    print '(a, 6f8.2)', 'T + 273.15 =', T + 273.15_dp
    print '(a, f8.3)',  'mean(T)    =', sum(T) / size(T)
    print '(a, f8.3)',  'max(T)     =', maxval(T)
    print '(a, i3)',    'count(T>50)=', count(T > 50.0_dp)
    print '(a, 3f8.2)', 'T(2:6:2)   =', T(2:6:2)

    ! A is filled column by column (Fortran is column-major)
    A = reshape([4.0_dp, -2.0_dp, 1.0_dp, &
                -2.0_dp, 4.0_dp, -2.0_dp, &
                 1.0_dp, -2.0_dp, 4.0_dp], [3, 3])
    x = [1.0_dp, -2.0_dp, 3.0_dp]
    b = matmul(A, x)
    print '(a, 3f8.2)', 'A x        =', b
    print '(a, f8.2)',  'x . x      =', dot_product(x, x)
    do i = 1, 3
        print '(a, i1, a, 3f6.1)', 'row ', i, ' of A:', A(i, :)
    end do
end program arrays
