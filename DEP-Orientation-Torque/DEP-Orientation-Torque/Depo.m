% syms x a b c
% f=1/(x+a^2)/sqrt((x+a^2)*(x+b^2)*(x+c^2))
% F=int(f,x,0, inf)


% int(1/(x+a^2)/sqrt((x+a^2)*(x+b^2)*(x+c^2)),x,0, 999)
%[x,y,z]=Depo(4,2,1), ????
% this file is used to calculate the depolarization factor of Lx, Ly, Lz
function [Lx,Ly,Lz]=Depo(a,b,c)
% a=40;
% b=20;
% c=10;
t=a*b*c/2;
% y=1./((x+a^2)./sqrt((x+a^2)*(x+b^2)*(x+c^2)));
Fx=@(x)t./((x+a^2).*sqrt((x+a^2).*(x+b^2).*(x+c^2)));
Lx=quad(Fx,0, 9999);

Fy=@(x)t./((x+b^2).*sqrt((x+a^2).*(x+b^2).*(x+c^2)));
Ly=quad(Fy,0, 9999);

Fz=@(x)t./((x+c^2).*sqrt((x+a^2).*(x+b^2).*(x+c^2)));
Lz=quad(Fz,0, 9999);