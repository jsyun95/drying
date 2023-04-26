clear all
clc

%% Variables
read_variables = readtable('input_variables.txt','Delimiter','comma');
var = table2array(read_variables);

global phi0
h0 = var(1)*1e-6; % Initial wet film thickness (초기 필름 두께)
a = var(2)*1e-6; % Particle radius (입자의 반지름)
T = var(3); % Process temperature (공정 온도)
mu0 = var(4); % Dynamic viscosity of the solvent (용매의 점도)
phi0 = var(5); % Initial concentration of the particle (입자의 초기 농도)
kT = 1.38e-23*T; % Thermal energy (Boltzmann constant*temperature) 

%% Characteristics of system
global Pe
D0 = kT/(6*pi*mu0*a); % Stokes-Einstein diffusion coefficient
fprintf('The diffusion coefficient of single particle [m^2/s]\n D0 = %s\n', D0)
Peclet = '\nInput Peclet number (Yoo model: 10~1500 and RZ model: 0.1~100 recommanded) \n Pe = v_ev*h0/D0: [Evaporation/Diffusion]\n Pe = ';
Pe = input(Peclet); % Peclet number
fprintf('\nEvaporation rate [m/s]\n v_ev = %s\n', Pe*D0/h0)

%% Plot point
global x t
% Spatial resolution
POINT = 1000;
x = linspace(0, 1, POINT); % Bottom wall (x=0) Air-liquid interface (x=1)

% Time resolution (at t=0, x=h0  and at t=1, x=0)
t_end = 0.5;
t_POINT = 4;
t = linspace(0.0,t_end,t_POINT);
t = [0.0 0.33 0.66]

%% Select model
prompt = '\nSelect model \n 1: Yoo model \n 2: RZ model \n\n model type = ';
model = input(prompt);
fprintf('\nThe simulation is running.\nIt may take a few minutes...')

if model == 1
    run('Yoo_model_1D_drying.m')
elseif model == 2
    run('RZ_model_1D_drying.m')
end

fprintf('\n\n Data are stored in u1\n')
