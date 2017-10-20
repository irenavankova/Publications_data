function [Berg_vertex_circshift] = circshift_berg_vertices(CtrlVar,Bergs,Berg_vertex)
% CIRCSHIFT BERG VERTICES TO THE DESIRED ORDER - VERY IMPORTANT

zero = CtrlVar.zero;

% -rotate vertices such that lower corner is first index

low_ver = 1;
miny_ver = find(abs(Berg_vertex.y - min(Berg_vertex.y)) < zero);
if length(miny_ver) > 1
    minx_ver = find(abs(Berg_vertex.x - min([Berg_vertex.x(miny_ver(1)),Berg_vertex.x(miny_ver(2))])) < zero);
else
    minx_ver = miny_ver;
end
low_ver = intersect(miny_ver,minx_ver);

% -rotate vertices such that lower corner is first index

clear miny_ver minx_ver
left_ver = 1;
minx_ver = find(abs(Berg_vertex.x - min(Berg_vertex.x)) < zero);
if length(minx_ver) > 1
    miny_ver = find(abs(Berg_vertex.y - min([Berg_vertex.y(minx_ver(1)),Berg_vertex.y(minx_ver(2))])) < zero);
else
    miny_ver = minx_ver;
end
left_ver = intersect(miny_ver,minx_ver);

if (mod(Bergs.AngleDeg,90) > 45 && mod(Bergs.AngleDeg,90) <= 90)
    Berg_vertex_circshift.y = circshift(reshape(Berg_vertex.y,length(Berg_vertex.y),1),5-(left_ver));
    Berg_vertex_circshift.x = circshift(reshape(Berg_vertex.x,length(Berg_vertex.x),1),5-(left_ver));
    circ_lag = 5-(left_ver);
else
    Berg_vertex_circshift.y = circshift(reshape(Berg_vertex.y,length(Berg_vertex.y),1),5-(low_ver));
    Berg_vertex_circshift.x = circshift(reshape(Berg_vertex.x,length(Berg_vertex.x),1),5-(low_ver));
    circ_lag = 5-(low_ver);
end