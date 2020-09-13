clear all; close all

%--------------------------------------------------------------------------
%
%  generate_1D_mesh.m
%
%  Generates an input file for 1D model problem.
%
%--------------------------------------------------------------------------

A = 0;
while A==0
    meshid = 'Mesh name:'; 
    xL     = 'x-coordinate of left end of domain, xL:';
    xR     = 'x-coordinate of right end of domain, xR:';
    nelems = 'Number of elements';
    p      = 'Element type, p:';

    Input  = {inputdlg({meshid,xL,xR,nelems,p},'Mesh Data',1)};
    meshid = Input{1}{1};
    xL     = str2double(Input{1}{2});
    xR     = str2double(Input{1}{3});
    nelems = str2double(Input{1}{4});
    p      = str2double(Input{1}{5});
    
    if (xL>=xR)
        h = errordlg('Invalid entry. Please try again.','Error');
        uiwait(h);        
    elseif (nelems<=0)
        h = errordlg('Invalid entry. Please try again.','Error');
        uiwait(h);          
    elseif (p<=0)
        h = errordlg('Invalid entry. Please try again.','Error');
        uiwait(h); 
    else
        A = 1;
    end
end

BCL = questdlg('Left end BC type' ,'Boundary Data','Dirichlet','Neumann  ','Dirichlet');
BCR = questdlg('Right end BC type','Boundary Data','Dirichlet','Neumann  ','Dirichlet');
    
% Open input file

fid = fopen('mesh.1d','w');

% Write out name of mesh file    

fprintf(fid,'%s \n',meshid);

% Write out number of elements and nodes

nnodes = nelems*p + 1;
fprintf(fid,'%g %g \n',[nelems, nnodes]);

% Compute length of domain

L = abs(xR - xL);

% Create mesh

X = xL:L/nelems:xR;

% Write out element end-point coordinates to file

ii = 1;
for i = 1:nelems+1
    fprintf(fid,'%g %.14g \n',[ii, X(i)]);
    ii = ii + p;
end

% Write out element to node connectivity

ii = 1;
jj = 1+p;
for j = 1:nelems
    fprintf(fid,'%g %g %g \n',[j, ii, jj]);
    ii = jj;
    jj = ii + p;
end

% Write out BC data

if (BCL == 'Dirichlet' & BCR == 'Dirichlet')
    fprintf(fid,'%g \n',2);
    fprintf(fid,'%g \n',1);
    fprintf(fid,'%g \n',nnodes);        
    fprintf(fid,'%g \n',0);  
elseif (BCL == 'Dirichlet' & BCR == 'Neumann  ')
    fprintf(fid,'%g \n',1);
    fprintf(fid,'%g \n',1);
    fprintf(fid,'%g \n',1); 
    fprintf(fid,'%g \n',nnodes);  
elseif (BCL == 'Neumann  ' & BCR == 'Dirichlet')
    fprintf(fid,'%g \n',1);
    fprintf(fid,'%g \n',nnodes);
    fprintf(fid,'%g \n',1); 
    fprintf(fid,'%g \n',1); 
elseif (BCL == 'Neumann  ' & BCR == 'Neumann  ') 
    fprintf(fid,'%g \n',0);
    fprintf(fid,'%g \n',2);
    fprintf(fid,'%g \n',1); 
    fprintf(fid,'%g \n',nnodes);  
end

% Close file

fclose(fid);
clear all;
disp('Mesh file generated successfully!')