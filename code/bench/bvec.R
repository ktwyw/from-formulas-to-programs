n<-1e7; t0<-Sys.time(); x<-seq(0,pi,length.out=n+1); y<-sin(x); s<-pi/n*(sum(y)-0.5*(y[1]+y[n+1]))
cat(sprintf("%.4f %.12f\n", as.numeric(Sys.time()-t0, units="secs"), s))
