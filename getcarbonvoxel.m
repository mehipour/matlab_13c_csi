function [X Y] = getcarbonvoxel(c_img)
% syntax: [X Y] = getcarbonvoxel(c_img)
% function created by Mehrdad Pourfathi, on 9/114/2016
% this function requires an image as an input

[Nxc Nyc] = size(c_img); % size of the spectroscopic carbon image


fprintf('Select the desired spetra...\n')
fprintf('click on the next spectrum or say "done" if finished\n')

% initialize variables.
X = [];
Y = [];
x = 1;
y = 1;
I = ones(10,1); % vector to draw lines around the selected spectra
hold on;

% run until a point outside the grid is clicked.
while(and(and(x>0,y>0),and(x<Nxc,y<Nyc)))
    % input from the mouse
    [x,y] = ginput(1);
    % take the grid shift into account. 
    Y = [Y round(y)];
    X = [X round(x)];
    xl = linspace(round(x)-0.5,round(x)+0.5,length(I));
    yl = linspace(round(y)-0.5,round(y)+0.5,length(I));
    plot(xl(1)*I,yl,'g');
    plot(xl(end)*I,yl,'g');
    plot(xl,yl(1)*I,'g');
    plot(xl,yl(end)*I,'g');
end

X = X(1:end-1);
Y = Y(1:end-1);



