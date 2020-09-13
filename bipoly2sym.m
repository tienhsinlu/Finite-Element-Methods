function P = bipoly2sym(C,varargin)

%% BIPOLY2SYM Bipolynomial coefficient matrix to symbolic bipolynomial.
%    F = bipoly2sym(P) creates the symbolic bipolynomial expression for the
%    matrix of coefficient P. The bipolynomials variables are x and y.
%    Note: This syntax does not create the symbolic variables x and y in 
%    the MATLAB® Workspace.
%
%    F = bipoly2sym(P,var1,var2) uses symbolic variables var1 and var2 as 
%    the bipolynomial variables when creating the symbolic bipolynomial 
%    expression F from the matrix of coefficients F.
%    
%    See also poly2sym, bipolyval, bipolyder 
%
%    Detailed help, with examples, available online at:   
%    http://u.osu.edu/kubatko.3/codes_and_software/polytools/bipoly2sym/
%

%% Validata input

vC = @(x)validateattributes(x,{'numeric'},{'2d'});
ip = inputParser;
ip.addRequired('C',vC);
ip.addOptional('var1',sym('x')); ip.addOptional('var2',sym('y'));
ip.parse(C,varargin{:});
ip.Results; var1 = ip.Results.var1;  var2 = ip.Results.var2;

%% Construct the symbolic expression

n = size(C,1)-1; P = 0*var1;
for j = 0:n
    p = poly2sym(C(j+1,:),var1);
    P = P + p*var2^(n-j);
end
P = expand(P);

end