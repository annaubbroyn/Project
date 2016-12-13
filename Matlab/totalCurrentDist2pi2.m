W = 10;

nx = 500;
ny = 1000;
ntheta = 100;
nlambda = 100;
nB=100;
n = nB;

%x = linspace(-0.5,0.5,nx);
x = 0;
%lambda = linspace(-2*pi,2*pi,nlambda);
lambda = [0.5 1 2];%[0.7 0.8 1.5];
%B = linspace(-100/W,100/W,nB);
B = linspace(-40,40,nB);
%B = 1/0.3^2;

dtheta = pi/(ntheta*2);
dy = W/ny;

figure(1)
hold on
for lam = 1:length(lambda)
    I = zeros(n,1);
    for k=1:n
        k
        y = -W/2;
        for i = 1:ny
            theta = dtheta;
            I_temp = zeros(n,1);
            for j = 1:ntheta-2
                %gamma = 2*B(k)*(y-x*tan(theta))*sin(pi*tan(theta)/lambda(lam))/(pi*tan(theta)/lambda(lam))*sin(2*pi/lambda(lam)*(y-x*tan(theta)))/(2*pi/lambda(lam)*(y-x*tan(theta)));
                %gamma = 2*lambda(lam)*B(k)/pi*(y-x*tan(theta))*sin(pi/lambda(lam));
                %gamma = B(k)*tan(theta)*(lambda(lam)^2/pi^2*sin(pi/lambda(lam))-lambda(lam)/pi*cos(pi/lambda(lam)));
                gamma = B(k)*lambda(lam)^2/(pi^2*tan(theta))*sin(pi*tan(theta)/lambda(lam))*sin(2*pi/lambda(lam)*(y-x*tan(theta)));
                %gamma = B*lambda(lam)^2/(pi^2*tan(theta))*sin(pi*tan(theta)/lambda(lam))*sin(2*pi/lambda(lam)*(y-x(k)*tan(theta)));
                %gamma = 2*B(k)*(y-x*tan(theta));
                I_temp(k,1) = I_temp(k,1) + cos(theta)*cos(gamma)*dtheta;

                theta = theta + dtheta;
            end
            I(k,1) = I(k,1) + I_temp(k,1)*dy;
            y = y + dy;
        end
    end
    plot(B,abs(I(:,1))/W,'linewidth',1.5);
end
%axis([B(1)*W B(length(B))*W 0 1]);
%axis([B(1) B(length(B)) 0 1]);
h = legend('$\lambda/L = 0.5$','$\lambda/L = 1$','$\lambda/L = 2$');
set(h,'Interpreter','Latex','fontsize',12,'position',[0.69 0.725 0.2 0.2])
set(gca,'XTick',[-40 -20 0 20 40])
set(gca,'YTick',[0 0.5 1],'fontsize',20)
xlabel('$B$ $[\hbar /e L^2]$','interpret','latex','fontsize',20)
ylabel('Critical current $I_c/I_{c,0}$','interpret','latex','fontsize',20)

