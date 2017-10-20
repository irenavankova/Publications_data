function [Berg_vertex] = get_berg_vertex(CtrlVar,Bergs,b)

R = [cos(Bergs(b).Angle) -sin(Bergs(b).Angle); sin(Bergs(b).Angle) cos(Bergs(b).Angle)];
    
% FIND BERG VERTICES AROUND ORIGIN
Berg_vertex.x(1) = - Bergs(b).HLx;
Berg_vertex.x(2) = Bergs(b).HLx;
Berg_vertex.x(3) = Berg_vertex.x(2);
Berg_vertex.x(4) = Berg_vertex.x(1);

Berg_vertex.y(1) = - Bergs(b).HLy;
Berg_vertex.y(2) = Berg_vertex.y(1);
Berg_vertex.y(3) = Bergs(b).HLy;
Berg_vertex.y(4) = Berg_vertex.y(3);

% ROTATE
for bv = 1:4
    v = [Berg_vertex.x(bv); Berg_vertex.y(bv)];
    v = R*v;
    Berg_vertex.x(bv) = v(1);
    Berg_vertex.y(bv) = v(2);
end

% SHIFT TO CM LOCATION
Berg_vertex.x = Bergs(b).CMx + Berg_vertex.x;
Berg_vertex.y = Bergs(b).CMy + Berg_vertex.y;    

[Berg_vertex] = circshift_berg_vertices(CtrlVar,Bergs(b),Berg_vertex);
