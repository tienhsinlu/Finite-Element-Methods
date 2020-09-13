% Homework 3 Problem 1a
function [ke,fe]=element1D(psi)
% Take as input the set of shape functions psi and returns the structure ke
% with components ke(i,j).k and ke(i,j).b, and the vector fe with
% components fe(i).
d = length(psi)-1;
k = 2*d;
Q = quadGaussLegendre(ceil((k+1)/2));% use quadGaussLengendre to help solving integrals
Qf = quadGaussLegendre(ceil((d+1)/2));
ke = struct('k',zeros(d+1,d+1),'b',zeros(d+1,d+1)); % Initilized ke
fe = zeros(d+1,1); % Initialize fe
for i = 1:d+1
    for j = 1:i
        g = conv(psi(i).der, psi(j).der);
        y = conv(psi(i).fun, psi(j).fun);
        g_gauss = polyval(g,Q.Points);
        y_gauss = polyval(y,Q.Points);
        ke.k(i,j) = Q.Weights'*g_gauss; % Dot products
        ke.k(j,i) = ke.k(i,j); % by symmetry
        ke.b(i,j) = Q.Weights'*y_gauss;
        ke.b(j,i) = ke.b(i,j);
    end
    % find fe 
    fe(i) = dot(Qf.Weights,polyval(psi(i).fun,Qf.Points)); 
end
end