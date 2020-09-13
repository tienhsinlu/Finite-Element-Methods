function FEM1Dplot(p,nodes,nElems,U,xdp,U_exact)
if p == 1
    hold off;
    plot(nodes,U)
    hold on;
    plot(xdp,U_exact)
    legend('Nodal','Exact');
else
    hold off;
    first = 1;
    for i=1:nElems
        polyindex = first:first+p;
        polyX = nodes(polyindex);
        polyY = U(polyindex);
        poly = polyfit(polyX,polyY,p);
        x = linspace(polyX(1),polyX(end),1000);
        y = polyval(poly,x);
        pn = plot(x,y,'b');
        xlim([polyX(1) polyX(end)]);
        hold on;
        first = first+p;
    end
    pe = plot(xdp,U_exact,'r');
    xlim([nodes(1) nodes(end)]);
    legend([pn,pe],{'Nodal','Exact'});
end
end