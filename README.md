# SPM Cluster Size Threshold estimation

When looking at their SPM results, users very often set it to arbitrary value (I've seen 10, 30, etc.) such that their plot looks good! If this is just cosmetic choice, fine, why not. On the other hand, one could be interested in setting the cluster extent threshold to a meanigful value, i.e. use an extent corresponding to some p-value.

The goal of this routine is precisely that: given an estimated SPM, find the cluster extent threshold, such that only significant (at a defined **corrected** p-value!) clusters are displayed and listed. How do you use it? Once your SPM is estimated:
  1. look at your SPM results, using a voxel-wise uncorrected p-value threshold, i.e. typically the .001 uncorrected cluster forming threshold
  2. run 'K_thresh = cp_cluster_Pthresh(xSPM, p_val)' where 'xSPM' is a structure available in your Matlab workspace when looking at SPM results and 'p_val' is the statistical threshold you want [.05 by default if omitted].
  3. change the cluster extend threshold to 'K_thresh'

And that's it!

As usual, this provided 'as is', without any warranty or support. Use at your own risk!
