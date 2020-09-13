clear all; close all

%--------------------------------------------------------------------------
%
%  generate_1D_input.m
%
%  Generates an input file for 1D model problem (requires a
%  mesh file and the matlab script read_1D_mesh.m to run).
%
%--------------------------------------------------------------------------
 
% Read in a 1D mesh

read_1D_mesh;

% Compute the midpoint coordinate of each element

x = zeros(nElems,1);
for j = 1:nElems
    nodelist = MESH.ConnectivityList(j,:)';
    x(j) = (MESH.Points(nodelist(2)) + MESH.Points(nodelist(1)))/2;
end

% Input problem name, k(x), b(x), and f(x)

probid = 'Problem name:'; 
kofx   = 'k(x) = ';
bofx   = 'b(x) = ';
fofx   = 'f(x) = ';

Input  = {inputdlg({probid,kofx,bofx,fofx},'Problem Data',1)};
probid = Input{1}{1};
kofx   = Input{1}{2};
bofx   = Input{1}{3};
fofx   = Input{1}{4};

% Initialize and evaluate k(x), b(x), and f(x) at element midpoints

k = ones(nElems,1); k = eval(kofx).*k;
b = ones(nElems,1); b = eval(bofx).*b;
f = ones(nElems,1); f = eval(fofx).*f;

% Input boundary condition data

nbc1 = length(boundaryNodes('Dirichlet'));
nbc2 = length(boundaryNodes('Neumann'));
NODEBC1 = boundaryNodes('Dirichlet');
NODEBC2 = boundaryNodes('Neumann');
if (nbc1 == 2)
    VBCL = 'Left end Dirichlet boundary condition';
    VBCR = 'Right end Dirichlet boundary condition';
    Input   = {inputdlg({VBCL,VBCR},'Boundary Condition Data',1)};
    VBC1(1) = str2double(Input{1}{1});
    VBC1(2) = str2double(Input{1}{2});
elseif (nbc2 == 2)
    VBCL = 'Left end Neumann boundary condition';
    VBCR = 'Right end Neumann boundary condition';
    Input   = {inputdlg({VBCL,VBCR},'Boundary Condition Data',1)};
    VBC2(1) = str2double(Input{1}{1});
    VBC2(2) = str2double(Input{1}{2});  
elseif (NODEBC1(1) == 1)
    VBCL = 'Left end Dirichlet boundary condition';
    VBCR = 'Right end Neumann boundary condition';
    Input   = {inputdlg({VBCL,VBCR},'Boundary Condition Data',1)};
    VBC1(1) = str2double(Input{1}{1});
    VBC2(1) = str2double(Input{1}{2});
elseif (NODEBC2(1) == 1)
    VBCL = 'Left end Neumann boundary condition';
    VBCR = 'Right end Dirichlet boundary condition';
    Input   = {inputdlg({VBCL,VBCR},'Boundary Condition Data',1)};
    VBC2(1) = str2double(Input{1}{1});
    VBC1(1) = str2double(Input{1}{2});

end

% Open input file

fid = fopen('input.1d','w');

% Write out title of input file

fprintf(fid,'%s \n',probid);

% Write out k(x), b(x), and f(x) for each element

for j = 1:nElems
    fprintf(fid,'%g %.14g %.14g %.14g \n',[j, k(j), b(j), f(j)]);
end

% Write out boundary data for Dirichlet (type 1) BCs

for i = 1:nbc1
    fprintf(fid,'%g %.14g \n',[NODEBC1(i), VBC1(i)]);
end

% Write out boundary data for Neumann (type 2) BCs

for i = 1:nbc2
    fprintf(fid,'%g %.14g \n',[NODEBC2(i), VBC2(i)]);
end

% Close file

fclose(fid);
clear all;
disp('Input file generated successfully!')