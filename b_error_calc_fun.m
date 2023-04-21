function[b_error] = b_error_calc_fun(M,b)
%==========================================================================
%From Shi and Bolt (1982). Given a set, M, of magnitudes, and its
%corresponding b-value as estimated by the maximum likelihood method,
%computes the error in the b-value.
%==========================================================================

sigma_squared = sum(((M - mean(M)).^2)./(length(M)*(length(M) - 1)));

b_error = 2.30*b*b*sqrt(sigma_squared);

end