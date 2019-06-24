% gridshifts_c13_20170124()
% file created by Mehrdad Pourfathi on 2/18/2016

% has different grid shifts in the x and y orientations for all the c13 csi
% lung data data. 
if ll == 1
    xgridshift = 10;
    ygridshift = -10;
elseif ll == 2
    xgridshift = 4;
    ygridshift = -10;
else
    xgridshift = 2;
    ygridshift = -2;
end