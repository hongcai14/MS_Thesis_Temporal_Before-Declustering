function[error] = error_calc_fun(x,y)
%==========================================================================
%
%   Computes the error in slope of the linear least squares regression for
%   the given set of ordered pairs (x,y)
%
%   Input:
%    x := dependent variable
%    y := independent variable 
% 
%   Output:
%    error := error in slope of linear least squares regression 
%
%==========================================================================

ss_xx = sum(x.^2) - length(x)*mean(x)^2;
%^Eq. 16 (Wolfram)
ss_yy = sum(y.^2) - length(y)*mean(y)^2;
%^Eq. 19 (Wolfram)
ss_xy = sum(x.*y') - length(x)*mean(x)*mean(y);
%^Eq. 21 (Wolfram)

error = sqrt((ss_yy - ((ss_xy^2)/(ss_xx)))/(length(x) - 2));
%^Eq. 35 (Wolfram) second term 

end