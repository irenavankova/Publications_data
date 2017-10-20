function [xvec_u, yvec_u, xvec_v, yvec_v, xvec_p, yvec_p, xvec, yvec] = get_coordinates_for_variables(CtrlVar, x,y)
% DEFINE DIFFERENT COORDINATE VECTORS FOR DIFFERENT VARIABLES

dx = CtrlVar.dx;
dy = CtrlVar.dy;
%Nx = CtrlVar.Nx;
%Ny = CtrlVar.Ny;

Nx = length(x)-2;
Ny = length(y)-2;
% -u component of velocity and associated coordinates

xvec_u = repmat(x,Ny+1,1);
temp = repmat(y(1:end-1)+dy/2,1,Nx+2);
yvec_u = reshape(temp',(Nx+2)*(Ny+1),1);

% -v component of velocity and associated coordinates

xvec_v = repmat(x(1:end-1)+dx/2,Ny+2,1);
temp = repmat(y,1,Nx+1);
yvec_v = reshape(temp',(Nx+1)*(Ny+2),1);

% -cell center coordinates

xvec_p = repmat(x(1:end-1)+dx/2,Ny+1,1);
temp = repmat(y(1:end-1)+dy/2,1,Nx+1);
yvec_p = reshape(temp',(Nx+1)*(Ny+1),1);

% -edge nodes coordinates

xvec = repmat(x,Ny+2,1);
temp = repmat(y,1,Nx+2);
yvec = reshape(temp',(Nx+2)*(Ny+2),1);