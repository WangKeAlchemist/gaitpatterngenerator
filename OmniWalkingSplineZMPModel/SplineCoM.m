function [comx comy]= SplineCoM(torso0X,torso0Y,supportX,supportY,torso1X,torso1Y,t0,t1,t2,tf,t)

CoMZ = 0.22;
Tc=sqrt(9.8/CoMZ);


cx=[0;
    (sinh(Tc*(t1 - tf))*(supportX - torso0X))/(Tc*t1*sinh(Tc*tf)) - (sinh(Tc*(t2 - tf))*(supportX - torso1X))/(Tc*sinh(Tc*tf)*(t2 - tf));
    ((cosh(Tc*(2*t1 - tf)) - cosh(Tc*tf))*(supportX - torso0X))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
    ((sinh(Tc*(2*t1 - tf)) + sinh(Tc*tf))*(supportX - torso0X))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(t1 + t2 - tf)) - sinh(Tc*(t1 - t2 + tf)))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
    ((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportX - torso0X))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(2*t2 - tf)) - cosh(Tc*tf))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
    ((supportX - torso0X)*(sinh(Tc*(t1 + t2 - tf)) + sinh(Tc*(t1 - t2 + tf))))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(2*t2 - tf)) + sinh(Tc*tf))*(supportX - torso1X))/(2*Tc*sinh(Tc*tf)*(t2 - tf))];

cy=[0;
    (sinh(Tc*(t1 - tf))*(supportY - torso0Y))/(Tc*t1*sinh(Tc*tf)) - (sinh(Tc*(t2 - tf))*(supportY - torso1Y))/(Tc*sinh(Tc*tf)*(t2 - tf));
    ((cosh(Tc*(2*t1 - tf)) - cosh(Tc*tf))*(supportY - torso0Y))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
    ((sinh(Tc*(2*t1 - tf)) + sinh(Tc*tf))*(supportY - torso0Y))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(t1 + t2 - tf)) - sinh(Tc*(t1 - t2 + tf)))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
    ((cosh(Tc*(t1 + t2 - tf)) - cosh(Tc*(t1 - t2 + tf)))*(supportY - torso0Y))/(2*Tc*t1*sinh(Tc*tf)) - ((cosh(Tc*(2*t2 - tf)) - cosh(Tc*tf))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf));
    ((supportY - torso0Y)*(sinh(Tc*(t1 + t2 - tf)) + sinh(Tc*(t1 - t2 + tf))))/(2*Tc*t1*sinh(Tc*tf)) - ((sinh(Tc*(2*t2 - tf)) + sinh(Tc*tf))*(supportY - torso1Y))/(2*Tc*sinh(Tc*tf)*(t2 - tf))];



if(t>=t0 && t<t1)
    
    comx=torso0X+((supportX-torso0X)/(t1-t0))*(t-t0)+cx(1)*cosh(Tc*t)+cx(2)*sinh(Tc*t);
    comy=torso0Y+((supportY-torso0Y)/(t1-t0))*(t-t0)+cy(1)*cosh(Tc*t)+cy(2)*sinh(Tc*t);
    return
end

if(t>=t1 && t<t2)
    

    comx=supportX+cx(3)*cosh(Tc*(t-t1))+cx(4)*sinh(Tc*(t-t1));
    comy=supportY+cy(3)*cosh(Tc*(t-t1))+cy(4)*sinh(Tc*(t-t1));
    
    return
end

if(t>= t2 && t < tf)
    
    comx=supportX+((torso1X-supportX)/(tf-t2))*(t-t2)+cx(5)*cosh(Tc*(t-t2))+cx(6)*sinh(Tc*(t-t2));
    comy=supportY+((torso1Y-supportY)/(tf-t2))*(t-t2)+cy(5)*cosh(Tc*(t-t2))+cy(6)*sinh(Tc*(t-t2));
    return
end


end
