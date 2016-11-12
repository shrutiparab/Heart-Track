function f = build_gaussian_filter(n,s,N)

x = ( (0:n-1)-(n-1)/2 )/(N-1);
f = exp( -x.^2/(2*s^2) )/(2*pi*s*s);
f = f / sum(f(:));





