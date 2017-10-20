
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SUBPLOT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%carefull, rows and col are flipped.....I know....goood job Irena

row = 3;
col = 2;

F2_param;

% SAVE AND NAME
print_fig = 0;
fig_name = 'Bergs_1D';

time2plot = 12000;
CtrlVar.plot_stuff_type = '-All-Forces-';

fff(1).fileprep = 'ConvDiv/ConvDiv_2Berg_SI_noSI/ResultsFiles/ConvDiv_2Berg_SI_noSI-';
fff(2).fileprep = 'ConvDiv/ConvDiv_2Berg_FV_noSI/ResultsFiles/ConvDiv_2Berg_FV_noSI-';
fff(3).fileprep = 'ConvDiv/ConvDiv_2Berg_EL_noSI/ResultsFiles/ConvDiv_2Berg_EL_noSI-';


fff(1).abc = 'c) Sea ice only';
fff(2).abc = 'b) Fully-Eulerian';
fff(3).abc = 'a) Semi-Lagrangian';

fff(1).YLABEL = '\it{h} \rm{(m)}';
fff(2).YLABEL = '\it{h} \rm(m)';
fff(3).YLABEL = '\it{h} \rm(m)';

fff(1).XLABEL = '\it{x} \rm(km)';
fff(2).XLABEL = '';
fff(3).XLABEL = '';

fff(1).TITLE = '';
fff(2).TITLE = '';
%fff(3).TITLE = ['Time = ' num2str(round(time2plot/360)/10) ' hours'];
fff(3).TITLE = 'Icebergs forced together';%['Time = ' num2str(time2plot) ' s'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE PLOTTING PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lwide = 2;
Fsize = fontsize;

cmap2 = colormap(jet);
cmap1 = colormap(gray);
clr2 = [6,20,36,44,64];
clr1 = [1,1,1,6,40];

clr_u = cmap2(60,:);
clr_u_air = cmap1(44,:);
clr_h = cmap1(1,:);
clr_p = cmap2(20,:);

clr_berg = cmap2(44,:);

load([fff(1).fileprep '0000000000.mat'])
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
x = x/mkm;


px = px/mkm;
w = w/mkm;

ymin = -1*1.1;
ymax = 1*1.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTS ETA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for b = 1:3
    
    fff(b).ax=axes('position',sub_pos{1,b},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');
    
    n1 = num2str(time2plot+10000000000);
    filename = [fff(b).fileprep n1(2:end) '.mat'];

    load(filename)
    CtrlVar.plot_stuff_type = '-All-Forces-';
    CtrlVar.Pause_after_each_plot = 0;
    
    for bb = 1:length(Bergs_init)
        rectangle('Position',[px(bb) 0 w(bb) 1],'FaceColor',clr_berg,'EdgeColor',clr_berg);
        hold on
    end

    plot(x(2:end-2)+dx/2,Thick(2:end-1)/BergHinit,'Color', clr_h,'LineStyle','-','Linewidth',Lwide)
    hold on
    %plot(x(1:end-1)+dx/2,Compact(1:end)/max(abs(Compact)),'r--','Linewidth',2)
    %hold on
    plot(x(2:end-2)+dx/2,-p(2:end-1)/max(abs(p(2:end-1)))*1,'Color', clr_p,'LineStyle','--','Linewidth',Lwide)
    hold on
    plot(x(3:end-2),u(3:end-2)/max(abs(u(3:end-2)))*1,'Color', clr_u,'LineStyle','-','Linewidth',Lwide)
    hold on
    plot(x(3:end-2),u_air(3:end-2)/max(abs(u_air(3:end-2)))*1,'Color', clr_u_air,'LineStyle','--','Linewidth',Lwide)
    hold on
    %if b == 1
        %legend('h','p','u_a','u',leg_pos)
    %end
    %title(['Time = ' num2str(t)])
    if b == 1
        xlabel(fff(b).XLABEL)
    else
        set(fff(b).ax,'xticklabel',[])
    end
    title(fff(b).TITLE)
    %ylabel(fff(b).YLABEL)
    xlim([0 Lx])
    ylim([ymin ymax])
    
    set(fff(b).ax,'Fontsize',Fsize )
    text(0.02,0.92,fff(b).abc,'Units', 'Normalized', 'VerticalAlignment', 'Top','Fontsize',9 )

end


time2plot = 20500;
CtrlVar.plot_stuff_type = '-All-Forces-';

fff(1).fileprep = 'ConvDiv/ConvDiv_2Berg_SI_noSI/ResultsFiles/ConvDiv_2Berg_SI_noSI-';
fff(2).fileprep = 'ConvDiv/ConvDiv_2Berg_FV_noSI/ResultsFiles/ConvDiv_2Berg_FV_noSI-';
fff(3).fileprep = 'ConvDiv/ConvDiv_2Berg_EL_noSI/ResultsFiles/ConvDiv_2Berg_EL_noSI-';

fff(1).abc = 'f) Sea ice only';
fff(2).abc = 'e) Fully-Eulerian';
fff(3).abc = 'd) Semi-Lagrangian';

fff(1).TITLE = '';
fff(2).TITLE = '';
%fff(3).TITLE = ['Time = ' num2str(round(time2plot/360)/10) ' hours'];
fff(3).TITLE = 'Icebergs forced apart';%['Time = ' num2str(time2plot) ' s'];



for b = 1:3
    
    fff(b).ax=axes('position',sub_pos{2,b},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');
    
    n1 = num2str(time2plot+10000000000);
    filename = [fff(b).fileprep n1(2:end) '.mat'];

    load(filename)
    CtrlVar.plot_stuff_type = '-All-Forces-';
    CtrlVar.Pause_after_each_plot = 0;
    
    for bb = 1:length(Bergs_init)
        rectangle('Position',[px(bb) 0 w(bb) 1],'FaceColor',clr_berg,'EdgeColor',clr_berg);
        hold on
    end
    
    ind = find(abs(p) < 10^(-6));
    p(ind) = 0;

    plot(x(2:end-2)+dx/2,Thick(2:end-1)/BergHinit,'Color', clr_h,'LineStyle','-','Linewidth',Lwide)
    hold on
    %plot(x(1:end-1)+dx/2,Compact(1:end)/max(abs(Compact)),'r--','Linewidth',2)
    %hold on
    pmax = max(abs(p(2:end-1)));
    if pmax == 0
        pmax = 1;
    end
    plot(x(2:end-2)+dx/2,-p(2:end-1)/pmax*1,'Color', clr_p,'LineStyle','--','Linewidth',Lwide)
    hold on
    plot(x(3:end-2),u(3:end-2)/max(abs(u(3:end-2)))*1,'Color', clr_u,'LineStyle','-','Linewidth',Lwide)
    hold on
    plot(x(3:end-2),u_air(3:end-2)/max(abs(u_air(3:end-2)))*1,'Color', clr_u_air,'LineStyle','--','Linewidth',Lwide)
    hold on
    if b == 3
        hleg = legend('\it h','\it -p','\it u','\it u_a');
        hleg = legend('Mean thickness','Normal stress','Ice velocity','Air velocity');
        %'Thickness','Normal stress','ice velocity','air velocity',leg_pos,'Fontsize',7)
        %hleg = legend([lg(1).lg;lg(2).lg;lg(3).lg],['M5   ';'M4   ';'M2   ']);
        set(hleg,'Location','Southeast','FontSize',7)
        ppp = get(hleg,'Position');
        %ppp(1) = ppp(1)+0.11;
        %ppp(2) = ppp(2)-0.026;
        %set(hleg,'Position',ppp)
    end

    %title(['Time = ' num2str(t)])
    if b == 1
        xlabel(fff(b).XLABEL)
    else
        set(fff(b).ax,'xticklabel',[])
    end
    set(fff(b).ax,'yticklabel',[])
    title(fff(b).TITLE)
    %ylabel(fff(b).YLABEL)
    xlim([0 Lx])
    ylim([ymin ymax])
    
    set(fff(b).ax,'Fontsize',Fsize )
    text(0.02,0.92,fff(b).abc,'Units', 'Normalized', 'VerticalAlignment', 'Top','Fontsize',9 )


end

set(gca,'Fontsize',Fsize )
%linkaxes([fff(1).ax,fff(2).ax,fff(3).ax],'x')

% PRINT?

if print_fig == 1
   % print(gcf, '-dpng','-painters',[fig_name,'.png']);
  % print(gcf, '-dpdf','-painters',[fig_name,'.pdf']);
  print(gcf, '-depsc2',[fig_name,'.eps']);
end