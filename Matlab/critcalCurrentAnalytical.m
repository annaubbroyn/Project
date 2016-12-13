%%%%%%%%%%%%%%%%%%
%Constant field

flux = linspace(-40,40,1000);
I = abs(sin(flux)./flux);
figure(1)
plot(flux,I,'linewidth',1.5);
set(gca,'YTick',[0 0.5 1],'fontsize',15)
set(gca,'XTick',[-40 -20 0 20 40])
xlabel('Magnetic flux $\Phi$ $[\hbar /e]$','interpret','latex','fontsize',15)
ylabel('Critical current $I_{c,\mathrm{const}}/I_{c,0}$','interpret','latex','fontsize',15)


%%%%%%%%%%%%%%%%%
%Sinusodial along junction with phi=0

%lambda = (pi/4:pi/4:pi);
lambda = [0.75,0.8,1.5];
%lambda = 1/4:1/4:2;
%flux = 1;
flux = linspace(-30,30,1000);
%lm = linspace(0,2,1000);
%flux = 1./lm.^2;
%lambda = linspace(-4*pi,4*pi,1000);
figure(2)
hold on
legendCell = cell(length(lambda),1);
for i = 1:length(lambda)
    arg = lambda(i)/pi;
    z = flux*(arg^2*sin(1/arg)-arg*cos(1/arg));
    I2 = abs(z).*besselk(1,abs(z));
    plot(flux,I2,'linewidth',1.5);
    legendCell{i} = num2str(lambda(i)*4/pi', 'lambda=%1d pi/4');
    %legendCell{i} = num2str(lambda(i)*4/pi', '$\lambda=$%1d$\pi/4$');
    %legendCell{i} = num2str(lambda(i)*4', 'lambda=%1d L/4');
end
h = legend('$\lambda/L = 0.7$','$\lambda/L = 0.8$','$\lambda/L = 1.5$');
set(h,'Interpreter','Latex','fontsize',12)
%legend(legendCell)%,'interpret','latex')
%legend(lambda(1),'2','3','4','5','6','7','8')
%axis([-40 40 0 1.5])
%set(gca,'YTick',[0 0.5 1],'fontsize',15)
%set(gca,'XTick',[-40 -20 0 20 40])
axis([-30 30 0 1.4])
set(gca,'YTick',[0 0.5 1],'fontsize',20)
set(gca,'XTick',[-30 -15 0 15 30])
xlabel('$BWL$ $[\frac{L}{W}\frac{\hbar}{e}]$','interpret','latex','fontsize',20)
ylabel('$I_c/I_{c,0}$','interpret','latex','fontsize',20)


%%%%%%%%%%%%%%%%%
%Sinusodial along junction with phi=pi/2

lambda = [0.75 1 2];%0.5*pi;
flux = linspace(-30,30,1000);
figure(3)
hold on
for i = 1:length(lambda)
    I = abs(sin(flux*sin(pi/lambda(i))/(pi/lambda(i)))./(flux*sin(pi/lambda(i))/(pi/lambda(i))));
    plot(flux,I,'linewidth',1.5);
end
h = legend('$\lambda/L = 0.7$','$\lambda/L = 1$','$\lambda/L = 2$');
set(h,'Interpreter','Latex','fontsize',12)
axis([-30 30 0 1.4])
set(gca,'XTick',[-30 -15 0 15 30])
set(gca,'YTick',[0 0.5 1],'fontsize',20)
xlabel('$BWL$ $[\frac{\hbar}{e}]$','interpret','latex','fontsize',20)
ylabel('$I_c/I_{c,0}$','interpret','latex','fontsize',20)

