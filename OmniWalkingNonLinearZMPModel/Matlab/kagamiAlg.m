

function [comx comy]= kagamiAlg(T0x,T0y,T1x,T1y,ZMPx,ZMPy,n,delta,zchange,dzchange)


acoff=[];
bcoff=[];
ccoff=[];
dcoff=[];


for i=2:n
    a=(-1*zchange(i))/((delta^2)*(-dzchange(i)+9.81));
    acoff=[acoff a];
end

for i=1:n-1
    a=(-1*zchange(i))/((delta^2)*(-dzchange(i)+9.81));
    ccoff=[ccoff a];
end

for i=1:n
    a=(-1*zchange(i))/((delta^2)*(-dzchange(i)+9.81));
    b=(1-2*a);
    bcoff=[bcoff b];
end
    
 
    
dx=ZMPx;
dy=ZMPy;


comx=TDMAsolver(acoff,bcoff,ccoff,dx,T0x,T1x);
comy=TDMAsolver(acoff,bcoff,ccoff,dy,T0y,T1y);


end
