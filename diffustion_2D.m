%% 2D steady conduction in a plate with heat generation at the center and ambient temperature at all sides
clear
clc
tic

m = input("Enter the number of elements in one direction: "); % taking same no. of elements in both directions
dx = 1/m;
dx2 = dx^2;
a = ones(1,m)*4;
b = ones(1,m)*-1;
b(1) = -2;
b(m) = 0;
c = ones(1,m)*-1;
c(1) = 0;
theta = zeros(m*(m+1),1);
d = ones(1,m)*dx2;

[T,x] = LineByLineTDMAfunc(a,b,c,d,m);

axis('equal')
hold on
X = linspace(0,1,m+1);
Y = linspace(0,1,m+1);
surface(X,Y,T)

X = linspace(0,-1,m+1);
Y = linspace(0,1,m+1);
surface(X,Y,T)

X = linspace(0,1,m+1);
Y = linspace(0,-1,m+1);
surface(X,Y,T)

X = linspace(0,-1,m+1);
Y = linspace(0,-1,m+1);
surface(X,Y,T)
xlabel('x/L')
ylabel('y/L')
zlabel('Temperature [°C]')
hold off
toc

