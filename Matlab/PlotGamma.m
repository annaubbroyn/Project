lambda=[0.5 0.7 2];

%%%%%%%%%%%%%%%%%%%%%
%Sinusodial along junction with phi=pi/2
x = linspace(-1,1,1000);
%y = x.*(x.*sin(1./x)-cos(1./x));
y = x.*sin(1./x);
x1 = lambda(1)/pi;
x2 = lambda(2)/pi;
x3 = lambda(3)/pi;
y1 = x1*sin(1/x1);
y2 = x2*sin(1/x2);
y3 = x3*sin(1/x3);
figure(2)
hold on
plot(x,y,'linewidth',1)
plot(x1,y1,'rs','MarkerFaceColor','r');
plot(x2,y2,'rs','MarkerFaceColor','r');
plot(x3,y3,'rs','MarkerFaceColor','r');
xlabel('$\frac{\lambda}{\pi L}$','interpret','latex');
%ylabel('$\frac{\gamma}{(L/l_m)^2\tan(\theta)}$','interpret','latex');
ylabel('$\gamma/\gamma_{\mathrm{uni}}$','interpret','latex');
set(gca,'YTick',[-1 -0.5 0 0.5 1],'fontsize',20)
txt1 = ['$\ \lambda/L =$ ' num2str(lambda(1))];
txt2 = ['$\ \lambda/L =$ ' num2str(lambda(2))];
txt3 = ['$\ \lambda/L =$ ' num2str(lambda(3))];
text(x1,y1,txt1,'interpret','latex','fontsize',18)
text(x2,y2,txt2,'interpret','latex','fontsize',18)
text(x3,y3,txt3,'interpret','latex','fontsize',18)

%%%%%%%%%%%%%%%%%%%%%%
%Sinusodial along junction with phi=0
figure(3)
hold on
x = linspace(-1,1,1000);
y = x.*(x.*sin(1./x)-cos(1./x));
x1 = lambda(1)/pi;
x2 = lambda(2)/pi;
x3 = lambda(3)/pi;
y1 = x1*(x1*sin(1/x1)-cos(1/x1));
y2 = x2*(x2*sin(1/x2)-cos(1/x2));
y3 = x3*(x3*sin(1/x3)-cos(1/x3));
txt1 = ['$\ \lambda/L = $ ' num2str(lambda(1))];
txt2 = ['$\ \lambda/L = $ ' num2str(lambda(2))];
txt3 = ['$\ \lambda/L = $ ' num2str(lambda(3))];
plot(x,y,'linewidth',1)
plot(x1,y1,'rs','MarkerFaceColor','r');
plot(x2,y2,'rs','MarkerFaceColor','r');
plot(x3,y3,'rs','MarkerFaceColor','r');
text(x1,y1,txt1,'interpret','latex','fontsize',18)
text(x2,y2,txt2,'interpret','latex','fontsize',18)
text(x3,y3,txt3,'interpret','latex','fontsize',18)
xlabel('$\lambda$ $[\pi L]$','interpret','latex','fontsize',25);
ylabel('$\gamma$ $[(L/l_m)^2\tan\theta]$','interpret','latex','fontsize',25);
set(gca,'YTick',[-1 -0.5 0 0.5 1],'fontsize',20)
set(gca,'XTick',[-1 -0.5 0 0.5 1],'fontsize',20)

%%%%%%%%%%%%%%%%%%%%%%
%Current density for Dist3 phi=0
figure(4)
hold on
l=0.3;
%nx = 10000;
nx = 10;
ntheta = 1000;
dtheta = pi/ntheta;
x = linspace(-1,1,nx);
phi =pi/2;
jx = zeros(nx,1);
jy = zeros(nx,1);
jtot =zeros(nx,1);
jx0 = zeros(nx,1);
jy0 = zeros(nx,1);
jtot0 =zeros(nx,1);
jx1 =0; jy1 =0; jx2 =0; jy2 =0; jx3 =0; jy3 =0;

x1 = lambda(1)/pi;
x2 = lambda(2)/pi;
x3 = lambda(3)/pi;
txt1 = ['$\ \lambda/L = $ ' num2str(lambda(1))];
txt2 = ['$\ \lambda/L = $ ' num2str(lambda(2))];
txt3 = ['$\ \lambda/L = $ ' num2str(lambda(3))];
%txt1 = '$\ \ \lambda/L = 0.7$';
%txt2 = '$\ \ \lambda/L = 0.5$';
%txt3 = '$\quad \quad \lambda/L = 1.5$';

gamma1= @(theta)tan(theta)/l^2*(x1^2*sin(1/x1)-x1*cos(1/x1));
gamma2= @(theta)tan(theta)/l^2*(x2^2*sin(1/x2)-x2*cos(1/x2));
gamma3= @(theta)tan(theta)/l^2*(x3^2*sin(1/x3)-x3*cos(1/x3));
theta = -pi/2 + dtheta;
for(n = 1:ntheta-2)
    I1 = sin(phi/2-gamma1(theta)/2)*tanh(cos(phi/2-gamma1(theta)/2)/2);
    I2 = sin(phi/2-gamma2(theta)/2)*tanh(cos(phi/2-gamma2(theta)/2)/2);
    I3 = sin(phi/2-gamma3(theta)/2)*tanh(cos(phi/2-gamma3(theta)/2)/2);
    jx1 = jx1+I1*cos(theta)*dtheta;
    jy1 = jy1+I1*sin(theta)*dtheta;
    jx2 = jx2+I2*cos(theta)*dtheta;
    jy2 = jy2+I2*sin(theta)*dtheta;
    jx3 = jx3+I3*cos(theta)*dtheta;
    jy3 = jy3+I3*sin(theta)*dtheta;
    theta = theta + dtheta;
end
jtot1 = sqrt(jx1^2+jy1^2);
jtot2 = sqrt(jx2^2+jy2^2);
jtot3 = sqrt(jx3^2+jy3^2);

for i = 1:nx
    gamma= @(theta)tan(theta)/l^2*(x(i)^2*sin(1/x(i))-x(i)*cos(1/x(i)));
    theta = -pi/2 + dtheta;
    for(n = 1:ntheta-2)
        I = sin(phi/2-gamma(theta)/2)*tanh(cos(phi/2-gamma(theta)/2)/2);
        I0 =sin(phi/2)*tanh(cos(phi/2)/2);    
        %I = sin(phi-gamma(theta));
        jx(i) = jx(i)+I*cos(theta)*dtheta;
        jy(i) = jy(i)+I*sin(theta)*dtheta;
        jx0(i) = jx0(i)+I0*cos(theta)*dtheta;
        jy0(i) = jy0(i)+I0*sin(theta)*dtheta;
        theta = theta + dtheta;
    end
    jtot(i) = sqrt(jx(i)^2+jy(i)^2);
    jtot0(i) = sqrt(jx0(i)^2+jy0(i)^2);
end
plot(x,jtot./jtot0,'linewidth',1)%,x*pi,abs(x.*(x.*sin(1./x)-cos(1./x))/l^2).*besselk(1,abs(x.*(x.*sin(1./x)-cos(1./x))/l^2)));
plot(x1,jtot1/jtot0(1),'rs','MarkerFaceColor','r');
plot(x2,jtot2/jtot0(1),'rs','MarkerFaceColor','r');
plot(x3,jtot3/jtot0(1),'rs','MarkerFaceColor','r');
text(x1,jtot1/jtot0(1),txt1,'interpret','latex','fontsize',18)
text(x2,jtot2/jtot0(1),txt2,'interpret','latex','fontsize',18)
text(x3,jtot3/jtot0(1)+0.05,txt3,'interpret','latex','fontsize',18,'HorizontalAlignment','center')
axis([-1 1 0 1.1]);
xlabel('$\lambda$ $[\pi L]$','interpret','latex','fontsize',25);
ylabel('$j/j_0$','interpret','latex','fontsize',20);
set(gca,'YTick',[0 0.5 1],'fontsize',20)
set(gca,'XTick',[-1 -0.5 0 0.5 1],'fontsize',20)