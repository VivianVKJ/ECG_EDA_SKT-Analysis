function [record]=eda_saveraw(eda, fs, edr)
% EDA_SAVE_TEXT Save EDA results in text file format
%   EDA_SAVE_TEXT(eda, fs, edr, conds, ftxt)
%
% Required input arguments:
%   eda   - 1-by-n vector of EDA samples
%   fs    - sampling rate (Hz) 
%   edr   - structure array of electrodermal response (EDR) (see eda_edr.m)
%
% Optional input arguments:
%   conds - structure array of EDR and EDL grouped by conditions (see 
%           eda_conditions.m)
%   ftxt  - output text file name
% _________________________________________________________________________

% Last modified 22-11-2010 Mateus Joffily

% Copyright (C) 2002, 2007, 2010 Mateus Joffily, mateusjoffily@gmail.com.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
    nEDR      = numel(edr.iPeaks);
    idx       = 1:nEDR;
    edr_stats = eda_edr_stats(eda, fs, edr, idx);
    record=[idx; edr_stats.valleyTime; edr_stats.peakTime; ...
    edr_stats.amplitude; edr_stats.riseTime; ...
    edr_stats.slope; edr_stats.type];
    %Video|Index|ValleyTime|tPeakTime|Amplitude|RiseTime|Slope|EDRtype'
end


