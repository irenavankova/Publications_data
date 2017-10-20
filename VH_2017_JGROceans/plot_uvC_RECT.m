function plot_uvC_RECT(CtrlVar,Bergs,x,y,u,v,p,t,flag_ghost)
p = -p;

cmap1 = colormap(gray);

if nargin == 6
    flag_ghost = 0;
end

mkm = 1000;

dx = CtrlVar.dx/mkm;
dy = CtrlVar.dy/mkm;

[xvec_u, yvec_u, xvec_v, yvec_v, xvec_p, yvec_p, ~, ~] = get_coordinates_for_variables(CtrlVar,x,y);

% -scattered velocities in a vector
u_u = reshape(u,size(u,1)*size(u,2),1);
v_v = reshape(v,size(v,1)*size(v,2),1);

% -cell center interpolated velocities (denote p) 
u_p = griddata(xvec_u,yvec_u,u_u,xvec_p,yvec_p,'linear');
v_p = griddata(xvec_v,yvec_v,v_v,xvec_p,yvec_p,'linear');

% PLOT PRESSURE
levels = [-1:0.2:-0.1 0.1:0.2:1];
pn = max(max(abs(p)));
contour(x(1:end-1)/mkm+dx/2,y(1:end-1)/mkm+dy/2,p(1:end,1:end)'/pn,levels,'LineWidth',1);
colormap(jet)
caxis([-1, 1])
hold on

% PLOT VELOCITY FIELD
quiver(xvec_p/mkm,yvec_p/mkm,u_p,v_p,'color',cmap1(1,:),'LineWidth',1)
hold on
x = x/mkm;
y = y/mkm;
if flag_ghost == 1
    xmin = x(1);
    xmax = x(end);
    ymin = y(1);
    ymax = y(end);     
else
    xmin = x(2);
    xmax = x(end-1);
    ymin = y(2);
    ymax = y(end-1);
end

hold on
% - plot BERG
if CtrlVar.NumberOfBergsNow > 0
    for b = 1:CtrlVar.NumberOfBergsNow
        [Berg_vertex] = get_berg_vertex(CtrlVar,Bergs,b);
        plot([reshape(Berg_vertex.x,1,4) Berg_vertex.x(1)]/mkm, [reshape(Berg_vertex.y,1,4) Berg_vertex.y(1)]/mkm, 'k','LineWidth',2);
        hold on
        %quiver(Bergs(b).CMx/mkm,Bergs(b).CMy/mkm,Bergs(b).uberg,Bergs(b).vberg,1000,'k','LineWidth',2)
    end
end

title(['Velocity (m/s): time = ' num2str(t)])
xlabel('x (km)')
ylabel('y (km)')
axis equal

xlim([xmin xmax])
ylim([ymin ymax])
