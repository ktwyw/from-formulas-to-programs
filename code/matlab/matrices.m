% Vectors, matrices and linear algebra in MATLAB.
A = [4 -2  1;
    -2  4 -2;
     1 -2  4];          % semicolons separate rows
b = [11; -16; 17];      % column vector

x = A \ b;              % solve A x = b ("A left-divided by b")
fprintf('x = [%g %g %g]\n', x);
fprintf('residual norm = %.1e\n', norm(A*x - b));

lambda = eig(A);        % eigenvalues
fprintf('eigenvalues: %.4f %.4f %.4f\n', lambda);
fprintf('det(A) = %g, trace = %g, cond = %.3f\n', det(A), trace(A), cond(A));

% Matrix product versus element-wise product
B = [1 2; 3 4];
disp('B*B  (matrix product):');      disp(B*B)
disp('B.*B (element-wise):');        disp(B.*B)
disp('B''   (transpose):');          disp(B')

% Building and slicing
C = magic(4);           % a 4x4 magic square
fprintf('row sums: %s\n', mat2str(sum(C, 2)'));
fprintf('C(2,:) = %s, C(:,end) = %s\n', mat2str(C(2,:)), mat2str(C(:,end)'));
C(C > 10) = 0;          % logical indexing: set all elements > 10 to zero
disp(C)
