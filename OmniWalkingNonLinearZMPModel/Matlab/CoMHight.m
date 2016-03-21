
function [z d2z]=CoMhight(t,period)

z=0.22+0.05*sin(2*pi*t/period);

d2z=0.05*(-1*2*pi*2*pi/period*period)*sin(2*pi*t/period);

 
end