% Homework 3 Problem 1c
function [K,F] = enforceBCs(boundaryNodes, boundaryValues,K,F)
% Takes boundaryNodes, boundaryValues, global K and F as inputs, enforces
% the boundary conditions and returns the updated K and F.
% Only handles Dirichlet BCs
Values = boundaryValues; 
Nodes = boundaryNodes;
F = F - Values(1)*K(:,Nodes(1));
F(Nodes(1)) = Values(1);
K(Nodes(1),:) = 0;
K(:,Nodes(1)) = 0;
K(Nodes(1),Nodes(1)) = 1;
if length(Nodes) == 2 % when both sides are Dirichlet
    F = F - Values(2)*K(:,Nodes(2));
    F(Nodes(2)) = Values(2);
    K(Nodes(2),:) = 0;
    K(:,Nodes(2)) = 0;
    K(Nodes(2),Nodes(2)) = 1;
end
end