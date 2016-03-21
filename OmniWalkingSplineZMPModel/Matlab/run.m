
close all;

vx=0.5; %Displacment of CoM along x-axis per step
vy=1; %Displacment of CoM along y-axis per step
vtheta=0*pi/180; % Yaw of Torso per step

numStep = 5; % Number of steps to simulate

[sposx sposy tposx tposy]=footgen(vx , vy, vtheta, numStep); % Generate foot positions and torso positions


tf=1; %Duration of 1 step

t0=0;  % Intial time
t1=0.1; % Double stance phase duration 
t2=tf-t1; % Double stance phase duration 

uxp=[];
uyp=[];
uxf=[];
uyf=[];
tp=[];
zmpx=[];
zmpy=[];
zmpxf=[];
zmpyf=[];




for i=1:numStep
    
    
    for t=0:0.002:(tf-0.002)
        
        
        [zmpx1 zmpy1]=SplineZMP(tposx(i),tposy(i),sposx(i),sposy(i),tposx(i+1),tposy(i+1),t0,t1,t2,tf,t); % Approximte ZMP Trajectory Using Fourier Series
        [ux uy]= SplineCoM(tposx(i),tposy(i),sposx(i),sposy(i),tposx(i+1),tposy(i+1),t0,t1,t2,tf,t); % Compute CoM Postion Based on Fourier approximation
        
        uxf=[uxf ux];
        uyf=[uyf uy];
        
        zmpxf=[zmpxf zmpx1];
        zmpyf=[zmpyf zmpy1];

        
        tp=[tp (i-1)*(tf)+t];
        
        
    end
    
    
end


figure('name','Movment Along Y-Axis');
axis equal
plot(tp,zmpxf,'r');
hold
plot(tp,uxf,'b');
legend('ZMP-Y' , 'CoM-Y')
xlabel('Time')
ylabel('Position')

figure('name','Movment Along X-Axis');
axis equal
plot(tp,zmpyf,'r');
hold
plot(tp,uyf,'b')
legend('ZMP-X' , 'CoM-X')
xlabel('Time')
ylabel('Position')
