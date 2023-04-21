function[b_error] = b_error_calc_fun(M,b)
%==========================================================================
%
%   Computes error in maximum likelihood b value (Shi and Bolt, 1982)
%
%   Input:
%    M := vector of earthquake magnitudes
%    b := corresponding maximum likelihood b value 
%
%   Output:
%    b_error := error in maximum likelihood b value
%
%==========================================================================

sigma_squared = sum(((M - mean(M)).^2)./(length(M)*(length(M) - 1)));

b_error = 2.30*b*b*sqrt(sigma_squared);

end