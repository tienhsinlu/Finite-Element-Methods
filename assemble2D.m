function [K,F] = assemble2D(nodelist, kn, fn, K,F)
% takes nodelist, which tells us where to put kn and fn, fn, kn , K and F
% as inputs and updates the global K and F
K(nodelist,nodelist) = K(nodelist,nodelist)+kn;
F(nodelist) = F(nodelist)+fn;
end