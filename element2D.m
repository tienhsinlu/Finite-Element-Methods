function [ke,fe] = element2D(psi)
% Take as input the set of shape functions psi and returns the structure ke
% with components ke(i,j).k and ke(i,j).b, and the vector fe with
% components fe(i).
d = length(psi);
ke = struct('k',zeros(d,d),'b',zeros(d,d)); % Initilized ke
fe = zeros(d,1); % Initialize fe
T = polyshape([0 1 0],[0 0 1]);
Q1 = quadtriangle(2,'Domain',T.Vertices,'Type','nonproduct');
Q2 = quadtriangle(1,'Domain',T.Vertices,'Type','nonproduct');
for i = 1:d
    for j=1:i
        ke.b(i,j)=Q1.Weights'*...
            (bipolyval(psi(i).fun,Q1.Points).*bipolyval(psi(j).fun,Q1.Points));
        ke.b(j,i)=ke.b(i,j);
    end
    fe(i) = Q2.Weights'*bipolyval(psi(i).fun,Q2.Points);
end
end
