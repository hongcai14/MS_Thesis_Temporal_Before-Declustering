function[b] = b_calc_fun(M)
%==========================================================================
%From Ogata and Yamashina (1986). Given a set, M, of magnitudes, computes
%the b-value as estimated by the maximum likelihood method. 
%==========================================================================

N = length(M);
M_0 = min(M);

b = N*log10(exp(1))/sum(M - M_0);

end