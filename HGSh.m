function [H] = HGSh(a,T)
%**************************************************************************
%
% [H] = HGSh(a,T)
%
%**************************************************************************
% 
% HGSh calculates the enthalpy of a species using his Burcat coeficients and
% temperature
%
%**************************************************************************
% Inputs:
%--------------------------------------------------------------------------
% a --> Burcat coeficients
% T --> [K] Temperature
%
% Outputs:
%--------------------------------------------------------------------------
% H --> [kJ/mol] Enthalpy
%
%**************************************************************************
% *HGS 2.0
% *By Caleb Fuster, Manel Soria and Arnau Mir�
% *ESEIAAT UPC    

global R; HGSr

H = R * (a(6) + sum(a(1:5).*(T.^(1:5))./(1:5))); % [kJ/mol]

end