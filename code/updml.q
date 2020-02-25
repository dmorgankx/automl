// The purpose of this file is to act as a placer for functions which may be moved into the
// machine learning toolkit or which overwrite the present behaviour of functions in the
// toolkit

\d .ml


// Update to infreplace to handle types other than floats which is a limiting
// behaviour of the current version in the toolkit
infreplace:{
  $[98=t:type x;
      [m:type each dt:k!x k:.ml.i.fndcols[x;"hijefpnuv"];
        flip flip[x]^i.infrep'[dt;m]];
    0=t;
      [m:type each dt:x r:where all each string[type each x]in key i.inftyp;
        (x til[count x]except r),i.infrep'[dt;m]];
    98=type kx:key x;
      [m:type each dt:k!x k:.ml.i.fndcols[x:value x;"hijefpnuv"];
        cols[kx]xkey flip flip[kx],flip[x]^i.infrep'[dt;m]];
    [m:type each dt:k!x k:.ml.i.fndcols[x:flip x;"hijefpnuv"];flip[x]^i.infrep'[dt;m]]]}

// Encode the target data to be integer values which are computer readable
labelencode:{(asc distinct x)?x}

// Train-test split without shuffling set as the default for FRESH to ensure time ordering,
// similar to be implemented for the time series/time aware recipes
ttsnonshuff:{[x;y;sz]`xtrain`ytrain`xtest`ytest!raze(x;y)@\:/:(0,floor n*1-sz)_til n:count x}

// update to confmat showing true and pred values
conftab:{(`$"true_",/:sk)!flip(`$"pred_",/:sk:string key m)!flip value m:confmat[x;y]}

// Updated cross validation functions necessary for the application of grid search ordering correctly.
// Only change is expected input to the t variable of the function, previously this was a simple
// floating point values -1<x<1 which denotes how the data is to be split for the train-test split.
// Expected input is now at minimum t:enlist[`val]!enlist num, while for testing on the holdout sets this
// should be include the scoring function and ordering the model requires to find the best model
// `val`scf`ord!(0.2;`.ml.mse;asc) for example
// --NB-- must be defined in below order as `gs.apply` is called outside `.ml.gs`
i.gsapply:{[xv;k;n;x;y;f;p]
  tot:exec max n from cmb:update n:i+1 from p:key[p]!/:1_'(::)cross/value p;
  if[1<tot;-1"Performing grid search for ",string[tot]," combinations of hyperparameter"];
  pset:{[xv;f;tot;prm]
    if[b:0=prm[`n]mod 5;-1"Applying hyperparameter set ",string[prm`n],"/",string tot];
    start:.z.t;r:xv f pykwargs@-1_prm;tm:.z.t-start;if[b;-1"Running model took ",string tm];(tm;r)};
  (p,'([]time:`long$r[;0]))!.[;(::;1)]r:pset[xv[k;n;x;y];f;tot]@'cmb}

gs:1_{[gs;k;n;x;y;f;p;t]
  if[0=t`val;:gs[k;n;x;y;f;p]];
  i:(0,floor count[y]*1-abs t`val)_$[0>t`val;xv.i.shuffle;til count@]y;
  scf:$[type[fn:get t`scf]in 100 104h;i.balancesco[;fn;t,:enlist[`scl]!enlist 1];desc avg each];
  ((delete time from key r)!value r;pr;(pykwargs pr:first key scf r:gs[k;n;x i 0;y i 0;f;p])(x;y)@\:/:i)
  }@'i.gsapply@'xv.j

i.balancesco:{[r;fn;t]
  s:{(delete time from key x)!update time:key[x]`time from([]score:value x)}t[`ord]avg each fn[;].''r;
  t[`ord]key[s]!i.timescore[t`scl]value s};
i.timescore:{[x;y]select .5*(score*x)+(1-x)%time from .ml.i.ap[{x%max x};y]}


// Utilities for functions to be added to the toolkit
i.infrep:{
 t:i.inftyp[]first string y;
 {[n;x;y;z]@[x;i;:;z@[x;i:where x=y;:;n]]}[t 0]/[x;t 1 2;(min;max)]}
i.inftyp:{
  typ:("5";"8";"9";"6";"7";"12";"16";"17";"18");
  rep:(0N -32767 32767;0N -0w 0w;0n -0w 0w),6#enlist 0N -0W 0W;
  typ!rep}
