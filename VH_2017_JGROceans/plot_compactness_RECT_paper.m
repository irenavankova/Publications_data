function plot_compactness_RECT_paper(CtrlVar,Bergs,x,y,Compact,t,flag_ghost,cb)

if nargin == 6
    flag_ghost = 0;
end

mkm = 1000;

dx = CtrlVar.dx/mkm;
dy = CtrlVar.dy/mkm;

x = x/mkm;
y = y/mkm;

cmin = 0;
cmax = 1;

%levels = [0 0.1 0.3 0.5, 0.8, 0.9];
levels = cmin:0.1:0.9;
%levels = cmin:0.05:0.95;
if flag_ghost == 1
   % contourf(x(1:end-1)+dx/2,y(1:end-1)+dy/2,Compact(1:end,1:end)',levels,'LineColor','none');
    pcolor(x(1:end-1)+dx/2,y(1:end-1)+dy/2,Compact(1:end,1:end)'); shading interp;
    xmin = x(1);
    xmax = x(end);
    ymin = y(1);
    ymax = y(end);    
else
    contourf(x(1:end-1)+dx/2,y(1:end-1)+dy/2,Compact(1:end,1:end)',levels,'LineColor','none');
    %pcolor(x(1:end-1)+dx/2,y(1:end-1)+dy/2,Compact(1:end,1:end)'); shading interp;
    xmin = x(2);
    xmax = x(end-1);
    ymin = y(2);
    ymax = y(end-1);
end
hold on

if CtrlVar.NumberOfBergsNow > 0
    for j = 1:CtrlVar.NumberOfBergsNow
        [Berg_vertex] = get_berg_vertex(CtrlVar,Bergs,j);
        plot([reshape(Berg_vertex.x,1,4) Berg_vertex.x(1)]/mkm, [reshape(Berg_vertex.y,1,4) Berg_vertex.y(1)]/mkm, 'k','LineWidth',1);
    end
end

title(['Compactness: time = ' num2str(t)])
xlabel('x (km)')
ylabel('y (km)')
%axis tight equal
xlim([xmin xmax])
ylim([ymin ymax])
if cb == 1
    colorbar
end
colormap jet
caxis([cmin cmax]);