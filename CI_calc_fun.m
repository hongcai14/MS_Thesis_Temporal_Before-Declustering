function[CI] = CI_calc_fun(X,s)
%==========================================================================
% 
%   Generates a column vector of correlation integral, C(s), values from a
%   matrix, X, of earthquake location coordinates (Grassberger and
%   Procaccia, 1983)
%
%   Requires the following function:
%    (1) Featherstone.m
%
%   Input:
%    X := a matrix, where each row represents an earthquake, where  
%       column 1 corresponds to latitude in decimal degrees,
%       column 2 corresponds to longitude in decimal degrees, and
%       column 3 corresponds to depth in km (negative if "above ground")
%    s := a row vector of length scales, s, in km 
%
%   Output:
%    CI := a column vector of C(s) values, where the index of each C(s)
%    value and its corresponding s value match
%
%==========================================================================

CI = zeros(length(s),1);

if size(X,2) == 2
    %^earthquake epicenters
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
    %^earthquake hypocenters
    
    [x,y,z] = Featherstone(X,1,2,3);
    X = [x y z];
    %converts to Cartesian coordinates
    
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