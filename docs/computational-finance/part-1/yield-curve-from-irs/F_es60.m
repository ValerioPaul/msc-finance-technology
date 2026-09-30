function [ v_spot_int ] = F_es60( v_spot, time, time_int)

% inputs:    v_spot   : price of a ZCB
%            time     : the original maturities
%            time_int : the new maturities at which the rates are wanted
% output:    v_spot_int : vector of ZCB prices on the new time grid time_int

yield = -log(v_spot) ./ time;                                     % yield to maturity: converts each ZCB price into its continuous spot rate
                                                                  % rates interpolate well, prices do not

yield_int = interp1(time, yield, time_int, 'linear');             % linear interpolation of the known points (time, yield) at the intermediate maturities

% Now there are spot rates for every maturity (including the semi-annual ones),
% but pricing needs discount factors again. The inverse formula:

v_spot_int = exp(-yield_int .* time_int);                         % discount factors at the intermediate points

end
