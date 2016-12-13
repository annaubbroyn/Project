E = 0.99;
l= 0.32;

phi = pi;
nx = 100;
ny = 100;
nk = 100;
x0 = linspace(-0.5,0.5,nx);
y0 = linspace(-0.5,0.5,ny);
jx = zeros(nx,nx);
jy = zeros(nx,ny);
jtot = zeros(nx,ny);
kF = acos(1-2*E);
kx = linspace(-kF,kF,nk);

[x,y] = meshgrid(x0,y0);

for i=1:nx
    for j = 1:ny
        fun= @(k)localCurrent(x(i,j),y(i,j),k, E, l, phi);
        tan= @(k)sin(k)./sqrt(1-(cos(k)+2*E-2).^2);
        dk = 2*kF/100;
        k = -kF+dk;
        for n = 1:98
            jx(i,j) = jx(i,j)+(fun(k)*tan(k))*dk;
            jy(i,j) = jy(i,j)+fun(k)*dk;
            k = k+dk;
        end
        jtot(i,j) = jx(i,j)^2+jy(i,j)^2;
    end
end
cm_temp = colormap(jet);
cm = cm_temp(15:60,:);

figure(1)
hold on
quiver(x,y,jx,jy,'r');
h = surf(x,y,jtot); 
view(0,90); shading interp
set(h,'ZData',jtot-1);
colormap(cm)
colorbar
