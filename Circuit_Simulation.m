%% Quantum Ciruit Simulation
%---------------------------
%  Introduction
% Use small time steps to simulate the evolution of a system.
% This is useful because there is no analytical solution of the question.
%---------------------------
%  Files
%
% variables.mat : Defined all the useful variables
% single_qubit : A single run of qubit simulation (t = 0.58)
% multi_run : A string of 20 gates run together.
% pulse_shape_slow : This simulate a pulse shape with rise and fall.

%% Initialization
clear ; close all; clc

%%=========== Define Useful Parameters============
load('variables.mat')

%%=========== General Physical Numerics===========
% These are some general parameters in Superconducting--flux--fixed
% coupling circuit.

%Zeeman Frequencies
d = [14,10,14,10,14]*pi;

%Inductive Couplings
J = zeros(1,4)+(0.3*pi);
%%=========== Let User Train the One time Run gate============
fprintf('Now excuting single run gate optimization...\n');

single_feedback = 'N';
while single_feedback == 'N'
    single_expected = input('What is your expected outcome as matrix? ');
    single_control = input('What is your control amplitude as a list?');
    single_frequency = input('What is your control frequency as a list?');
    single_phase = input('What is your control phase as a list?');
    [a,w,phi] = single_qubit(single_control,single_frequency,single_phase,d,J,single_expected);
    single_feedback = input('Are you satisfied with the Fidelity Chart? (Y\N)\n');
end



fprintf('Press anykey to continue...\n');
pause;
%%=========== Now Run the entire Time Domain ============
fprintf('Now training how circuit with previously trained parameters\n');
expected = input('What is your expected outcome as matrix? ')

% Run the function
multirun(expected,a,w,phi)

