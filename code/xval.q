\d .ml


xval.i.apply:{[idx;k;n;x;y;a;f]
 {[a;f;b;d]f[$[b;a[];a]]d[]}[$[b;xval.i.pickledump a;a];f;b:105h~type a]peach idx[k;n;x;y]}


fitpredict:{[p;a;d]
 t:$[105h~type a;@[.[a[p]`:fit;d 0]`:predict;d[1]0];a[d;p]]`;
 if[2=count distinct d[0]1;t:.5<raze t];
 (t;d[1]1)}


gsseed:{[xv;x;y;a;f;s]
 $[s~(::);xv[x;y;a;f[::]];
   105h~type a;value .ml.xval.gridsearch[xv;x;y;a;f;s];xv[x;y;a;f[s]]]}


// This should be removed before any release
\l data/sampledata.q