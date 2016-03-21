function [zmpx zmpy]= SplineZMP(torso0X,torso0Y,supportX,supportY,torso1X,torso1Y,t0,t1,t2,tf,t)



if(t>=t0 && t<t1)
    
    zmpx=torso0X+((supportX-torso0X)/(t1-t0))*abs(t);
    zmpy=torso0Y+((supportY-torso0Y)/(t1-t0))*abs(t);
    return
end

if(t>=t1 && t<t2)
    
    zmpx=supportX;
    zmpy=supportY;
    
    return
end

if(t>= t2 && t < tf)
    
    
    zmpx=supportX+((torso1X-supportX)/(tf-t2))*(t-t2);
    zmpy=supportY+((torso1Y-supportY)/(tf-t2))*(t-t2);
    return
end
    zmpx=torso1X;
    zmpy=torso1Y;

end

