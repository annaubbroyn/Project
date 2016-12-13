syms pL pR ZR ZL Z z k p n L;
pR = p + pL;
ZR = Z - sqrt(Z^2 - z^2);
ZL = Z + sqrt(Z^2 - z^2);

A = [exp(1i*(n+pL)) 0 1 0; 0 exp(1i*(n+pL)) 0 -1; 0 -1 0 exp(1i*(n-pL)); 1 0 exp(1i*(n-pL)) 0];
B = [exp(1i*(n+pR)) 0 1 0; 0 exp(1i*(n+pR)) 0 -1; 0 -1 0 exp(1i*(n-pR)); 1 0 exp(1i*(n-pR)) 0];
C = [1 1 0 0 0 0 0 0; 0 0 1 1 0 0 0 0; 0 0 0 0 1 1 0 0; 0 0 0 0 0 0 1 1];
CL = diag([exp(1i*k*L), exp(-1i*k*L), exp(1i*k*L), exp(-1i*k*L), exp(1i*k*L), exp(-1i*k*L), exp(1i*k*L), exp(-1i*k*L)]);
D4 = diag([1 1 -1 -1]);
D8 = diag([1 -1 1 -1 1 -1 1 -1]);
I = eye(4);

M = simplify([ A 0*I -C; 0*I B -C*CL; A*(D4-ZL*I) 0*I C*D8; 0*I B*(D4-ZR*I) -C*CL*D8]);
det = simplify(det(M));