clear;
clc;

% ask the user to enter grades in a vector
g = input('Please enter grades in a vector: ');

% set up counters for letter grades
a = 0;
b = 0;
c = 0;
d = 0;
f = 0;

for x = g
    if x>=90
        a = a+1;
    elseif 80<=x & x<90
        b = b+1;
    elseif 70<=x & x<80
        c = c+1;
    elseif 60<=x & x<70
        d = d+1;
    elseif x<60
        f = f+1;
    end
end

% calculate percentages
if length(g)>0
    aP = a/length(g);
    bP = b/length(g);
    cP = c/length(g);
    dP = d/length(g);
    fP = f/length(g);
    disp(['A grade percentage is ', num2str(aP*100), '%']);
    disp(['B grade percentage is ', num2str(bP*100), '%']);
    disp(['C grade percentage is ', num2str(cP*100), '%']);
    disp(['D grade percentage is ', num2str(dP*100), '%']);
    disp(['F grade percentage is ', num2str(fP*100), '%']);
else
    disp('There is no grade entered.');
end
        