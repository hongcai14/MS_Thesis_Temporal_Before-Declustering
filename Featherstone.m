function[X,Y,Z] = Featherstone(data,i,j,k)
%==========================================================================
%Conversion from Geodetic (WGS84) to Cartesian coordinates based on Gerdan
%Deakin 1999 and Featherstone 1994 (pp. 8-10)

%   data := catalogue
%   i, j, k := column # of latitude, longitude, and depth, respectively

%   X, Y, Z := Cartesian coordinates of hypocenters

%==========================================================================

a = 6378.137;
%^length of semi-major axis in km
f = 1/298.257223563;
%^flattening 

lat = data(:,i);
%^latitude in degrees
lon = data(:,j);
%^longitude in degrees
%R = sqrt(((a^2*cosd(lat)).^2 + (b^2*sind(lat)).^2)./((a*cosd(lat)).^2+(b*sind(lat)).^2));
%height of WGS84 in km at latitude lat 
h = -data(:,k);
%^height in km 

HJC = f*(2 - f);
%^in the paper, HJC = e^2 := square of the first eccentricity 
v = a./sqrt(1 - HJC*sind(lat).*sind(lat));
%^the radius of the curvature in the prime vertical plane 

X = (v+h).*cosd(lat).*cosd(lon);
Y = (v+h).*cosd(lat).*sind(lon);
Z = (v.*(1 - HJC)+h).*sind(lat);

end