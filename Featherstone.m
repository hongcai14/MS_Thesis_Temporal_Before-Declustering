function[X,Y,Z] = Featherstone(data,i,j,k)
%==========================================================================
%   
%   Coordinate conversion of earthquake hypocenters from Geodetic (WGS84)
%   to Cartesian coordinates (Featherstone, 1994; Gerdan and Deakin, 1999)
%
%   Input:
%    data := earthquake catalogue, where latitude and longitude are in
%    decimal degrees and depth in km (negative if "above ground")
%    i, j, k := column number of latitude, longitude, and depth,
%    respectively
%
%   Output:
%    X, Y, Z := Cartesian coordinates of earthquake hypocenters 
% 
%==========================================================================

a = 6378.137;
%^length of semi-major axis in km
f = 1/298.257223563;
%^flattening 

lat = data(:,i);
lon = data(:,j);
h = -data(:,k);
%^convert depth to height 

ff = f*(2 - f);
%^in the paper, ff = e^2 := square of the first eccentricity 
v = a./sqrt(1 - ff*sind(lat).*sind(lat));
%^the radius of the curvature in the prime vertical plane 

X = (v+h).*cosd(lat).*cosd(lon);
Y = (v+h).*cosd(lat).*sind(lon);
Z = (v.*(1 - ff)+h).*sind(lat);

end