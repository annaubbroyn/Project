x = linspace(-0.5,0.5,100);
y = linspace(-0.5,0.5,100);
l = 0.8;
E = 0.2;

tan = @(k)sin(k)/sqrt(1-(cos(k)+2*E-2)^2);
gamma = @(k)2/l^2*(x-y*(sin(k)/sqrt(1-(cos(k)+2*E-2)^2)));
I =@(k)sin(-gamma(k)/2)*tanh(cos(-gamma(k))/2);

jx = integral(gamma,-acos(1-2*E),acos(1-2*E),'ArrayValued',true);