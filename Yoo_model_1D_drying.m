%% Yoo diffusion model
% T. Yoo, B. Chun & H.W. Jung, Drying Technology, 40(3), 516-526 (2022)

%% Plot data
m = 0;
sol = pdepe(m,@pdefun,@pdeic,@pdebc,x,t);
u1 = sol(:,:,1);

for i = 1:length(t)
    plot(x*(1-t(i)), u1(i,:), 'b')
    hold on
end
%title('Particle volume fraction profiles during drying')
set(gca,'FontSize',18)
xlabel('h/h_0', 'FontSize', 25)
ylabel('\phi', 'FontSize', 25)
xlim([0 1])
ylim([0 0.65])

%% PDE to solve
function [c,f,s] = pdefun(x,t,u,dudx)
    global Pe phi0
    
    % Model parameters (alpha and beta) are obtained from [B. Chun, T. Yoo, H.W. Jung, Soft Matter, 16, 523-533 (2020)]
    alpha = 1/(5.5*phi0 + 0.25);
    beta = 6*phi0; 
    
    phim = 0.64; % Maximum volume fraction of the random close packing
    phic = phim*(1-alpha/Pe^(1/2)); % Critical volume fraction
    chi = 1 + beta*u*Pe; % Degree of volume exclusion
    
    Kphi = (1-u)^6.55; % Contribution of the hydrodynamic interactions
    Dphi = chi / (1-u/phic)^2; % Contribution of the thermodynamic interactions
    
    Dcol = Kphi*Dphi; % Collective diffusivity
    
    c = 1;
    f = Dcol*dudx/(Pe*(1-t)^2);
    s = -x*dudx/(1-t);
end

%% Initial conditions
function u0 = pdeic(x)
    global phi0
    u0 = phi0;
end

%% Boundary conditions
function [pl,ql,pr,qr] = pdebc(xl,ul,xr,ur,t)
    pl = 0;
    ql = 1;
    pr = -ur/(1-t);
    qr = 1;
end