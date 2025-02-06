%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLAB Code Generated with Fuzzy Logic Designer App                     %
%                                                                         %
% Date: 19-Jan-2025 13:40:49                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Construct FIS
VlaveFIS = mamfis(Name="VlaveFIS");
% Input 1
VlaveFIS = addInput(VlaveFIS,[0 1],Name="Level");
VlaveFIS = addMF(VlaveFIS,"Level","gaussmf",[0.1769 -1.388e-17], ...
    Name="Normal",VariableType="input");
VlaveFIS = addMF(VlaveFIS,"Level","gaussmf",[0.1769 0.5], ...
    Name="Low",VariableType="input");
VlaveFIS = addMF(VlaveFIS,"Level","gaussmf",[0.1769 1], ...
    Name="High",VariableType="input");
% Output 1
VlaveFIS = addOutput(VlaveFIS,[0 1],Name="Valve");
VlaveFIS = addMF(VlaveFIS,"Valve","trimf",[-0.416667 0 0.416667], ...
    Name="NoChange",VariableType="output");
VlaveFIS = addMF(VlaveFIS,"Valve","trimf",[0.0833333 0.5 0.916667], ...
    Name="OpenFast",VariableType="output");
VlaveFIS = addMF(VlaveFIS,"Valve","trimf",[0.583333 1 1.41667], ...
    Name="CloseFast",VariableType="output");
% Rules
VlaveFIS = addRule(VlaveFIS,[1 1 1 1; ...
    2 2 1 1; ...
    3 3 1 1]);