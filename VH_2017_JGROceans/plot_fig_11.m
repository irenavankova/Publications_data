clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SUBPLOT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%carefull, rows and col are flipped.....I know....goood job Irena

row = 1;
col = 3;

subplotheight=5;
subplotwidth=5;
subplotsx=col;
subplotsy=row;     
leftedge=1;
rightedge=1.5;   
topedge=1;
bottomedge=1.2;
spacex=0.2;
spacey=0.5;
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

CtrlVar.plot_stuff_type = '-All-Forces-';
%fileprep0 = 'Stuck_0';
% fff(3).fileprep = 'Stuck_2';
% fff(2).fileprep = 'Stuck_1';
% fff(1).fileprep = 'Stuck_0';
% fig_name = 'Stuck';
fileprep = 'Stuck/ResultsFiles/Move_block-';
fff(3).fileprep = '0000006600';
fff(2).fileprep = '0000003300';
fff(1).fileprep = '0000000000';
fig_name = 'Stuck';

fff(2).abc = 'b)';
fff(1).abc = 'a)';
fff(3).abc = 'c)';
fff(4).abc = 'd) no shear + tension';

fff(1).YLABEL = '\it y \rm (km)';
fff(2).YLABEL = '';
fff(3).YLABEL = '';
fff(4).YLABEL = '';

fff(1).XLABEL = '\it x \rm (km)';
fff(2).XLABEL = '\it x \rm (km)';
fff(3).XLABEL = '\it x \rm (km)';
fff(4).XLABEL = '\it x \rm (km)';

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

%load([fileprep0 '.mat'])
load([fileprep fff(1).fileprep '.mat'])

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

%u = outputs.u;
%v = outputs.v;
%p = outputs.p;

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

%x = x(Nx/4:end-Nx/4+1);
%y = y(1:end-Ny/2-5);

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
bj = [1 1 1 1];
bi = [1 2 3 4];
cb = [0 0 0 0];
t = CtrlVar.t;
for b = 1:3    
    fff(b).ax=axes('position',sub_pos{bi(b),bj(b)},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');
    
    %filename = [fff(b).fileprep '.mat'];
    filename = [fileprep fff(b).fileprep '.mat'];
    
    load(filename)
    
    % -get variables from structure

    if b > 1
        u = outputs.u;
        v = outputs.v;
        Bergs = outputs.Bergs;
        Compact = outputs.Compact;
        t = CtrlVar.t;
    end
    
    %u = u(Nx/4:end-Nx/4+1,1:end-Ny/2-5);
    %v = v(Nx/4:end-Nx/4+1,1:end-Ny/2-5);
    
    %plot_velocity_RECT(CtrlVar,Bergs,x,y,u,v,0,1)
    plot_compactness_RECT_paper(CtrlVar,Bergs,x,y,Compact,t,0,cb(b));
    title(['Time = ' num2str(t) ' s'],'Fontweight','normal')
    xlabel(fff(b).XLABEL)
    %title(fff(b).TITLE)
    ylabel(fff(b).YLABEL)
    %xlim([0 Lx])
    %ylim([ymin ymax])
    set(fff(b).ax,'ytick',0:2:6)
    set(fff(b).ax,'xtick',0:2:6)
    if b > 1
        set(fff(b).ax,'yticklabel','')
    end

    
    set(fff(b).ax,'Fontsize',Fsize )
    text(0.00,1.1,fff(b).abc,'Units', 'Normalized', 'VerticalAlignment', 'Top','Fontsize',Fsize )

end

h=colorbar;
set(h, 'Location','East')
%set(h, 'Position', [.96 .315 .01 .37])
set(h, 'Position', [.97 .16 .01 .7])
set(h,'YTick',[0:0.1:1])



set(gca,'Fontsize',Fsize )
%linkaxes([fff(1).ax,fff(2).ax,fff(3).ax],'x')

% PRINT?

if print_fig == 1
   % print(gcf, '-dpng','-painters',[fig_name,'.png']);
  % print(gcf, '-dpdf','-painters',[fig_name,'.pdf']);
  print(gcf, '-depsc2','-loose',[fig_name,'.eps']);
end