function [K,M,F] = assembleAdv(nodelist,kn,mn,fn,K,M,F)
K(nodelist,nodelist) = K(nodelist,nodelist)+kn;
F(nodelist) = F(nodelist)+fn;
M(nodelist,nodelist) = M(nodelist,nodelist)+mn;
end