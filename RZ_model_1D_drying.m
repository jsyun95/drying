%% RZ diffusion model
% A. F. Routh and W. B. Zimmerman, Chemical Engineering Science, 59, 2961–2968 (2004)

%% Plot data  
m = 0;
sol = pdepe(m,@pdefun,@pdeic,@pdebc,x,t);
u1 = sol(:,:,1);

for i = 1:length(t)
    plot(x*(1-t(i)), u1(i,:), 'b')
    hold on
end
title('Particle volume fraction profiles during drying')

xlabel('h/h_0')
ylabel('\phi')
xlim([0 1])
ylim([0 0.65])

%% PDE to solve
function [c,f,s] = pdefun(x,t,u,dudx)
    global Pe
    phim = 0.64; % Maximum volume fraction of the random close packing
    Kphi = (1-u)^6.55; % Contribution of the hydrodynamic interactions
    Dphi = (1/phim) / (1-u/phim)^2; % Contribution of the thermodynamic interactions
    
    Dcol = Kphi*Dphi; % Collective diffusivity
    
    c = 1;
    f = Dcol*dudx/(Pe*(1-t)^2);
    s = -x*dudx/(1-t);
end

%% initial conditions
function u0 = pdeic(x)
    global phi0
    u0 = phi0;
end

%% boundary conditions
function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t)
    pl = 0;
    ql = 1;
    pr = -ur/(1-t);
    qr = 1;
end