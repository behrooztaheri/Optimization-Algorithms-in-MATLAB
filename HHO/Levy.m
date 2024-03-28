function LF = Levy(VarSize)
beta = 1.5 ;
sigma = ( (gamma(1+beta)*sin((pi*beta)./2) )/((gamma((1+beta)/2)).*(beta)*(2.^((beta-1)/2))) ).^(1/beta) ;
v = randn(VarSize) ;
u = randn(VarSize) ;
LF = 0.01*( (u.*sigma)./((abs(v)).^(1/beta)) ) ;
end
