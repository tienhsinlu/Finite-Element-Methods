function [ke,me,fe] = elementAdv(psi)
d = length(psi)-1;
k = 2*d;
Q = quadGaussLegendre(ceil((k+1)/2));% use quadGaussLengendre to help solving integrals
Qc = quadGaussLegendre(ceil((k)/2));
Qm = quadGaussLegendre(ceil((k+1)/2));
Qf = quadGaussLegendre(ceil((d+1)/2));
ke = struct('k',zeros(d+1,d+1),'c',zeros(d+1,d+1)); % Initilized ke
me = zeros(d+1,d+1);
fe = zeros(d+1,1); % Initialize fe
for i = 1:d+1
    for j = 1:d+1 % loss of symmetry
        g = conv(psi(i).der, psi(j).der);
        y = conv(psi(i).fun, psi(j).der);
        h = conv(psi(i).fun, psi(j).fun);
        g_gauss = polyval(g,Q.Points);
        y_gauss = polyval(y,Qc.Points);
        h_gauss = polyval(h,Qm.Points);
        ke.k(i,j) = Q.Weights'*g_gauss; % Dot products
        ke.c(i,j) = Qc.Weights'*y_gauss;
        me(i,j) = Qm.Weights'*h_gauss;
    end
    % find fe 
    fe(i) = dot(Qf.Weights,polyval(psi(i).fun,Qf.Points)); 
end

end