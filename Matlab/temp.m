na = 50;
ny = 1000;
ntheta = 50;
a = linspace(-0.5,0.5,na);
%int = zeros(na);
int = 0;

dtheta = pi/(2*ntheta);
dy = 0.1;
W = dy*ny;
lambda = pi;
%for k = 1:na
%    k
    y = -W/2;
    a = 0;
    for j = 1:ny    
        y = y + dy;
        fun= @(theta)cos(theta)*cos(1/l^2*lambda/pi*sin(pi/lambda*tan(theta))/(pi/lambda*tan(theta))*sin(2*pi/lambda*(y-a*tan(theta))));
        theta = dtheta;
        for i = 1:ntheta-2
            %fun= @(theta)-1/a*lambda/pi*sin(pi/lambda*tan(theta))/(pi/lambda*tan(theta))*cos(2*pi/lambda(
            int = int+fun(theta)*dtheta;
            theta = theta + dtheta;
        end
    end
%end
int
%plot(a,int);