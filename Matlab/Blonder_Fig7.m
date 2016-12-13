Z1 = 0;
Z2 = 0.5;
Z3 = 1.5;
Z4 = 5.0;
Z = Z4;
N = 500;
x = linspace(0,3,N);

for i = 1:N
    if(x(i)<1)
        y1(i) = 2*(1+Z1^2)/(x(i)^2+(1-x(i)^2)*(1+2*Z1^2)^2);
        y2(i) = 2*(1+Z2^2)/(x(i)^2+(1-x(i)^2)*(1+2*Z2^2)^2);
        y3(i) = 2*(1+Z3^2)/(x(i)^2+(1-x(i)^2)*(1+2*Z3^2)^2);
        y4(i) = 2*(1+Z4^2)/(x(i)^2+(1-x(i)^2)*(1+2*Z4^2)^2);
    else 
        A1 = (x(i)+(1+2*Z1^2)*sqrt(x(i)^2-1))^(-2);
        B1 = 4*(1-1/x(i)^2)*Z1^2*(1+Z1^2)/(1+(1+2*Z1^2)*sqrt(1-1/x(i)^2))^2;
        A2 = (x(i)+(1+2*Z2^2)*sqrt(x(i)^2-1))^(-2);
        B2 = 4*(1-1/x(i)^2)*Z1^2*(1+Z2^2)/(1+(1+2*Z2^2)*sqrt(1-1/x(i)^2))^2;
        A3 = (x(i)+(1+2*Z3^2)*sqrt(x(i)^2-1))^(-2);
        B3 = 4*(1-1/x(i)^2)*Z3^2*(1+Z3^2)/(1+(1+2*Z3^2)*sqrt(1-1/x(i)^2))^2;
        A4 = (x(i)+(1+2*Z4^2)*sqrt(x(i)^2-1))^(-2);
        B4 = 4*(1-1/x(i)^2)*Z4^2*(1+Z4^2)/(1+(1+2*Z4^2)*sqrt(1-1/x(i)^2))^2;
        y1(i) = (1+Z1^2)*(1+A1-B1);
        y2(i) = (1+Z2^2)*(1+A2-B2);
        y3(i) = (1+Z3^2)*(1+A3-B3);
        y4(i) = (1+Z4^2)*(1+A4-B4);
    end
end

figure;
subplot(2,2,1);
plot(x,y1);
axis([0 2.5 0 2.5]);
title('Z = 0','interpret','latex')
xlabel('$eV/\Delta$', 'interpret', 'latex')
ylabel('$R_N \frac{dI}{dV}$','interpret','latex')

subplot(2,2,2);
plot(x,y2);
axis([0 2.5 0 3]);
title('Z = 0.5','interpret','latex')
xlabel('$eV/\Delta$', 'interpret', 'latex')
ylabel('$R_N \frac{dI}{dV}$','interpret','latex')

subplot(2,2,3);
plot(x,y3);
axis([0 2.5 0 8]);
title('Z = 1.5','interpret','latex')
xlabel('$eV/\Delta$', 'interpret', 'latex')
ylabel('$R_N \frac{dI}{dV}$','interpret','latex')

subplot(2,2,4);
plot(x,y4);
axis([0 2.5 0 8])
title('Z = 5.0','interpret','latex')
xlabel('$eV/\Delta$', 'interpret', 'latex')
ylabel('$R_N \frac{dI}{dV}$','interpret','latex')
    