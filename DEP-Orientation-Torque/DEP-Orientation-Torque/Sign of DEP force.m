clear
clc
if ~exist('numeric', 'var')
    [numeric, txt, raw] ...
        = xlsread('1.xlsx');
    
    e1 = numeric(:,1);
    e2 = numeric(:,2);
    r1 = numeric(:,3);
    r2 = numeric(:,4);
  %  w= numeric(:,5);
end

for j=1:5
    w(j)=10^(j);
w(j)=2*pi*w(j);

ep=e1-i*r1/w(j);
em=e2-i*r2/w(j);
fcm=(ep-em)/(ep+2*em);

F(j)=real(fcm);
end
plot (w,F)