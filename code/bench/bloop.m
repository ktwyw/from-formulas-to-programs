n=1e7; h=pi/n; s=0; tic; for i=1:n-1, s=s+sin(i*h); end; s=h*(s+0.5*(sin(0)+sin(pi))); fprintf('%.4f %.12f\n',toc,s);
