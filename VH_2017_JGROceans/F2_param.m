%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SUBPLOT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear f
%carefull, rows and col are flipped.....I know....goood job Irena

% row = Nr;
% col = Nc;

subplotheight = 4;
subplotwidth= 8;
subplotsx=col;
subplotsy=row;     
leftedge=1;
rightedge=1;   
topedge=1;
bottomedge=1;
spacex=0.2;
spacey=0.2;
plotheight=topedge + bottomedge + spacey * (row-1) + row*subplotheight;
plotwidth=leftedge + rightedge + spacex * (col-1) + col*subplotwidth;

fontsize=10; 

f=figure('visible','on');
clf(f);
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [plotwidth plotheight]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 plotwidth plotheight]);
sub_pos=subplot_pos(plotwidth,plotheight,leftedge,rightedge,bottomedge,topedge,subplotsx,subplotsy,spacex,spacey);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE PLOTTING PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ax1=axes('position',sub_pos{1,1},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');
% set(ax1,'FontSize',fontsize)
