%       EXAMPLE 1 (Capitolo 5)
%
%
% Questo file contiene le istruzioni per l'analisi termica di un satellite di forma sferica modellato a massa singola. 
% Si considera l'input solare, terrestre e una potenza addizionale che agisce durante l'eclissi.
% 
%
%
%
% options = odeset('RelTol',1e-8,'AbsTol',[1e-10]);
%
function xdot=EXAMPLE_1(t,x)
%
sig=5.67e-8;	% costante di Stefan Boltzmann [W/(m^2 K^4)]
%
C=1368;		% costante solare [W/m^2]
%
RE=6378;    % raggio equatoriale terrestre [km]
H=35786;      % quota di volo [km]
r=RE+H;     % raggio orbitale
om0=sqrt(398600.4/r^3);     % velocità angolare orbitale [rad/s]
%
%
m=5;		%massa [kg]
c=900;      %calore specifico [J/(kg K)]
mc=m*c;     %capacità termica [J/K]
%
Rs=0.25;
%Rs=sqrt(3/(2*pi));  % raggio del satellite sferico [m] (si ottiene supponendo che l'area esterna sia pari a 6 m^2)
At=4*pi*Rs^2;       % area esterna del satellite [m^2]
Ap=pi*Rs^2;         % area proiettata del satellite [m^2]
Fe=0;
%Fe=0.5*(1-sqrt(1-(RE/(RE+H))^2));   % fattore di vista terrestre
Te=250;     % temperatura della superficie terrestre [K]
A0=At;      % area di riferimento del satellite [K]
%
emi=0.5;        % emissività
alfa=0.7;       % assorbività
%
%
%
P=0;
gamma=asin(RE/r);
beta=om0*t;
%
if cos(beta)<= cos(pi-gamma)
       delta1=0;
       delta2=1;
    else
       delta1=1;
       delta2=0;
end
%
xdot(1)=(alfa*C*Ap*delta1+0*sig*emi*Te^4*A0*Fe-sig*emi*At*x(1)^4+0*delta2*P)/mc;