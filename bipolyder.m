function D = bipolyder(P,d)

%% BIPOLYDER Differentiate bipolynomial
%    F = bipolyder(P,d), returns the partial derivative of the bi-
%    polynomial, P, with respect to dimension d ( = 1 or 2). The derivative 
%    is stored as a multivariate polynomial as described in the documenta-
%    tion of function bipolyval. (Note: Unlike the (univariate) polynomial 
%    case, in the bipolynomial case, the returned result is always the same 
%    size as the input bipolynomial P.)
%    
%    See also bipolyval, bipoly2sym
%
%    Detailed help, with examples, available online at:   
%    http://u.osu.edu/kubatko.3/codes_and_software/polytools/bipolyder/
%

%% Validata input

vP = @(x)validateattributes(x,{'numeric'},{'2d'});
vd = @(x)validateattributes(x,{'numeric'},{'scalar','<=',2});
ip = inputParser;
ip.addRequired('P',vP); ip.addRequired('d',vd);
ip.parse(P,d);
ip.Results;   

%% Compute the derivatives

[l,m] = size(P);

C = P; C(find(P)) = 1; D = zeros(size(P));
switch d
    case 1
        for i = 1:l
            DP = polyder(P(i,:));
            DP = [ zeros(1,m-length(DP)-1) DP ];
            D(i,2:m) = DP.*C(i,1:m-1);
        end
    case 2
        for i = 1:m
            DP = polyder(P(:,i));
            DP = [ zeros(1,l-length(DP)-1) DP ];
            D(2:l,i) = DP'.*C(1:l-1,i);
        end
end

 