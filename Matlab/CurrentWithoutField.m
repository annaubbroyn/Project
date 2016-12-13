%Critical Current
zeta = linspace(0,10,1000);
phi = pi/2;
I = 2*sin(phi)./sqrt((cos(phi/2)^2+zeta).*(zeta+1)).*tanh(0.5*sqrt((cos(phi/2)^2+zeta)./(zeta+1)));

figure(1)
hold on
plot(zeta,I,'linewidth',1.5);
axis([zeta(1) zeta(length(zeta)) 0 1])
set(gca,'YTick',[0 0.5 1],'fontsize',20)
set(gca,'XTick',[0 zeta(length(zeta))/2 zeta(length(zeta))])
xlabel('$\zeta$','interpret','latex','fontsize',20)
ylabel('$I_{c,\zeta}/I_{c,0}$','interpret','latex','fontsize',20)
hold off


%Total Current
zeta1 = 0;
zeta2 = 0.1;
zeta3 = 1;
zeta4 = 10;
phi = linspace(-2*pi,2*pi,1000);
I1 = 2*sin(phi)./sqrt((cos(phi/2).^2+zeta1)*(zeta1+1)).*tanh(0.5*sqrt((cos(phi/2).^2+zeta1)/(zeta1+1)));
I2 = 2*sin(phi)./sqrt((cos(phi/2).^2+zeta2)*(zeta2+1)).*tanh(0.5*sqrt((cos(phi/2).^2+zeta2)/(zeta2+1)));
I3 = 2*sin(phi)./sqrt((cos(phi/2).^2+zeta3)*(zeta3+1)).*tanh(0.5*sqrt((cos(phi/2).^2+zeta3)/(zeta3+1)));
I4 = 2*sin(phi)./sqrt((cos(phi/2).^2+zeta4)*(zeta4+1)).*tanh(0.5*sqrt((cos(phi/2).^2+zeta4)/(zeta4+1)));

figure(2)
hold on 
plot(phi,I1,phi,I2,phi,I3,phi,I4,'linewidth',1.5)
h=legend('$\zeta = 0$','$\zeta = 0.1$','$\zeta = 1$','$\zeta = 10$');
set(h,'Interpreter','Latex')
axis([-2*pi 2*pi -1.1 1.1])
set(gca,'YTick',[-1 -0.5 0 0.5 1],'fontsize',20)
set(gca,'XTick',[-2*pi -pi 0 pi 2*pi], 'XTicklabels', {'-2\pi','-\pi','0','\pi','2\pi'})
xlabel('$\Delta \varphi$','interpret','latex','fontsize',20)
ylabel('$I/I_{c,0}$','interpret','latex','fontsize',20)
hold off