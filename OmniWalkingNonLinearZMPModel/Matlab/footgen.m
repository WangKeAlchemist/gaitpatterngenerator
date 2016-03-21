function [sPosx,sPosy,tPosx,tPosy]=footgen(vx , vy, vtheta, numstep)

sPosx=[ -0.055] ;
sPosy=[ 0];
thetaS=[0];

swingPosx=[ 0.055] ;
swingPosy=[ 0];
thetaSwing=[0];

tPosx=[ 0];
tPosy=[ 0];
thetaT=[0];

SisLeft=1;

%vx=0.0;
%vy=1;
%vtheta=0*pi/180;


%numstep=10;


for i=1:numstep
    
    
   % if(i>5)
   %     vx=0.5;
   %     vy=0.5;
   % end
    
    [TxNext TyNext Ttheta SxNext SyNext Sthetanext]= footcalc(tPosx(end),tPosy(end),thetaT(end),sPosx(end),sPosy(end),thetaS(end),swingPosx(end),swingPosy(end),thetaSwing(end),vx,vy,vtheta,SisLeft);
    
    
    
    swingPosx=[ swingPosx sPosx(end)] ;
    swingPosy=[ swingPosy sPosy(end)];
    thetaSwing=[thetaSwing thetaS(end)];
    
    tPosx=[tPosx TxNext];
    tPosy=[tPosy TyNext];
    thetaT=[thetaT Ttheta];
    
    sPosx=[sPosx SxNext];
    sPosy=[sPosy SyNext];
    thetaS=[thetaS Sthetanext];
    
    
    SisLeft=SisLeft*-1;
    %   if(i==3)
    %   vx=0.0;
    %   vy=0.0;
    %   end
    % % %
    % % %
    %   if(i==6)
    %   vx=0.0;
    %   vy=0.0;
    %  end
    % % %
    % % %
    %    if(i==9)
    %     vx=0.0;
    %     vy=0.0;
    %     end
    
end



%
%
% return
%
% sPosx=[-0.5 0.5];
% sPosy=[0 1];
% tPosx=[0 0];
% tPosy=[0 0.5];
%
%
%
% numstep=20;
%
% for i=1:numstep
%
% tPosx=[tPosx 0];
% tPosy=[tPosy tPosy(end)+1];
% sPosx=[sPosx sPosx(end)*-1];
% sPosy=[sPosy sPosy(end)+1];
%
% end




%
% sPosx=[0 1];
% sPosy=[0.5 -0.5];
% tPosx=[0 0.5];
% tPosy=[0 0];
%
%
% numstep=20;
%
% for i=1:numstep
%
% tPosx=[tPosx tPosx(end)+1];
% tPosy=[tPosy 0];
% sPosx=[sPosx sPosx(end)+1];
% sPosy=[sPosy sPosy(end)*-1];
%
% end

figure;
axis equal
plot(sPosx,sPosy,'sr');

hold

plot(tPosx,tPosy,'sb');
end

function [TxNext TyNext Ttheta SxNext SyNext Stheta]= footcalc(TxCurrent,TyCurrent,TthetaCurrent,SxCurrent,SyCurrent,SthetaCurrent,swingPosx,swingPosy,thetaSwing,vx,vy,vtheta,Sisleft)


MaxSwingRsupport=[ max(Sisleft*0.13,Sisleft*0.055)  0.22  0] ;%max(-Sisleft*120,0)]
MinSwingRsupport=[ min(Sisleft*0.13,Sisleft*0.055) -0.22  0] ;%min(-Sisleft*120,0)]

MaxSwingRotation=[max(Sisleft*-1*120,0)] ;
MinSwingRotation=[min(Sisleft*-1*120,0)] ;


TCurrent=[TxCurrent,TyCurrent,TthetaCurrent] ;
SCurrent=[SxCurrent,SyCurrent,SthetaCurrent] ;
Swing=[swingPosx,swingPosy,thetaSwing] ;

Step=[vx vy vtheta] ;

MaxSwingGlobalPos=poseGlobal([-1*Sisleft*0.055 0 0] ,poseGlobal(MaxSwingRsupport,SCurrent)) ;
MinSwingGlobalPos=poseGlobal([-1*Sisleft*0.055 0 0] ,poseGlobal(MinSwingRsupport,SCurrent)) ;

%  MaxSwingRotationRel


MaxTstep=poseRelative(MaxSwingGlobalPos,TCurrent) ./1.5 ;
MinTstep=poseRelative(MinSwingGlobalPos,TCurrent) ./1.5 ;


Stepx=min(max(MinTstep(1),Step(1)),MaxTstep(1)) ;
Stepy=min(max(MinTstep(2),Step(2)),MaxTstep(2)) ;
%vtheta=min(max(MinTstep(3),Step(3)),MaxTstep(3))
Steptheta=vtheta;

Step=[Stepx Stepy Steptheta] ;

TNext=poseGlobal([Step(1) Step(2) Step(3)],TCurrent);

predictedCoM=poseGlobal([1.5*Step(1) 1.5*Step(2) 2*Step(3)-(TCurrent(3)-Swing(3))] ,TCurrent);

SNext=poseGlobal([0.055*Sisleft 0 0],predictedCoM);

TxNext=TNext(1);
TyNext=TNext(2);
Ttheta=TNext(3);


SxNext=SNext(1);
SyNext=SNext(2);
Stheta=SNext(3);



end

function pGlobal = poseGlobal(pRelative, pose)

ca = cos(pose(3));
sa = sin(pose(3));


pGlobal = pose + ...
    [ca*pRelative(1) - sa*pRelative(2) ...
    sa*pRelative(1) + ca*pRelative(2) ...
    pRelative(3)];
end

function pRelative = poseRelative(pGlobal, pose)
ca = cos(pose(3));
sa = sin(pose(3));

dp = pGlobal - pose;

pRelative = [ca*dp(1) + sa*dp(2) ...
    -sa*dp(1) + ca*dp(2) ...
    modAngle(dp(3))];

end

function a = modAngle(a)

a = mod(a, 2*pi);
a(a >= pi) = a(a >= pi) - 2*pi;

end

