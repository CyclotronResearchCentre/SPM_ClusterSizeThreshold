function K_thresh = cp_cluster_Pthresh(xSPM, p_val)
%
% Function to find the cluster-size threshold (number of voxels) for a
% given (corrected) p-value.
%
% INPUT:
%   - xSPM : structure available in the workspace when looking at SPM
%            results
%   -p_val : statistical threshold [.05 by default]
%
% OUTPUT:
%   - K_thresh : minimum size of cluster (in voxels) to have a p-value
%                smaller than p_val.
%__________________________________________________________________________
% Copyright (C) 2014 Cyclotron Research Centre

% Written by Christophe Phillips (2014.07.01), c.phillips@ulg.ac.be
% Cyclotron Research Centre, University of Liege, Belgium


if nargin<2
    p_val = .05;
end

%-Extract data from xSPM
S         = xSPM.S;
VOX       = xSPM.VOX;
DIM       = xSPM.DIM;
n         = xSPM.n;
STAT      = xSPM.STAT;
df        = xSPM.df;
u         = xSPM.u;
k         = xSPM.k;

% Conversion from voxels to resels
R     = full(xSPM.R);             % Resel counts
FWHM  = full(xSPM.FWHM);          % Full width at half max
FWHM  = FWHM(DIM>1);
V2R   = 1/prod(FWHM);             % voxels to resels
R     = R(1:find(R~=0,1,'last')); % eliminate null resel counts

% Search between 1 and 5000 voxels, at level p_val
nK = [1 5000];
go_on = 1;
while go_on 
    k_2 = round(mean(nK));
    K_2 = k_2*V2R;
    [Pk,Pn] = spm_P(1,K_2,u,df,STAT,R,n,S);
    if Pk>p_val
        nK(1) = k_2;
    else
        nK(2) = k_2;
    end
    if diff(nK)<2
        go_on = 0;
    end
end
K_thresh = nK(2);

fprintf('\n Minimum #voxel (p_corr<%1.3f) : %d\n\n',p_val,K_thresh);

% k_ii = 174;
% K = k_ii*V2R;
% [Pk,Pn] = spm_P(1,K,u,df,STAT,R,n,S)


