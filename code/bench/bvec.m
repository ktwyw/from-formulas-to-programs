n=1e7; tic; x=linspace(0,pi,n+1); y=sin(x); s=pi/n*(sum(y)-0.5*(y(1)+y(end))); fprintf('%.4f %.12f\n',toc,s);
