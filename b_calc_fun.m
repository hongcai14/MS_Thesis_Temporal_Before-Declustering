function[b] = b_calc_fun(M)
%==========================================================================
%
%   Computes maximum likelihood b value (Ogata and Yamashina, 1986)
%
%   Input:
%    M := vector of earthquake magnitudes 
%
%   Output:
%    b := maximum likelihood b value
%   
%==========================================================================

N = length(M);
M_0 = min(M);

b = N*log10(exp(1))/sum(M - M_0);

end
