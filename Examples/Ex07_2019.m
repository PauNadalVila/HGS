%***********************************************************************************************************
%* HGS 2.0 (adapted from the original HGS 1.3) 
%* Original by Arnau Miro, Pau Manent, Manel Soria 
%* Adapted by Caleb Fuster
%
%* ESEIAAT UPC              
%***********************************************************************************************************
%
% Example 07: isentropic comparison with RPA software

clear; 



species={'H','H2','H2O','H2O2','HO2','O','O2','O3','OH'}

% ratio OF = 8 : mO2 / mH2 = 8 
% assume mH2 = 1 g : mO2 = 8g

% (8/32 mol O2) / (1/2 mol H2 )  = 0.5 mol O2 / mol H2

%  {'H','H2','H2O','H2O2','HO2','O','O2','O3','OH'}
n=[  0 , 1  , 0   , 0    , 0   , 0 , 0.5, 0  , 0];
T=3419.88;
P=20;
P2=1;

[~,neq,~]= HGSeq(species,n,T,P);

neq/sum(neq)


dT=0.1;

[MM,Cp,Cv,H,S,~,Rg,gamma,a]= HGSprop(species,neq,T,P);

H/(MM/1000)

S/(MM/1000)

gamma

Rg

a


[T2,n2,species,v2,M2,~]= HGSisentropic(species,neq,T,P,P2)


n2/sum(n2)

return


% Nozzle inlet mole fractions (RPA)
% for O/F ratio = 7.937 

ni_rpa=[ 0.0644043;...  % H
    0.1402066;...       % H2
    0.6176198;...       % H2O
    0.0000024;...       % H2O2
    0.0000367;...       % HO2
    0.0268578;...       % O
    0.0467048;...       % O2
    0.1041674];         % OH
    
Tc=3027.58  % K (RPA)
Pc=1        % bar (RPA)

