%% 2D steady conduction in a plate with heat generation at the center and ambient temperature at all sides
clear
clc
tic
k = 60.5;             % thermal conductivity in W/mK
q = 1000;             % Heat generation per unit volume W/cubic m 
L = 1;                % Half of total edge Length, taken equal lengths in both directions

% ---------------Grid generation---------------
m = input("Enter the number of elements in one direction: "); % taking same no. of elements in both directions
dx = 1/m;
dx2 = dx^2;

%---------------Discretization----------------
a = ones(1,m)*4;
b = ones(1,m)*-1;
b(1) = -2;
b(m) = 0;
c = ones(1,m)*-1;
c(1) = 0;
d = ones(1,m)*dx2;

%----------------Processing-------------------
theta = LineByLineTDMAfunc(a,b,c,d,m);
theta = theta*q*L^2/k + 25;             % surrounding temperature is 25 celsius
theta = transpose(theta);
theta = reshape(theta,m,m+1);
T = ones(m+1)*25;
T(1:m,:) = theta;

%---------------Post processing--------------
figure;
axis('equal')
hold on
xlim([-L,L])
ylim([-L,L])
X = linspace(0,L,m+1);
Y = linspace(0,L,m+1);
surface(X,Y,T)

X = linspace(0,-L,m+1);
Y = linspace(0,L,m+1);
surface(X,Y,T)

X = linspace(0,L,m+1);
Y = linspace(0,-L,m+1);
surface(X,Y,T)

X = linspace(0,-L,m+1);
Y = linspace(0,-L,m+1);
surface(X,Y,T)
colorbar
xlabel('x')
ylabel('y')
zlabel('Temperature [°C]')
hold off

figure;
X = linspace(0,L,m+1);
Y = linspace(0,L,m+1);
colormap("hot")
contourf(X,Y,T)
colorbar;
toc



