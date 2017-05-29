function[a,w,phi] = single_qubit(single_control,single_frequency,single_phase,d,J,single_expected)
% Single_qubit input all the parameters given and simulate the system for 0.58ns.
% It outputs a graph plotting fidelity graph, as well as set of controls
% used.
load('variables.mat')
%% General Parameters.
n = 3000;
%% Expand Parameters
a = single_control;
w = single_frequency;
phi = single_phase;

for p=1:n                                
    T = p/n*t;
    Hrf = J[1]*(cos(d[1]*T)*X1+sin(d[1]*T)*Y1)*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2) ...
         +J[2]*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2)*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3) ...
         +J[3]*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3)*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4) ...
         +J[4]*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4)*(cos(d[5]*T)*X5+sin(d[5]*T)*Y5) ...
         +a[1]*pulse_shape_slow(0.58,T)*cos(w[1]*T+phi[1])*(cos(d[1]*T)*X1+sin(d[1]*T)*Y1) ...
         +a[2]*pulse_shape_slow(0.58,T)*cos(w[2]*T+phi[2])*(cos(d[2]*T)*X2+sin(d[2]*T)*Y2) ...
         +a[3]*pulse_shape_slow(0.58,T)*cos(w[3]*T+phi[3])*(cos(d[3]*T)*X3+sin(d[3]*T)*Y3) ...
         +a[4]*pulse_shape_slow(0.58,T)*cos(w[4]*T+phi[4])*(cos(d[4]*T)*X4+sin(d[4]*T)*Y4) ...
         +a[5]*pulse_shape_slow(0.58,T)*cos(w[5]*T+phi[5])*(cos(d[5]*T)*X5+sin(d[5]*T)*Y5);  
    E = expm(-1i*(Hrf)*t/n);
    evo = E* evo;
    F(1,p+1) = 1/32*trace(conj(transpose(single_expected))*evo);
end
 plot(x_axis,abs(F(1,:)))
