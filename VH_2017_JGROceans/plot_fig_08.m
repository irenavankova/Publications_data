
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SUBPLOT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%carefull, rows and col are flipped.....I know....goood job Irena

row = 1;
col = 3;


subplotwidth=5;
subplotheight=subplotwidth/1.4375;
subplotsx=col;
subplotsy=row;     
leftedge=1;
rightedge=1.5;   
topedge=1;
bottomedge=3;
spacex=0.2;
spacey=0.7;
fontsize=10; 
plotheight=topedge + bottomedge + spacey * (row-1) + row*subplotheight;
plotwidth=leftedge + rightedge + spacex * (col-1) + col*subplotwidth;

f=figure('visible','on');
clf(f);
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [plotwidth plotheight]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 plotwidth plotheight]);
sub_pos=subplot_pos(plotwidth,plotheight,leftedge,rightedge,bottomedge,topedge,subplotsx,subplotsy,spacex,spacey);

%abc = ['a)';'b)';'c)';'d)';'e)';'f)';'g)';'h)';'i)';'j)';'k)';'l)';'m)';'n)';'o)';'p)'];
%abc = ['c)';'b)';'a)'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SAVE AND NAME
print_fig = 1;

%time2plot = 12000;
time2plot = 20000;
CtrlVar.plot_stuff_type = '-All-Forces-';

% fff(1).fileprep = 'ConvDiv_2Berg_SI_noSI-';
% fff(2).fileprep = 'ConvDiv_2Berg_FV_noSI-';
% fff(3).fileprep = 'ConvDiv_2Berg_EL_noSI-';
% fig_name = 'ConvDiv-2Berg-noSI-End';
% %fig_name = 'ConvDiv-2Berg-noSI-Half';

fff(3).fileprep = 'Push_diff_shear';
fff(2).fileprep = 'Push_same_shear';
fff(1).fileprep = 'Push_no_shear';
fig_name = 'Push_berg_wall';
% fig_name = 'ConvDiv-2Berg-yesSI-Half';

fff(2).abc = 'b) uniform shear';
fff(1).abc = 'a) no shear';
fff(3).abc = 'c) enhanced shear';

fff(1).YLABEL = '\it y \rm (km)';
fff(2).YLABEL = '';
fff(3).YLABEL = '';
fff(4).YLABEL = '';

fff(1).XLABEL = '\it x \rm (km)';
fff(2).XLABEL = '\it x \rm (km)';
fff(3).XLABEL = '\it x \rm (km)';
fff(4).XLABEL = '';

fff(1).TITLE = '';
fff(2).TITLE = '';
fff(3).TITLE = '';
fff(4).TITLE = '';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE PLOTTING PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lwide = 2;
Fsize = fontsize;
leg_pos = 3;

cmap2 = colormap(jet);
cmap1 = colormap(gray);
clr2 = [6,20,36,44,64];
clr1 = [1,1,1,6,40];

clr_u = cmap2(60,:);
clr_u_air = cmap1(44,:);
clr_h = cmap1(1,:);
clr_p = cmap2(20,:);

clr_berg = cmap2(44,:);

load([fff(1).fileprep '.mat'])

% -get variables from structure
x = inputs.x;
y = inputs.y;
Thick = inputs.Thick;
Compact = inputs.Compact;
u_air = inputs.u_air;
u_wat = inputs.u_wat;
v_air = inputs.v_air;
v_wat = inputs.v_wat;
Bathy = inputs.Bathy;
Bergs = inputs.Bergs;

u = outputs.u;
v = outputs.v;
p = outputs.p;

Bergs_init = Bergs;
for bb = 1:length(Bergs)
    px(bb) = Bergs(bb).CMx - Bergs(bb).HLx;
    w(bb) = Bergs(bb).HLx*2;
    belowx(bb) = Bergs(bb).Hberg;
end
BergHinit = max(belowx);

mkm = 1000;

dx = CtrlVar.dx/mkm;
Lx = CtrlVar.Lx/mkm;
%x = x/mkm;
dy = CtrlVar.dy/mkm;
Ly = CtrlVar.Ly/mkm;
%y = y/mkm;

Nx = CtrlVar.Nx;
Ny = CtrlVar.Ny;

x = x(Nx/4:end-Nx/4+1);
y = y(2:end-Ny/2-4);

% x = x - x(1);
% y = y - y(1);

px = px/mkm;
w = w/mkm;

ymin = -BergHinit*1.1;
ymax = BergHinit*1.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTS ETA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% bj = [2 2 2 1 1 1];
% bi = [1 2 3 1 2 3];
bj = [1 1 1];
bi = [1 2 3];
for b = 1:3
    
    fff(b).ax=axes('position',sub_pos{bi(b),bj(b)},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');
    
    filename = [fff(b).fileprep '.mat'];
    
    load(filename)
    
    % -get variables from structure

    u = outputs.u;
    v = outputs.v;
    p = outputs.p;
    
    u = u(Nx/4:end-Nx/4+1,2:end-Ny/2-4);
    v = v(Nx/4:end-Nx/4+1,2:end-Ny/2-4);
    p = p(Nx/4:end-Nx/4+1,2:end-Ny/2-4);
    
    %plot_velocity_RECT(CtrlVar,Bergs,x,y,u,v,0,1)
    plot_uvC_RECT(CtrlVar,Bergs,x,y,u,v,p,0,1)
    
    
    
    %title(['Time = ' num2str(t)])
    xlabel(fff(b).XLABEL)
    title(fff(b).TITLE)
    ylabel(fff(b).YLABEL)
    %xlim([0 Lx])
    %ylim([ymin ymax])
    set(fff(b).ax,'ytick',[0:10])
    set(fff(b).ax,'xtick',[0:10])
    if b == 3 || b == 2
        set(fff(b).ax,'yticklabel','')
    end

    
    set(fff(b).ax,'Fontsize',Fsize )
    text(0.02,1.2,fff(b).abc,'Units', 'Normalized', 'VerticalAlignment', 'Top','Fontsize',Fsize )

end

h=colorbar;
set(h, 'Location','South')
set(h, 'Position', [.2 .1 .6 .02])
set(h,'XTick',[-1:0.2:1])

set(gca,'Fontsize',Fsize )

% PRINT?

if print_fig == 1
   % print(gcf, '-dpng','-painters',[fig_name,'.png']);
  % print(gcf, '-dpdf','-painters',[fig_name,'.pdf']);
  print(gcf, '-depsc2','-loose',[fig_name,'.eps']);
end