function [comx comy]= FourierCoM(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,t)


w01=pi/t1;
w02=0;
w03=pi/(tf-t2);

wn=sqrt(9.8/0.22);

sumx=0;
sumy=0;

m=3;

if(t>=0 && t<t1)
    
    for i=1:m
        an1=a(1,i,T0X,LX,T1X,t1,t2,tf);
        sumx=sumx+an1*cos(i*w01*t);
        an1=a(1,i,T0Y,LY,T1Y,t1,t2,tf);
        sumy=sumy+an1*cos(i*w01*t);
        
    end
    
    comCoff=comCoffCalc(T0X,LX,T1X,t1,t2,tf);
    n11=comCoff(1);
    n21=comCoff(2);
    a01=a(1,0,T0X,LX,T1X,t1,t2,tf);
    comx=n11*cosh(wn*t)+n21*sinh(wn*t)+a01/2+sumx;
    
    comCoff=comCoffCalc(T0Y,LY,T1Y,t1,t2,tf);
    n11=comCoff(1);
    n21=comCoff(2);
    a01=a(1,0,T0Y,LY,T1Y,t1,t2,tf);
    comy=n11*cosh(wn*t)+n21*sinh(wn*t)+a01/2+sumy;
    
    return
end


if(t>=t1 && t<t2)
    
    
    comCoff=comCoffCalc(T0X,LX,T1X,t1,t2,tf);
    n12=comCoff(3);
    n22=comCoff(4);
    a02=a(2,0,T0X,LX,T1X,t1,t2,tf);
    comx=n12*cosh(wn*(t-t1))+n22*sinh(wn*(t-t1))+a02/2;
    
    comCoff=comCoffCalc(T0Y,LY,T1Y,t1,t2,tf);
    n12=comCoff(3);
    n22=comCoff(4);
    a02=a(2,0,T0Y,LY,T1Y,t1,t2,tf);
    comy=n12*cosh(wn*(t-t1))+n22*sinh(wn*(t-t1))+a02/2;
    
    return
end



if(t>=t2 && t<tf)
    
    for i=1:m
        an3=a(3,i,T0X,LX,T1X,t1,t2,tf);
        sumx=sumx+an3*cos(i*w03*(t-t2));
        
        an3=a(3,i,T0Y,LY,T1Y,t1,t2,tf);
        sumy=sumy+an3*cos(i*w03*(t-t2));
    end
    
    comCoff=comCoffCalc(T0X,LX,T1X,t1,t2,tf);
    n13=comCoff(5);
    n23=comCoff(6);
    
    a03=a(3,0,T0X,LX,T1X,t1,t2,tf);
    comx=n13*cosh(wn*(t-t2))+n23*sinh(wn*(t-t2))+a03/2+sumx;
    
    
    comCoff=comCoffCalc(T0Y,LY,T1Y,t1,t2,tf);
    n13=comCoff(5);
    n23=comCoff(6);
    
    a03=a(3,0,T0Y,LY,T1Y,t1,t2,tf);
    comy=n13*cosh(wn*(t-t2))+n23*sinh(wn*(t-t2))+a03/2+sumy;
    
    return
end

end




function comCoff=comCoffCalc(T0,L,T1,t1,t2,tf)


w01=pi/t1;
w02=0;
w03=pi/(tf-t2);

wn=sqrt(9.8/0.22);

s1=s(1,T0,L,T1,t1,t2,tf);
s2=s(2,T0,L,T1,t1,t2,tf);
s3=s(3,T0,L,T1,t1,t2,tf);
s4=s(4,T0,L,T1,t1,t2,tf);
s5=s(5,T0,L,T1,t1,t2,tf);
s6=s(6,T0,L,T1,t1,t2,tf);

comCoff=[s1;
    (s6*wn - s4*sinh(wn*(t1 - tf)) + s2*wn*cosh(wn*(t1 - tf)) + s3*wn*cosh(wn*(t2 - tf)) - s1*wn*cosh(tf*wn))/(wn*sinh(tf*wn));
    (s4*cosh(tf*wn) - s4*cosh(wn*(2*t1 - tf)) + 2*s6*wn*sinh(t1*wn) - s2*wn*sinh(tf*wn) - 2*s1*wn*sinh(wn*(t1 - tf)) + s2*wn*sinh(wn*(2*t1 - tf)) + s3*wn*sinh(wn*(t1 + t2 - tf)) + s3*wn*sinh(wn*(t1 - t2 + tf)))/(2*wn*sinh(tf*wn));
    (s2*wn*cosh(wn*(2*t1 - tf)) - s4*sinh(tf*wn) - 2*s1*wn*cosh(wn*(t1 - tf)) - s4*sinh(wn*(2*t1 - tf)) + s3*wn*cosh(wn*(t1 + t2 - tf)) + s3*wn*cosh(wn*(t1 - t2 + tf)) + 2*s6*wn*cosh(t1*wn) + s2*wn*cosh(tf*wn))/(2*wn*sinh(tf*wn));
    -(s4*cosh(wn*(t1 + t2 - tf)) - s4*cosh(wn*(t1 - t2 + tf)) - 2*s6*wn*sinh(t2*wn) + s3*wn*sinh(tf*wn) + 2*s1*wn*sinh(wn*(t2 - tf)) - s3*wn*sinh(wn*(2*t2 - tf)) - s2*wn*sinh(wn*(t1 + t2 - tf)) + s2*wn*sinh(wn*(t1 - t2 + tf)))/(2*wn*sinh(tf*wn));
    (s3*wn*cosh(wn*(2*t2 - tf)) - s4*sinh(wn*(t1 - t2 + tf)) - 2*s1*wn*cosh(wn*(t2 - tf)) - s4*sinh(wn*(t1 + t2 - tf)) + s2*wn*cosh(wn*(t1 + t2 - tf)) + s2*wn*cosh(wn*(t1 - t2 + tf)) + 2*s6*wn*cosh(t2*wn) + s3*wn*cosh(tf*wn))/(2*wn*sinh(tf*wn))];



end

function solution=s(s,T0,L,T1,t1,t2,tf)


sum=0;
m=3;

CoMhight = 0.22;
w01=pi/t1;
w02=0;
w03=pi/(tf-t2);

wn=sqrt(9.8/CoMhight);


if(s==1)
    
    for i=1:m
        sum=sum+a(1,i,T0,L,T1,t1,t2,tf);
    end
    
    solution=T0-a(1,0,T0,L,T1,t1,t2,tf)/2-sum;
    
    
end


if(s==2)
    
    for i=1:m
        sum=sum+a(1,i,T0,L,T1,t1,t2,tf)*cos(w01*i*t1);
    end
    
    solution=a(2,0,T0,L,T1,t1,t2,tf)/2-a(1,0,T0,L,T1,t1,t2,tf)/2-sum;
end



if(s==3)
    
    for i=1:m
        sum=sum+a(3,i,T0,L,T1,t1,t2,tf);
    end
    
    solution=a(3,0,T0,L,T1,t1,t2,tf)/2-a(2,0,T0,L,T1,t1,t2,tf)/2+sum;
end


if(s==4)
    
    for i=1:m
        sum=sum+a(1,i,T0,L,T1,t1,t2,tf)*w01*i*sin(w01*i*t1);
    end
    
    solution=sum;
end

if(s==5)
    
    
    solution=0;
end

if(s==6)
    
    for i=1:m
        sum=sum+a(3,i,T0,L,T1,t1,t2,tf)*cos(w03*i*(tf-t2));
    end
    
    solution=T1-a(3,0,T0,L,T1,t1,t2,tf)/2-sum;
end



end


%[LX + T0X  -(4*sin((pi*n)/2)^2*(LX - T0X))/(pi^2*n^2)  0]
function an=a(n,i,T0,L,T1,t1,t2,tf)


w01=pi/t1;
w02=0;
w03=pi/(tf-t2);

wn=sqrt(9.8/0.22);

if(n==1)
    
    if(i==0)
        an=L+T0;
        return
    end
    
    an=-(4*sin((pi*i)/2)^2*(L - T0))/((pi^2*i^2)*(1+((i*w01*(1/wn))^2)));
    return;
end
%[2*LX 0 0]
if(n==2)
    an=2*L;
    return;
end
%[LX + T1X    2*(LX - T1X)*((-1)^(n+1) + 1)/(pi^2*n^2)   0]
if(n==3)
    
    if(i==0)
        an=L+T1;
        return
    end
    an=2*(L - T1)*((-1)^(i+1) + 1)/((pi^2*i^2)*(1+((i*w03*(1/wn))^2)));
    return;
end

end