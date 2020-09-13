function [K,F] = enforceBCs2D(DirichletNodes,DirichletValues,K,F)
% Takes boundaryNodes, boundaryValues, global K and F as inputs, enforces
% the boundary conditions and returns the updated K and F.
% Only handles Dirichlet BCs
Values = DirichletValues; 
Nodes = DirichletNodes;
for i = 1:length(Nodes)
    F = F - Values(i)*K(:,Nodes(i));
    F(Nodes(i))=Values(i);
    K(Nodes(i),:)=0;
    K(:,Nodes(i))=0;
    K(Nodes(i),Nodes(i)) = 1;
end
end