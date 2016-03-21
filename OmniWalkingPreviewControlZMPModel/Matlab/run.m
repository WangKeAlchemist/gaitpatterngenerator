
close all;

vx=0.5; %Displacment of CoM along x-axis per step
vy=1; %Displacment of CoM along y-axis per step
vtheta=0*pi/180; % Yaw of Torso per step

numStep = 7; % Number of steps to simulate


[sposx sposy tposx tposy]=footgen(vx , vy, vtheta, numStep); % Generate foot positions and torso positions


tf=1; %Duration of one step


uxp=[];
uyp=[];
tp=[];
zmpx=[];
zmpy=[];

for i=1:numStep
    
    
    zmpx1=[];
    zmpy1=[];
    zchange=[];
    dzchange=[];
    
        
    for t=0:0.002:tf
        
        % Generates ZMP trajectories
        zmpx1=[zmpx1 sposx(i)]; 
        zmpy1=[zmpy1 sposy(i)];
        
        
        tp=[tp (i-1)*tf+t];
  
            
    end
    
    
    zmpx=[zmpx zmpx1];
    zmpy=[zmpy zmpy1];
    
end

% Generate CoM trajectories

[uxp uyp]=PreviewCoMGenerator(zmpx , zmpy, tp);

figure('name','Movment of Torso Along Y-Axis');
axis equal
plot(tp,zmpx,'r');
hold
plot(tp,uxp,'b');
legend('ZMP-Y' , 'CoM-Y')
xlabel('Time')
ylabel('Position')

figure('name','Movment of Torso Along X-Axis');
axis equal
plot(tp,zmpy,'r');
hold
plot(tp,uyp,'b')
legend('ZMP-X' , 'CoM-X')
xlabel('Time')
ylabel('Position')