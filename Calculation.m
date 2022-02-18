syms q_shower_mid q_shower_low q_shower_hight 
syms r v t T t_out t_initial tau roo cp h1 h2 A1 A2 L T time q_heat
syms c re m n nu pr kf D ni wind q_lose Q_real A_out
syms kw_elec_cost amount cost
clc
%--------------------------------------------%
%values
T = 70;

t_initial = 26;
t_out = 6; %the temparture outside
wind = 15; %wind speed in [km/h
t=10; %the time you want to shower [minutes]

q_heat = 2500; %the power heat of the heating element[W]
roo = 990; %avrage density of water
cp = 4.195;

%--------------------------------------------%
%WIND influance

n = 0.4; %heating the fluid
ni = 2*10^-4; %Kinematic viscosity of air
kf = 0.02; %thermal conductivity of polyuretheance

r = 0.235;
L = 0.85; %hight of the water tank

D = (4*pi*r^2)/(2*pi*r);
re = (wind*3.6*D)/ni;

pr = 0.7;

nu = 0.023*re^0.8*pr^n;
h1 = (nu*kf)/D;

A_out = 2*pi*r*L;

q_lose = h1*A_out*(T-t_out); %calculating the heat looses from the wind outside

Q_real = q_heat - q_lose; %calculating the real heating of the water
%--------------------------------------------%

fprintf('The Temparture outside is %d [celsius]\n',t_out)
fprintf('The Wind outside is %d [km/h]\n',wind)

%--------------------------------------------%
%choosing the rate of water in the shower

q_shower_mid=108*10^-6;
q_shower_hight=140*10^-6;

s=t*60; %in seconds

v = (q_shower_mid*s)/0.001; %litters needed for the shower
fprintf('You need %d [Liters] to shower for about: %d [minutes]\n',vpa(v,2), t)

%--------------------------------------------%
A1 = 2*pi*r^2*L;

eqn = Q_real == h2*A1*(T-t_initial);
sol1 = solve(eqn, h2);
h2 = vpa(sol1, 6); %the h of the water 

%--------------------------------------------%

A2 = 2*pi*r^2 + 2*pi*r*L;
tau = (roo*v*cp)/(h2*A2);

%--------------------------------------------%

eqn = (T)/(t_initial) == exp(time/tau);
sol2 = solve(eqn, time);
time = vpa(sol2, 6);

fprintf('For that, you need to heat the water for approximately %d [minutes]\n',time/60)

%--------------------------------------------%
%The cost of the heating water

kw_elec_cost = 0.5033;
amount = (q_heat*time*kw_elec_cost)/(3.6*10^6);

fprintf('this heating proccec will cost you about %d [AGOROT]\n',vpa(amount, 5)*100)

