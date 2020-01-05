% function [Tx,Ty,Tz]=Torque (a,b,c)
clear
clc

%defind the length of three axis
a=4;
b=2;
c=1;

%defind particle and solution property
eps_0=8.85e-12;
eps_1=30*eps_0;
eps_2=100*eps_0;
co_1=15e-6;
co_2=0;

%defind the depolarization value of three axis
[Lx,Ly,Lz]=Depo(a,b,c);

%defind electric field
Ex=1;
Ey=2;
Ez=5;

%define frequency depend complex dielectric constant

%w(i)=2*pi*f;
% em=eps_1-j*co_1/w(i);
% ep=eps_2-j*co_2/w(i);

for m=1:185
    co_1=co_1+1e-6;
    conductivity(m)=co_1;

for i=1:35
f(i)=10^(6-i*0.1);
w=2*pi*f(i);
em=eps_1-j*co_1/w;
ep=eps_2-j*co_2/w;


%defind the complex polarization factor 
Kx=(ep-em)/3/(em+(ep-em)*Lx);
Ky=(ep-em)/3/(em+(ep-em)*Ly);
Kz=(ep-em)/3/(em+(ep-em)*Lz);

%defind the torque value
t=2*pi*a*b*c*eps_1/3;
Tx(i,m)=t*(Lz-Ly)*Ey*Ez*real(Ky*Kz);
Ty(i,m)=t*(Lx-Lz)*Ex*Ez*real(Kx*Kz);
Tz(i,m)=t*(Ly-Lx)*Ey*Ex*real(Ky*Kx);


%determine the orientation
% if (Tx(i)>0 & Ty(i)>0 & Tz(i)<0) | (Tx(i)>0 & Ty(i)<0 & Tz(i)<0)
%     T(m,i)=1;
% elseif (Tx(i)>0 & Ty(i)<0 & Tz(i)>0) | (Tx(i)<0 & Ty(i)<0 & Tz(i)>0)
%     T(m,i)=90;
% else (Tx(i)<0 & Ty(i)>0 & Tz(i)>0) | (Tx(i)<0 & Ty(i)>0 & Tz(i)<0)
%     T(m,i)=4;
% end
if ((Tx(i,m)>0) && (Ty(i,m)>0) && (Tz(i,m)<0))|| (Tx(i,m)>0 && Ty(i,m)<0 && Tz(i,m)<0)
    T(i,m)=40;            %oriente b axis      
elseif ((Tx(i,m)>0) && (Ty(i,m)<0) && (Tz(i,m)>0))|| (Tx(i,m)<0 && Ty(i,m)<0 && Tz(i,m)>0)
    T(i,m)=20;            %oriente a axis
elseif ((Tx(i,m)<0) && (Ty(i,m)>0) && (Tz(i,m)>0)) || (Tx(i,m)<0 && Ty(i,m)>0 && Tz(i,m)<0)
    T(i,m)=80;            %oriente c axis
else T(i,m)=0;
end


end


end
%semilogx(f,Tx,f,Ty,f,Tz)
%contour(conductivity,f,T)

conductivity=conductivity/1e-6;

%for T low frequency and low conductivity is at top left, the top low is
%the lowest conductivity
%for M the most left column is the lowest conductivity and the frequency
%increse from top to bottom
M=T;
%M=flipud(M);
f=log10(f);
%image(conductivity,f,M);
contour(M);
set(gca,'YDir','normal');

xlabel('conductivity (uS/m)','FontSize',20)
ylabel('log frequency (Hz)','FontSize',20)
%contour(T)

