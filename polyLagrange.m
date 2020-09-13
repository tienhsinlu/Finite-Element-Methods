% Homework 2 Problem 3
function psi =  polyLagrange(k)
% Take an integer k as input denoting the degree of shape functions desired
% and returns a structure psi of size 1 by k+1 with two fields: psi.fun and
% psi.der, where psi.fun stores the coefficients of the Lagrange polynomial
% of degree k in descending powers and psi.der stores the coefficients of 
% the derivatives in descending order.
    psi =  struct('fun',zeros(1,k+1),'der',zeros(1,k)); 
    % Create and initialize structure psi
    nodes = linspace(-1,1,k+1); % node values
    I = eye(k+1);
    for i = 1:k+1
        psi(i).fun = polyfit(nodes,I(i,:),k); 
        % coefficients of the lagrange polynomial of degree k for node i
        psi(i).der = polyder(psi(i).fun);% coefficients of the derivative
    end
end