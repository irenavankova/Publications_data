%go to the appropriate directory with Move_block-files and go ahead

close all
clear all
fileprep = 'Move_block-';
%plots = 'Thick-';
plots = 'Compact-';
%plots = 'Velocity-';
%plots = 'MeshMove-';


opt_save_figs = 0;
file_save_prep = 'Bergs_JGR-';

load([fileprep '0000000000.mat'])

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

u = inputs.u;
v = inputs.v;
p = Thick*0;

t = 0;
N_beg = 0;
N_end = CtrlVar.Nt/CtrlVar.output_freq*4;
for j = N_beg:N_end
    t = j*CtrlVar.dt*CtrlVar.output_freq;
    n1 = num2str(t+10000000000);
    filename = [fileprep n1(2:end) '.mat'];

    load(filename)
    
    if j > 0
        u = outputs.u;
        v = outputs.v;
        p = outputs.p;
        Thick = outputs.Thick;
        Compact = outputs.Compact;
        Bergs = outputs.Bergs;
    end
    
    % -compute dependent variables
    %[MarkedCellFull,MarkedCellPartial,Tension_Marker,ThickSI,CompactSI,p_max,T_max,gMu, gMv] = initialize_dependent_variables(CtrlVar,Thick,Compact,x,y,Bergs,Bathy);

    num_iter = t/CtrlVar.dt;
    
    %vol_Eul = get_unit_volume_Eul(CtrlVar,Thick);
    %disp(['%% VOLUME: ' num2str(vol_Eul)])
    %area_Eul = get_unit_volume_Eul(CtrlVar,Compact);
    %disp(['%% UNIT AREA: ' num2str(area_Eul)])
    
    figure(300)
    if ~isempty(strfind(plots,'Thick-'))
        plot_thickness_RECT(CtrlVar,Bergs,x,y,Thick,t);
    elseif ~isempty(strfind(plots,'Compact-'))
        %plot_compactness_RECT(CtrlVar,Bergs,x,y,Compact,t);
        plot_compactness_RECT_paper(CtrlVar,Bergs,x,y,Compact,t,0,1);
    elseif ~isempty(strfind(plots,'Velocity-'))
        plot_velocity_RECT(CtrlVar,Bergs,x,y,u,v,t,1)
    elseif ~isempty(strfind(plots,'Stress-'))
        [eta] = get_viscosity_Flato(CtrlVar,u,v,p,p_max,Tension_Marker);
        plot_stress_state_shear_normal(CtrlVar,p,p_max,u,v,[],eta,MarkedCellFull,MarkedCellPartial,Tension_Marker)   
    elseif ~isempty(strfind(plots,'MeshMove-')) && j > 0
        filename = [fileprep 'Adv-' n1(2:end) '.mat'];
        load(filename)
        plot_mesh_nodes_connected(elem_connectivity,x_nodes_grid,y_nodes_grid,'m-',t)
        plot_mesh_nodes_connected(elem_connectivity,x_nodes_new,y_nodes_new,'k-',t)
    end
    %axis equal
    drawnow
        if opt_save_figs == 1
            filename = [file_save_prep plots n1(2:end)];
            print(gcf, '-dpng','-painters',[filename,'.png']);
            close all
        else
            hold off
        end
end

