function[D2] = D2_calc_fun(CI,s,i)
%==========================================================================
%
%   Computes the correlation dimension, D2, value for a specific range of
%   correlation integral, C(s), and length scale, s, values as specified by
%   their indices (Grassberger and Procaccia, 1983)
%
%   Input:
%    CI := a column vector of C(s) values
%    s := a row vector of length scales in km
%    i := a row vector of indices 
%
%   Output:
%    D2 := the D2 value for the set of pairs (x,y) =
%    (log10(s(i)),log10(CI(i))) calculated via least squares regression  
%
%==========================================================================

s = s';

c = polyfit(log10(s(i)),log10(CI(i)),1);

D2 = c(1);

end