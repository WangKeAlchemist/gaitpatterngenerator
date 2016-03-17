function [CoMf,CoMl]=PreviewCoMGenerator(zmpx, zmpy, tp)

zc=0.22;
g=9.8;

delt=0.002;
% State-Space representation
A = [1 delt delt^2/2;
    0 1 delt;
    0 0 1];
B = [delt^3/6;
    delt^2/2;
    delt];
C = [1 0 -zc/g];

% ydf = forward ZMP
% ydl = lateral ZMP
% x = TotalTimeSequence

ydf = zmpx;
ydl = zmpy;
x = tp;

% [ydf,ydl,x]=ZMPGenerator(CommonPara);

% optimal gain refered to preview H2 theory
A1 = [1 C*A;zeros(3,1) A];
B1 = [C*B;B];
C1 = [1 0 0 0];

Qe = [1];
Qx = zeros(3,3);

Q = [Qe zeros(1,3);zeros(3,1) Qx] ;
R = 1e-20;

% P = solution of DARE, G = optimal gain
[P,L,G] = dare(A1,B1,Q,R);
      
Ke = G(1,1);
Kx = G(1,2:end);

% Preview Controller Design
% Preview size

N = 0:delt:1;

% Calculation of Preview gain
% recursively computed
Ac = A1-B1*G;
Gp = zeros(1,length(N)); % Preview gain matrix
X1 = zeros(4,length(N)); % Preview state

Gp(1) = -Ke;

X1(:,1) = -Ac'*P*[1;0;0;0];


for i = 2:length(N)
   
    Gp(i) = inv(R+ B1'*P*B1)*B1'*X1(:,i-1);
    X1(:,i) = Ac'*X1(:,i-1);
end



xkf = zeros(3,length(x)); % state
xkl = zeros(3,length(x));
ukf = zeros(1,length(x)); % Control input
ukl = zeros(1,length(x));

ykf = zeros(1,length(x)); % forward direction
ykl = zeros(1,length(x)); % lateral direction
CoMf = zeros(1,length(x));
CoMl = zeros(1,length(x));
ef = 0; % summation of error
el = 0;
for k = 1:length(x)

    if (k+length(N))<length(x)

        CoMf(k) = xkf(1,k);
        CoMl(k) = xkl(1,k);

        ykf(k) = C*xkf(:,k); % C = output matrix, xk =
        ykl(k) = C*xkl(:,k);

        ef = ef + ykf(k) - ydf(k);
        el = el + ykl(k) - ydl(k);
        prevf = 0;
        prevl = 0;

        for i = 1:length(N)
            if (k+length(N))<length(x)
                prevf = prevf + 1*Gp(i)*ydf(k+i);
                prevl = prevl + 1*Gp(i)*ydl(k+i);
            end
        end

    else
        ykf(k) = ykf(k-1);  % there is no enough preview point
        ykl(k) = ykl(k-1);
        CoMf(k) = xkf(1,k-1);
        CoMl(k) = xkl(1,k-1);
    end

    ukf(k) = -Ke*ef - Kx*xkf(:,k) - prevf;
    ukl(k) = -Ke*el - Kx*xkl(:,k) - prevl;
    xkf(:,k+1) = A*xkf(:,k)+B*ukf(k);
    xkl(:,k+1) = A*xkl(:,k)+B*ukl(k);
end
end
