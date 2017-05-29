function[]=multirun(expected,a,w,phi)
load('variables.mat')

%% Underlying parameter
d

J12 = 0.2*pi;
J23 = 0.2*pi;
J34 = 0.2*pi;
J45 = 0.2*pi;

a2 = 0.1;
a3 = 1.7187;
w2 = -31.3794;
w3 = w2;

% additional 
x_axis = 0:t/n:t;
evo = eye(32);
Phase_CNOT2 = [0.4488 + 0.8881i,0,0,0;0,0,0,-0.9927 + 0.0018i;0,0,0.0835 + 0.9939i,0;0,-0.8445 - 0.5221i,0,0];
% gate time
t_block = 15.2/20;
t_single = 0.58;

%control 
a1 = 2.483*pi;
a4 = 2.5*pi;

w1 = -d1;
w4 = -d4;


phi1 = pi/2+d1*t_block; % d1/2*t_single finite phase correction 
phi4 = pi/2+d4*t_block;
%% Actual evolution of the system
for p=1:n                                  %pv(tdelay,thold,t)
    T = p/n*t;
    % Decoupled hamiltonian
     if mod(p,n/20) == 0
         phi1 = phi1+d1*t_block;
         phi4 = phi4+d4*t_block;
     end
    if mod(T,t_block)>= t_block-t_single 
        Hrf = J[1]*(cos(d[1]*T)*X1+sin(d[1]*T)*Y1)*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2) ...
         +J[2]*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2)*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3) ...
         +J[3]*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3)*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4) ...
         +J[4]*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4)*(cos(d[5]*T)*X5+sin(d[5]*T)*Y5) ...
         +a[1]*pulse_shape_slow(0.58,T)*cos(w[1]*T+phi[1])*(cos(d[1]*T)*X1+sin(d[1]*T)*Y1) ...
         +a[2]*pulse_shape_slow(0.58,T)*cos(w[2]*T+phi[2])*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2) ...
         +a[3]*pulse_shape_slow(0.58,T)*cos(w[3]*T+phi[3])*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3) ...
         +a[4]*pulse_shape_slow(0.58,T)*cos(w[4]*T+phi[4])*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4) ...
         +a[5]*pulse_shape_slow(0.58,T)*cos(w[5]*T+phi[5])*(cos(d[5]*T)*X5+sin(d[5]*T)*Y5);   
    else
        Hrf = J[1]*(cos(d[1]*T)*X1+sin(d[1]*T)*Y1)*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2) ...
         +J[2]*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2)*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3) ...
         +J[3]*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3)*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4) ...
         +J[4]*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4)*(cos(d[5]*T)*X5+sin(d[5]*T)*Y5);   
    end
    E = expm(-1i*(Hrf)*t/n);
    evo = E* evo;
    F = 1/32*trace(conj(transpose(expected))*evo);
end
 plot(x_axis,abs(F(1,:)))
 title('Fidility Chart')
 ylabel('Fidility')
 xlabel('time')

