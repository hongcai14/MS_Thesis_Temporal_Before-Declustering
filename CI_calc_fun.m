function [CI] = CI_calc_fun(X,s)
%==========================================================================
% Needs the following function:
%   (1) Featherstone.
%
%   Input:
%    X := a matrix, where each row represents an earthquake; each
%    column represents latitude (dd), longitude (dd), depth (km). Number of
%    columns is either 2 (depth absent) or 3 (depth present). 
%    s := a row vector of lengthscales (km).
%
%   Output:
%    CI := a column vector of C(s)-values.
%
%==========================================================================

CI = zeros(length(s),1);

if size(X,2) == 2
    %^epicenters
    reference = referenceEllipsoid('WGS84');
    for ii = 1:length(s)
        for i = 1:size(X,1)
            
            lat1 = X(i,1);
            lon1 = X(i,2);
            
            for j = 1:size(X,1)
                
                lat2 = X(j,1);
                lon2 = X(j,2);
                
                d = distance(lat1,lon1,lat2,lon2,reference)/1000;
                
                answer = heaviside(s(ii) - d);
                CI(ii) = CI(ii) + answer;
            end
        end
    end
elseif size(X,2) == 3
    %^hypocenters
    
    [x,y,z] = Featherstone(X,1,2,3);
    X = [x y z];
    %^converts to Cartesian coordinates
    
    for ii = 1:length(s)
        for i = 1:size(X,1)
            for j = 1:size(X,1)
                answer = heaviside(s(ii) - sqrt((X(i,1) - X(j,1))^2 + ...
                    (X(i,2) - X(j,2))^2 + (X(i,3) - X(j,3))^2));
                CI(ii) = CI(ii) + answer;
            end
        end
    end
end
         
CI = (2/(size(X,1)*(size(X,1)-1)))*CI;

end