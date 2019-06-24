% gridshifts_c13_20170124()
% file created by Mehrdad Pourfathi on 2/18/2016

% has different grid shifts in the x and y orientations for all the c13 csi
% lung data data. 
if ll < 10
    xgridshift = 0;
    ygridshift = 0;
elseif ll < 14
    xgridshift = 0;
    ygridshift = 16;   
elseif ll < 24
    xgridshift = -4;
    ygridshift = 12;
elseif ll < 27
    xgridshift = -6;
    ygridshift = 22;  
elseif ll ==27
    xgridshift = -6;
    ygridshift = 12;  
elseif ll == 28
    xgridshift = -6;
    ygridshift = 22;  
elseif ll <32
    xgridshift = -6;
    ygridshift = 18;  
elseif ll < 35
    xgridshift = 0;
    ygridshift = 25;  
elseif ll <38
    xgridshift = 0;
    ygridshift = 16;  
elseif ll <40
    xgridshift = 0;
    ygridshift = 8;  
elseif ll <43
    xgridshift = -8;
    ygridshift = -4;  
elseif ll <44
    xgridshift = -6;
    ygridshift = 22;  
elseif ll <44
    xgridshift = 0;
    ygridshift = -6;  
elseif ll <47
    xgridshift = -2;
    ygridshift = -4;      
elseif ll <50
    xgridshift = -8;
    ygridshift = 16;  
elseif ll <51
    xgridshift = 0;
    ygridshift = 0;  
elseif ll <54
    xgridshift = 4;
    ygridshift = 20;  
elseif ll <57
    xgridshift = -4;
    ygridshift = 24; 
elseif ll <66
    xgridshift = 0;
    ygridshift = 0; 
elseif and(ll>=69,ll<=71)
    xgridshift = 3;
    ygridshift = 0;  
elseif and(ll>=73,ll<=74)
    xgridshift = 0;
    ygridshift = 0;  
elseif and(ll>=79,ll<=82)
    xgridshift = -6;
    ygridshift = 0;  
else
    xgridshift = 2;
    ygridshift = -2;  
end