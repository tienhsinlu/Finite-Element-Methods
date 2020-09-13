% Homework 3 Problem 1b
function [K,F] = assemble1D(nodelist, kn, fn, K,F)
% takes nodelist, which tells us where to put kn and fn, fn, kn , K and F
% as inputs and updates the global K and F
i = nodelist(1); j = nodelist(2);
K(i:j,i:j) = K(i:j,i:j)+kn;
F(i:j) = F(i:j)+fn;
end