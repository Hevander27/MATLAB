disp( "       ___Problem 1___       ")
A = randi(4, 4);
B = inv(A);
C = inv(B);
disp("Matrix A: ");
disp(A);
disp("Matrix B: ");
disp(B);
disp("Matrix C: ");
disp(C);
disp('Theoretical value should be {zero}')
disp('Computing error from inherant limitations')
disp('produces a non-zero value')
disp('                            ')
maxAbsAC = max(max(abs(A-C)));
disp("Maximum Absolute Value: ");
disp(maxAbsAC);

disp( "       ___Problem 2___       ")
A1 = randi([0 17], 8);
b = randi([0 17],[8 1]);
Aug = [A1 b];
disp("Matrix A1: ");
disp(A1);
disp("Vector b: ");
disp(b);
disp("Augmented Matrix [A1 b]: ");
disp(Aug);


D = rref(Aug); D(:,9);
comp_mul = inv(A1)*b;   %A1\b
disp("Row Reduced echelon");
disp(D);
disp('A^(-1)*b: ');
disp(comp_mul);
 
disp("Comparing D and comp_mul we get nearly the same answer")
disp('Computational error of "inv" function')

disp( "       ___Problem 3___       ")
A2 = randi([0 19], [2 4]);
ADet1 = det(A2'*A2);
ADet2 = det(A2*A2');

disp("A2: "); disp(A2);
disp("det(A2'*A2): "); disp(ADet1);
disp("det(A2*A2'): "); disp(ADet2);

f = A2'*A2;
g = A2*A2';
h = inv(f); % throws warning
j = inv(g);
disp("A2'*A2 (ADet1): "); disp(f);
disp("A2*A2' (Adet2): "); disp(g);




disp('ADet1 & ADet2 are equal for m*m matrices')
disp("det(A2'*A2): for m*n matrices is theoretically 0")
disp("det(A2*A2'): for m*n matrices is greater than 0")
disp("                                                ")
disp("%%%%%%%%%%%%%%%%%%%%%%%%%%Comments%%%%%%%%%%%%%%%%%%%%%%%%%%")
disp("A'*A doesn't equal AA'")
disp("A'*A on a matrix {A} m*n, with n>m produces a matrix of n*n")
disp("AA' produces a matrix of m*m")
disp("A matrix with more columns than rows cannot be invertible")
disp("Columns must be less than or equal to number of rows")


