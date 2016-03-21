

function [zmpx zmpy]= ZMPAPPROX(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,t)

% coffx =[T0X 0 (2*(-1)^(n + 1)*(LX - T0))/(pi*n);LX 0 0;-(LX - T1X*t2)/(t2 - 1) 0 (2*(-1)^(n + 1)*tf*(LX - T1X))/(pi*n*(t2 - 1))]
% coffy =[T0Y 0 (2*(-1)^(n + 1)*(LY - T0))/(pi*n);LY 0 0;-(LY - T1Y*t2)/(t2 - 1) 0 (2*(-1)^(n + 1)*tf*(LY - T1Y))/(pi*n*(t2 - 1))]



% [                                    L/2 + T0/2, 0,              ((-1)^(n + 1)*(L - T0))/(pi*n)]
% [                                             L, 0,                                           0]
% [ L/2 + T1/2 - ((L - T1)*(tf + 1))/(2*(t2 - 1)), 0, ((-1)^n*(L - T1)*(t2 - tf))/(pi*n*(t2 - 1))]
%
%



percision=3;

sumx=0;
sumy=0;
%
%
% for n=1:percision
%
%     [coffx coffy]= calcaCoff(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,n,1);
%
%     sumx=sumx+coffx(2)*cos(2*n*pi*(t-(tf/2))/tf)+coffx(3)*sin(2*n*pi*(t-(tf/2))/tf);
%     sumy=sumy+coffy(2)*cos(2*n*pi*(t-(tf/2))/tf)+coffy(3)*sin(2*n*pi*(t-(tf/2))/tf);
%
%     end
%
%
%     a0x=coffx(1);
%     a0y=coffy(1);
%
%     zmpx=a0x+sumx;
%     zmpy=a0y+sumy;
%
%
%     return






if(t>=t0 && t<t1)
      
    for n=1:percision
        
        [coffx coffy]= calcaCoff(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,n,1);
        
        %     sumx=sumx+sinc(n*pi/(32))*(coffx(2)*cos(2*n*pi*(t-(t1/2))/t1)+coffx(3)*sin(2*n*pi*(t-(t1/2))/t1));
        % %     sumy=sumy+sinc(n*pi/(32))*(coffy(2)*cos(2*n*pi*(t-(t1/2))/t1)+coffy(3)*sin(2*n*pi*(t-(t1/2))/t1));
        % f1=T0+((L-T0)/(t1))*abs(t);  %L=t1 shif=0
        %
        %
        % f2=L % L=(t2-t1)/2 shift=(t1-t2)/2
        %
        % %zmpx=supportX+((torso1X-supportX)/(tf-t2))*(-1*abs(t-tf)+tf-t2);
        % f3=L+((T1-L)/(tf-t2))*(-1*abs(t)+tf-t2); %L=tf-t2 shift=tf
        
        
        sumx=sumx+(coffx(2)*cos(n*pi*t/t1)+coffx(3)*sin(n*pi*t/t1));
        sumy=sumy+(coffy(2)*cos(n*pi*t/t1)+coffy(3)*sin(n*pi*t/t1));
    end
    
    
    a0x=coffx(1)/2;
    a0y=coffy(1)/2;
    
    zmpx=a0x+sumx;
    zmpy=a0y+sumy;
    return
end

if(t>=t1 && t<t2)
    
    sumx=0;
    sumy=0;
    for n=1:percision
        
        [coffx coffy]= calcaCoff(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,n,2);
        
        %     sumx=sumx+sinc(n*pi/(32))*(coffx(2)*cos(2*n*pi*(t-((t1+t2)/2))/(t2-t1))+coffx(3)*sin(2*n*pi*(t-((t1+t2)/2))/(t2-t1)));
        %     sumy=sumy+sinc(n*pi/(32))*(coffy(2)*cos(2*n*pi*(t-((t1+t2)/2))/(t2-t1))+coffy(3)*sin(2*n*pi*(t-((t1+t2)/2))/(t2-t1)));
        %
        sumx=sumx+(coffx(2)*cos(2*n*pi*(t-((t1-t2)/2))/(t2-t1))+coffx(3)*sin(2*n*pi*(t-((t1-t2)/2))/(t2-t1)));
        sumy=sumy+(coffy(2)*cos(2*n*pi*(t-((t1-t2)/2))/(t2-t1))+coffy(3)*sin(2*n*pi*(t-((t1-t2)/2))/(t2-t1)));
    end
    
    a0x=coffx(1)/2;
    a0y=coffy(1)/2;
    
    zmpx=a0x+sumx;
    zmpy=a0y+sumy;
    
    return
end

if(t>= t2 && t < tf)
    
    sumx=0;
    sumy=0;
    for n=1:percision
        
        [coffx coffy]= calcaCoff(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,n,3);
        
        %     sumx=sumx+sinc(n*pi/(32))*(coffx(2)*cos(2*n*pi*(t-((t2+tf)/2))/(tf-t2))+coffx(3)*sin(2*n*pi*(t-((t2+tf)/2))/(tf-t2)));
        %     sumy=sumy+sinc(n*pi/(32))*(coffy(2)*cos(2*n*pi*(t-((t2+tf)/2))/(tf-t2))+coffy(3)*sin(2*n*pi*(t-((t2+tf)/2))/(tf-t2)));
        %
        sumx=sumx+(coffx(2)*cos(n*pi*(t-t2)/(tf-t2))+coffx(3)*sin(n*pi*(t-tf)/((tf-t2))));
        sumy=sumy+(coffy(2)*cos(n*pi*(t-t2)/(tf-t2))+coffy(3)*sin(n*pi*(t-tf)/((tf-t2))));
    end
    
    %      a0x=coffx(1);
    %     a0y=coffy(1);
    
    a0x=coffx(1)/2;
    a0y=coffy(1)/2;
    
    
    zmpx=a0x+sumx;
    zmpy=a0y+sumy;
    return
end

end

%w=[x0-A01 A02-A01-A11*(t1-t0) A03-A02-A12*(t2-t1) A12-A11 A13-A12 xf-A03-A13*(tf-t2)]


function [coffx coffy]= calcaCoff(T0X,T0Y,LX,LY,T1X,T1Y,t0,t1,t2,tf,n,index)

%T0X;T0Y;LX;LY;T1X;T1Y;t0;t1;t2;tf;n;index;


%     coffx=[(LX*t2 - LX*t1 + LX*tf + T0X*t1 - T1X*t2 + T1X*tf)/(2*tf), -(tf*(LX*t1*cos((pi*n*(2*t2 - tf))/tf) - LX*t2*cos((pi*n*(2*t1 - tf))/tf) + LX*tf*cos((pi*n*(2*t1 - tf))/tf) + T0X*t2*cos((pi*n*(2*t1 - tf))/tf) - T1X*t1*cos((pi*n*(2*t2 - tf))/tf) - T0X*tf*cos((pi*n*(2*t1 - tf))/tf) - (-1)^n*LX*t1 + (-1)^n*LX*t2 - (-1)^n*LX*tf - (-1)^n*T0X*t2 + (-1)^n*T1X*t1 + (-1)^n*T0X*tf))/(2*pi^2*n^2*t1*(t2 - tf)), -(LX*tf^2*sin((pi*n*(2*t1 - tf))/tf) - T0X*tf^2*sin((pi*n*(2*t1 - tf))/tf) + T0X*t2*tf*sin((pi*n*(2*t1 - tf))/tf) - T1X*t1*tf*sin((pi*n*(2*t2 - tf))/tf) + LX*t1*tf*sin((pi*n*(2*t2 - tf))/tf) - LX*t2*tf*sin((pi*n*(2*t1 - tf))/tf) - 2*pi*(-1)^n*T0X*n*t1*t2 + 2*pi*(-1)^n*T1X*n*t1*t2 + 2*pi*(-1)^n*T0X*n*t1*tf - 2*pi*(-1)^n*T1X*n*t1*tf)/(2*pi^2*n^2*t1*(t2 - tf))];
%     coffy=[(LY*t2 - LY*t1 + LY*tf + T0Y*t1 - T1Y*t2 + T1Y*tf)/(2*tf), -(tf*(LY*t1*cos((pi*n*(2*t2 - tf))/tf) - LY*t2*cos((pi*n*(2*t1 - tf))/tf) + LY*tf*cos((pi*n*(2*t1 - tf))/tf) + T0Y*t2*cos((pi*n*(2*t1 - tf))/tf) - T1Y*t1*cos((pi*n*(2*t2 - tf))/tf) - T0Y*tf*cos((pi*n*(2*t1 - tf))/tf) - (-1)^n*LY*t1 + (-1)^n*LY*t2 - (-1)^n*LY*tf - (-1)^n*T0Y*t2 + (-1)^n*T1Y*t1 + (-1)^n*T0Y*tf))/(2*pi^2*n^2*t1*(t2 - tf)), -(LY*tf^2*sin((pi*n*(2*t1 - tf))/tf) - T0Y*tf^2*sin((pi*n*(2*t1 - tf))/tf) + T0Y*t2*tf*sin((pi*n*(2*t1 - tf))/tf) - T1Y*t1*tf*sin((pi*n*(2*t2 - tf))/tf) + LY*t1*tf*sin((pi*n*(2*t2 - tf))/tf) - LY*t2*tf*sin((pi*n*(2*t1 - tf))/tf) - 2*pi*(-1)^n*T0Y*n*t1*t2 + 2*pi*(-1)^n*T1Y*n*t1*t2 + 2*pi*(-1)^n*T0Y*n*t1*tf - 2*pi*(-1)^n*T1Y*n*t1*tf)/(2*pi^2*n^2*t1*(t2 - tf))];
%     return;

if (index==1)
    
    coffx=[LX + T0X  -(4*sin((pi*n)/2)^2*(LX - T0X))/(pi^2*n^2)  0];
    coffy=[LY + T0Y  -(4*sin((pi*n)/2)^2*(LY - T0Y))/(pi^2*n^2)  0];
    
    %         coffx=[LX/2+T0X/2 0 ((-1)^(n + 1)*(LX - T0X))/(pi*n)];
    %         coffy=[LY/2+T0Y/2 0 ((-1)^(n + 1)*(LY - T0Y))/(pi*n)];
    return
    
end

if (index==2)
    
    coffx=[2*LX 0 0];
    coffy=[2*LY 0 0];
    return
end
if (index==3)
    
    coffx=[LX + T1X    2*(LX - T1X)*((-1)^(n+1) + 1)/(pi^2*n^2)   0];
    coffy=[LY + T1Y    2*(LY - T1Y)*((-1)^(n+1) + 1)/(pi^2*n^2)   0];
    %         coffx=[LX/2 + T1X/2   0       ((-1)^n*(LX - T1X))/(pi*n)];
    %         coffy=[LY/2 + T1Y/2   0       ((-1)^n*(LY - T1Y))/(pi*n)];
    return
end

end



%
% [L + T0,  -(4*sin((pi*n)/2)^2*(L - T0))/(pi^2*n^2), 0]
% [ 2*L, 0, 0]
% [ L + T1, 2*(L - T1)*((-1)^(n+1) + 1)/(pi^2*n^2), 0]

%(t2/2 - tf/2)*(t2 - tf)*(L + T1)
% -(2*(L - T1)*((-1)^n*sign(t2 - tf) + 1))/(pi^2*n^2)])
% [        (t1^2*(L + T0))/2,            -(4*sin((pi*n)/2)^2*(L - T0))/(pi^2*n^2), 0]
% [                        L,                                                   0, 0]
% [ ((t2 - tf)^2*(L + T1))/2, -(2*(L - T1)*((-1)^n*sign(t2 - tf) + 1))/(pi^2*n^2), 0]


%
%
% [                                                                                       (t1^2*(L + T0))/2,                                                                                      -(4*sin((pi*n)/2)^2*(L - T0))/(pi^2*n^2),                                                                                      -(4*sin((pi*n)/2)^2*(L - T0))/(pi^2*n^2)]
% [                                                                                                       L,                                                                                                                             0,                                                                                                                             0]
% [ piecewise([tf < t2, -(t2/2 - tf/2)*(L - 3*T1)*(t2 - tf)], [t2 <= tf, (t2/2 - tf/2)*(t2 - tf)*(L + T1)]), piecewise([tf < t2, ((-1)^(n + 1)*(2*L - 2*T1))/(pi^2*n^2)], [t2 <= tf, -(2*(L - T1)*((-1)^n*sign(t2 - tf) + 1))/(pi^2*n^2)]), piecewise([tf < t2, ((-1)^(n + 1)*(2*L - 2*T1))/(pi^2*n^2)], [t2 <= tf, -(2*(L - T1)*((-1)^n*sign(t2 - tf) + 1))/(pi^2*n^2)])]



% [ L/2 + T0/2, 0, ((-1)^(n + 1)*(L - T0))/(pi*n)]
% [          L, 0,                              0]
% [ L/2 + T1/2, 0,       ((-1)^n*(L - T1))/(pi*n)]

% [                           L/2 + T0/2, 0, ((-1)^(n + 1)*(L - T0))/(pi*n)]
% [                                    L, 0,                              0]
% [ L/2 + T1/2 - (tf*(L - T1))/(t2 - tf), 0,       ((-1)^n*(L - T1))/(pi*n)]

