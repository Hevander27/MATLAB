
disp("            ___Chapter 5.3 Q33___")
A = [-6 4 0 9; -3 0 1 6;
     -1 -2 1 0;-4 4 0 7];
disp("Eigenvalues: ")
e = eig(A);
disp(e);

nulbasL1 = null((A-e(1)*eye(4)),'r');
nulbasL2 = null((A-e(2)*eye(4)),'r');
nulbasL3 = null((A-e(3)*eye(4)),'r');

P = [2*nulbasL1, 2*nulbasL2,...
    nulbasL3(:,1), 4*nulbasL3(:,2)];
disp("Matrix P: ")
disp(P)
disp("Diagonal Matrix (D):")
D = eig(A,'matrix');
disp(D)

disp("            ___Chapter 6.2 Q35___")
A = [-6 -3 6  1;-1 2 1  -6;
      3  6 3 -2; 6 -3 6 -1;
      2 -1 2  3;-3  6 3  2;
     -2 -1 2 -3; 1  2 1  6];
disp("Matrix A: ")
disp(A)
disp("Matrix A': ")
disp(A')
disp("Matrix A^{T}A: ")
ans0 = A'*A;
disp(ans0)
disp("Off diagonals being zeros demonstrates orthogonality")
disp("This demonstates that the columns of A are orthonormal")

disp("                                 ")
disp("            ___Chapter 6.2 Q36___")
disp("                                 ")
disp("__Part A__")
disp("")
disp("            Using Matrix A from Q35")
disp("Matrix U'U: ")
U = (1/10)*A;
ans1 = U'*U;
disp(ans1);
disp("Matrix UU': ")
ans2 = U*U';
disp(ans2);
disp("U'U produces the identity matrixs; size n-by-n")
disp("UU' produces 2n-by-2n matrix of varying values")
disp("                                              ")

disp("__Part B__")
disp("Matrix y R^{8}: ")
y = [1 1 1 1 1 1 1 1 ]';
disp(y);
disp("Matrix p=UU^{T} y: ");
p = U*U'*y;
disp(p);
disp("Matrix z=y-p: ")
z = y-p;
disp(z)
disp("p = UU^{T}y can be expressed as p = U(U^{T}y)")
disp("p is therefore in col(U)")
disp("U is (1/10)A there for p is in col(A)")
disp("Orthogonality (z*p=0):")
ortho = z.*p;
disp(ortho);
disp("SUM:")
disp(sum(ortho))

disp("__Part C__")
disp("Matrix U has columns u_{1}, u_{2}, u_{3}, u_{4}: ")
disp("z*u_{1}:"), disp((z.*U(:,1)))
disp("SUM:"), disp(sum(z.*U(:,1)))

disp("z*u_{2}:"), disp((z.*U(:,2)))
disp("SUM:"), disp(sum(z.*U(:,2)))

disp("z*u_{3}:"), disp((z.*U(:,3)))
disp("SUM:"), disp(sum(z.*U(:,3)))

disp("z*u_{4}:"),disp((z.*U(:,4)))
disp("SUM:"), disp(sum(z.*U(:,4)))
disp("All dot products being 0 shows z-U orthogonality")

disp("                                 ")
disp("__Part D__")
disp("Part(C) demonstrates z is orthogonal to all columns in U")
disp("U is equal to (1/10)A")
disp("U = Span{u_{1},...u_{p}}")
disp("Given z is orthogonal to each u_{j}, for 1<=j<=p,")
disp("Vector z is therefore orthogonal to all U vectors")
disp("Columns of A are (1/10) columns of U")
disp("Therefore z is orthogonal to all A columns")
disp("Vector z is orthogonal to A")
disp("                                 ")
disp("            ___Chapter 6.3 Q25___")
disp("Answer Constructed from 6.2 Q36")
P = U*U'*y;
disp("Closest point to y in col(U) is the y's orthogonal projection")
disp("U has orthonormal columns, therefore y_norm = UU'y")
disp(P);
disp("                                 ")
disp("            ___Chapter 6.4 Q24___")
A = [-10 13 7 -11;
       2  1 -5  3;
      -6  3 13 -3;
      16 -16 -2 5;
       2  1 -5 -7];
%%Gram-Schmidt Un-normalized%%
[m n]=size(A);
U=zeros(m,n);
U(:,1)=A(:,1);
for k = 2:n
    S=A(:,k);
    for j=1:k-1
        S=S-(dot(A(:,k),U(:,j))/...
        dot(U(:,j),U(:,j)))*U(:,j);
    end
    U(:,k)=S;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp("Orthogonal basis for column space of A:")
disp(U)

disp("            ___Chapter 6.4 Q25___")
Q = gschmidt(U);
disp("Matrix Q: ")
disp(Q)
disp("Matrix Q Transpose: ")
disp(Q')
disp("Matrix R: ")
R = Q'*A;
disp(R)

disp("            ___Chapter 7.1 Q37___")
A = [6 2 9 -6; 2 6 -6 9
     9 -6 6 2; -6 9 2 6];
[V D W]  = eig(A);
disp("Eigenvalues:")
disp(roots(poly(A)))

disp("Eigenvectors:")
disp(V)
D = eig(A,'matrix');
disp("Diagonal Matrix D:")
disp(D)
disp("Orthonormal basis Nul(A-(Lda)I): ")
ev = eig(A);
nulbasl1 = null((A-ev(1)*eye(4)));
nulbasl2 = null((A-ev(2)*eye(4)));
nulbasl3 = null((A-ev(3)*eye(4)));
ONB = [nulbasl1, nulbasl2, nulbasl3];
disp(ONB)
disp("Matrices {P^-1, P^T} are equal by inspection")
disp("Matrix P^-1:")
disp(W^-1)
disp("Matrix P^T:")
disp(W')

disp("Matrices {PDP^-1, PDP^T} are equal by inspection")
disp("Matrix PDP^T:")
disp(W*D*W')
disp("Matrix PDP^-1:")
disp(W*D*W^-1)
disp("Matrices {A, PDP^-1} are equal by inspection")
disp(A)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Q,R]=gschmidt(V)
% Input: V is an m by n matrix of full rank m<=n
% Output: an m-by-n upper triangular matrix R
% and an m-by-m unitary matrix Q so that A = Q*R.
[m,n]=size(V);
R=zeros(n);
R(1,1)=norm(V(:,1));
Q(:,1)=V(:,1)/R(1,1);
    for k=2:n
        R(1:k-1,k)=Q(:,1:k-1)'*V(:,k);
        Q(:,k)=V(:,k)-Q(:,1:k-1)*R(1:k-1,k);
        R(k,k)=norm(Q(:,k));
        Q(:,k)=Q(:,k)/R(k,k);
    end
end
%@Purdue University
%author = {Yingwei Wang},
%title = {The Gram-Schmidt proccess in Matlab},
%publisher = {Department of Mathematics},
%address = {West Lafayette, IN}}