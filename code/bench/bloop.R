n<-1e7; h<-pi/n; s<-0; t0<-Sys.time(); for(i in 1:(n-1)) s<-s+sin(i*h); s<-h*(s+0.5*(sin(0)+sin(pi)))
cat(sprintf("%.4f %.12f\n", as.numeric(Sys.time()-t0, units="secs"), s))
