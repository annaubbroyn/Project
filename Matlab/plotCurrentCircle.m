l= 0.8;
option = 1;
lambda = [8 20];
video = 0;
vortex = 0;

phi = pi/4  ;
nx = 50;
ny = 200;
%nk = 100;
ntheta = 100;

cm = colormap(jet);
cm = cm(10:50,:);

% caxis([-7 7])
% S=1; %fully saturated
% L=[.1 1 .1]; %dark-white-dark
% cm = hslcolormap('mbbccc.YYYRRm',S,L); %magenta-blue-cyan / yellow-red-magenta
% cm = cm(20:280,:);

if(video == 1)
    writerobj = VideoWriter('out.avi');
    writerobj.FrameRate = 5;
    open(writerobj);
end

if(option == 1)
    lambda = 1;
end


for k = 1:length(lambda)
    k
    x0 = linspace(-0.5,0.5,nx);
    y0 = linspace(-2,2,ny);
    jx = zeros(nx,ny);
    jy = zeros(nx,ny);
    jtot = zeros(nx,ny);
    theta = linspace(-pi/2,pi/2,ntheta);

    [y,x] = meshgrid(y0,x0);

    I = linspace(0,0,nx);

    for i=1:nx

        for j = 1:ny
            fun= @(theta)localCurrentCircle(x(i,j),y(i,j),theta, l, phi,option,lambda(k));
            dtheta = pi/ntheta;
            theta = -pi/2 + dtheta;
            for(n = 1:98)
                jx(i,j) = jx(i,j)+fun(theta)*cos(theta)*dtheta;
                jy(i,j) = jy(i,j)+fun(theta)*sin(theta)*dtheta;
                theta = theta + dtheta;
            end

            jtot(i,j) = sqrt(jx(i,j)^2+jy(i,j)^2);
        end
    end

    fig = figure(k);
    hold on
    fig.Units = 'normalized';
    %fig.OuterPosition = [.05 .05 .45 .9];
    axis([-0.5 0.5 -2 2.1]);
    fig.OuterPosition = [.05 .05 .17 .9];
    L = sqrt(jx.^2 + jy.^2);
    %quiver(x,y,jx,jy,'r','AutoScaleFactor',.3);
    %quiver(x(1:2:nx,1:2:ny),y(1:2:nx,1:2:ny),jx(1:2:nx,1:2:ny),jy(1:2:nx,1:2:ny),'r','AutoScaleFactor',0.3);
    %quiver(x(1:3:nx,1:3:ny),y(1:3:nx,1:3:ny),jx(1:3:nx,1:3:ny),jy(1:3:nx,1:3:ny),'r','AutoScaleFactor',0.4);
    %quiver(x(1:3:nx,1:3:ny),y(1:3:nx,1:3:ny),jx(1:3:nx,1:3:ny),jy(1:3:nx,1:3:ny),'r','AutoScaleFactor',0.3);
    quiver(x(1:5:nx,1:5:ny),y(1:5:nx,1:5:ny),jx(1:5:nx,1:5:ny),jy(1:5:nx,1:5:ny),'r','AutoScaleFactor',0.5);
    %quiver(x(1:4:nx,1:4:ny),y(1:4:nx,1:4:ny),jx(1:4:nx,1:4:ny)./L(1:4:nx,1:4:ny),jy(1:4:nx,1:4:ny)./L(1:4:nx,1:4:ny),'r','AutoScaleFactor',.4);
    %quiver(x(1:4:nx,1:10:ny),y(1:4:nx,1:10:ny),jx(1:4:nx,1:10:ny)./L(1:4:nx,1:10:ny),jy(1:4:nx,1:10:ny)./L(1:4:nx,1:10:ny),'r','AutoScaleFactor',.5);
    h = surf(x,y,0.5*jtot);
    view(0,90); shading interp
    set(h,'ZData',jtot-1);
    colormap(cm)
    hcb = colorbar('southoutside');
    set(hcb,'YTick',[-1 -0.75 -0.5],'YtickLabel',{'0','0.25','0.5'},'fontsize',15)
    set(gca,'XTick',[-0.5 0 0.5],'XtickLabel',{'-L/2','0','L/2'},'fontsize',15);
    set(gca,'YTick',[-2 -1 0 1 2],'YtickLabel',{'-2L','-L','0','L','2L'},'fontsize',15);
    caxis([-1 -0.5])
    handle = title(['$\lambda/L = $' num2str(lambda(k))],'interpret','latex');
    set(handle,'Units','Normalized','Position',[0.5 0.98 1]);
    
    figGcf = gcf;
    figGcf.PaperUnits = 'normalized';
    figGcf.PaperPosition = [0 0 .4 1];
    
    if(video == 0)
        filename1 = ['C:\Users\Anna\Documents\GitHub\Project\Figures\Dist' num2str(option) '\Dist' num2str(option) '_l_0-' num2str(l*10) '_lambda_' num2str(floor(lambda(k))) '-' num2str(floor(100*(lambda(k)-floor(lambda(k))))) 'phi_pi-' floor(num2str(pi/phi))]; 
        filename2 = ['C:\Users\Anna\Documents\GitHub\Project\Figures\Dist' num2str(option) '\Matlab\Dist' num2str(option) '_l_0-' num2str(l*10) '_lambda_' num2str(floor(lambda(k))) '-' num2str(floor(100*(lambda(k)-floor(lambda(k))))) 'phi_pi-' floor(num2str(pi/phi))]; 
        print(filename1,'-dpng')
        savefig(filename2)
    else
        frame = getframe(figGcf);
        writeVideo(writerobj,frame);
    end
    
    close(fig);
    if( option == 1 && vortex == 1)
    hold off
    
    fig2 = figure(2*k);
    hold on
    %quiver(x(1:6:nx,1:10:ny),y(1:6:nx,1:10:ny),jx(1:6:nx,1:10:ny)./L(1:6:nx,1:10:ny),jy(1:6:nx,1:10:ny)./L(1:6:nx,1:10:ny),'k','AutoScaleFactor',.5,'AlignVertexCenters','on','linewidth',1);
    %quiver(x(1:8:nx,1:8:ny),y(1:8:nx,1:8:ny),jx(1:8:nx,1:8:ny)./L(1:8:nx,1:8:ny),jy(1:8:nx,1:8:ny)./L(1:8:nx,1:8:ny),'k','AutoScaleFactor',.4,'linewidth',1);
    quiver(x(1:8:nx,1:8:ny),y(1:8:nx,1:8:ny),jx(1:8:nx,1:8:ny),jy(1:8:nx,1:8:ny),'k','AutoScaleFactor',.4,'linewidth',1);
    
    plot(0,-pi*l^2*1.25,'ob','markerfacecolor','b','markersize',10)
    plot(0,-pi*l^2*0.75,'or','markerfacecolor','r','markersize',10)
    plot(0,-pi*l^2*0.25,'ob','markerfacecolor','b','markersize',10)
    plot(0,pi*l^2*0.25,'or','markerfacecolor','r','markersize',10)
    plot(0,pi*l^2*0.75,'ob','markerfacecolor','b','markersize',10)
    plot(0,pi*l^2*1.25,'or','markerfacecolor','r','markersize',10)
    
    fig2.Units = 'normalized';
    fig2.GraphicsSmoothing = 'on';
    fig2.Renderer = 'opengl';
    axis([-0.5 0.5 -2 2.1]);
    fig2.OuterPosition = [.05 .05 .17 .9];
    set(gca,'XTick',[-0.5 0 0.5],'XtickLabel',{'-L/2','0','L/2'},'fontsize',15);
    set(gca,'YTick',[-2 -1 0 1 2],'YtickLabel',{'-2L','-L','0','L','2L'},'fontsize',15);
    handle = title(['$\lambda/L = $' num2str(lambda(k))],'interpret','latex');
    set(handle,'Units','Normalized','Position',[0.5 0.98 1]);
    
    figGcf = gcf;
    figGcf.PaperUnits = 'normalized';
    figGcf.PaperPosition = [0 0 .4 1];
    
    filename1 = ['C:\Users\Anna\Documents\GitHub\Project\Figures\Dist' num2str(option) '\Vortex' num2str(option) '_l_0-' num2str(l*10) '_lambda_' num2str(floor(lambda(k))) '-' num2str(floor(100*(lambda(k)-floor(lambda(k))))) 'phi_pi-' floor(num2str(pi/phi))]; 
    filename2 = ['C:\Users\Anna\Documents\GitHub\Project\Figures\Dist' num2str(option) '\Matlab\Vortex' num2str(option) '_l_0-' num2str(l*10) '_lambda_' num2str(floor(lambda(k))) '-' num2str(floor(100*(lambda(k)-floor(lambda(k))))) 'phi_pi-' floor(num2str(pi/phi))]; 
    print(filename1,'-dpng')
    print(filename1,'-dpdf')
    savefig(filename2)
    end
    
end
if(video == 1)
    close(writerobj)
end