W = 10;

nx = 100;
ny = 100;
ntheta = 100;
nlambda = 100;
nB=1000;
n = nB;

%x = linspace(-0.5,0.5,nx);
x = 0;
%lambda = linspace(-2*pi,2*pi,nlambda);
lambda = [0.5 1 2];
B = linspace(-40,40,nB);
%B = 1/0.3^2;

dtheta = pi/(ntheta*2);
dy = W/ny;

figure(1)
hold on
for lam = 1:length(lambda)
    I = zeros(n,1);
    I1 = zeros(n,1);
    I2 = zeros(n,1);
    for k=1:n
        k
        y = -W/2;
        for i = 1:ny
            theta = dtheta;
            I1_temp = zeros(n,1);
            I2_temp = zeros(n,1);
            for j = 1:ntheta-2
                %gamma = -B*lambda/pi*sin(tan(theta)*pi/lambda)/(tan(theta)*pi/lambda)*cos(2*pi/lambda*(y-x(k)*tan(theta)));
                %gamma = -B*lambda(k)/pi*sin(tan(theta)*pi/lambda(k))/(tan(theta)*pi/lambda(k))*cos(2*pi/lambda(k)*(y-x*tan(theta)));
                gamma = -B(k)*lambda(lam)^2/(pi^2*tan(theta))*sin(tan(theta)*pi/lambda(lam))*cos(2*pi/lambda(lam)*(y-x*tan(theta)));
                
                I1_temp(k,1) = I1_temp(k,1) + cos(theta)*cos(gamma)*dtheta;
                I2_temp(k,1) = I2_temp(k,1) + cos(theta)*sin(gamma)*dtheta;

                theta = theta + dtheta;
            end
            I1(k,1) = I1(k,1) + I1_temp(k,1)*dy;
            I2(k,1) = I2(k,1) + I2_temp(k,1)*dy;
            y = y + dy;
        end
    end
    Ic = sqrt(I1.^2+I2.^2)/W;%(sin(-atan(I1./I2)).*I1-cos(atan(I1./I2)).*I2)/W;
    %plot(x,I1(:,1)/W)
    %plot(lambda,abs(I1(:,1))/W);
    %plot(B,abs(I1(:,1))/W);
    plot(B,abs(I1(:,1)/W),'linewidth',1.5);
end
h = legend('$\lambda/L = 0.5$','$\lambda/L = 1$','$\lambda/L = 2$');
set(h,'Interpreter','Latex','fontsize',12,'position',[0.69 0.725 0.2 0.2])
set(gca,'XTick',[-40 -20 0 20 40])
set(gca,'YTick',[0 0.5 1],'fontsize',20)
axis([-40 40 0 1])
xlabel('$B$ $[\hbar /e L^2]$','interpret','latex','fontsize',20)
ylabel('Critical current $I_c/I_{c,0}$','interpret','latex','fontsize',20)

