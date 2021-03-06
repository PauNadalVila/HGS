function [Tp,n,species,flag] = HGStp(species,n0,type,V0,P,options)
%**************************************************************************
%
% [Tp,n,species,flag] = HGStp(species,n0,type,V0,P,options)
%
%**************************************************************************
% 
% HGSisentropic calculates the reaction final temperature and mixture
% composition 
%
%**************************************************************************
% Inputs:
%--------------------------------------------------------------------------
% species --> String or numbers of species
% n0 --> [mols] Number of mols of each species
% type --> Entry type. It coould be 'T' or 'S'
% V0 --> Entry that should be for type:'T'   V0=T [K] 
%                                      'H'   V0=H [kJ]
% P --> [bar] Pressure
% options --> Structure with the options for the secant method. 
%                 .xmin [K] Temperature minimum for the solver;
%                 .xmax [K] Temperature maximum for the solver;
%                 .maxiter Max iterations for the solver;
%                 .epsx Diferential T where the solver reachs the solution;
%                 .epsy Diferential S where the solver reachs the solution;
%                 .fchange T difference where secant method is
%                          changed by bisection method;
%                 .type Select between: 'Frozen' for frozen flow
%                                       'Shifting' for shifting flow
%                 .info Detailed info == 1; No info == 0.
%                 .dTp Improve the velocity with the approximation of
%                 parabola. +- dTp
%           struct('xmin',300,'xmax',6000,'maxiter',50,'epsx',0.1,'epsy',0.5,'fchange',5,'type','Shifting','info',0,'dTp',100)
%
%**************************************************************************
% Outputs:
%--------------------------------------------------------------------------
% Tp --> [K] Exit temperature
% n --> [mols] Species resultant mols
% species --> String or numbers of species
% flag --> Solver error detection: 
%                 1  Solver has reached the solution
%                -1  Solver failed. Maximum iterations
%                -2  Solver failed. Initial sign change not found
%
%**************************************************************************
% *HGS 2.0
% *By Caleb Fuster, Manel Soria and Arnau Mir�
% *ESEIAAT UPC    

% type = 'H' or 'T'
if type~='H' && type~='T'
    error('Wrong type = %s',type);
end

if ~exist('options','var')
   options = []; 
end

global HGSdata; HGSload
[id] = HGSid(species);

% Rebuild mixtures
if max(id) >= length(HGSdata.Mm)
   [species,n0] = HGSrebuild(species,n0);
   [id] = HGSid(species);
end

% compute initial enthalpy
if type=='T'
    H = HGSprop(id,n0,V0,P,'H');
else
    H = V0;
end

[Tp,n,~,flag]=HGSeqcond(id,n0,'H',H,P,options);

end
