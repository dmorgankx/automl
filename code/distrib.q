\l p.q
\l ml/ml.q
.ml.loadfile`:init.q

// examples data
n:10000
x:flip(n?100f;asc n?100f)
yr:asc n?100f / regression
yc:n?0 1      / binary classification
ym:n?5        / multi classification
xval_func:.ml.xval.kfshuff[5;1]

\d .aml

// table of models
/* x = symbol, either `class or `reg
/* y = target
models:{
 if[not x in key i.files;'`$"text file not found"];
 d:{key(!).("S=;")0:x}each(!).("S*";"|")0:hsym`$path,"/code/mdl_def/",i.files x; 
 m:flip`model`lib`fnc`seed`typ!flip key[d],'value d;
 if[x=`class;
  m:$[2<count distinct y;delete from m where typ=`binary;delete from m where model=`MultiKeras]];
 update minit:{$[`keras~x;get` sv``aml,y;.p.import[` sv x,y]hsym z]}.'flip(lib;fnc;model)from m}

// run multiple models
/* xv = cross validation function
/* x  = features
/* y  = target
/* m  = models from `.aml.models`
/* f  = scoring function
runmodels:{[xv;x;y;m;f;s]
 system"S ",string s;		
 s:{if[`seed~x;:y]}[;s]each m`seed;
 r:i.runmodel[xv;x;y;;f;]'[m`minit;s];
 desc m[`model]!avg each
  {{x[y 0;y 1]}[x]each y}[$[min m[`typ]in`binary`multi;.ml.accuracy;.ml.mse]]each r}

i.files:`class`reg!("classmodels.txt";"regmodels.txt")

i.fitpredict:{[p;a;d]
 t:$[105h~type a;@[.[a[p]`:fit;d 0]`:predict;d[1]0];a[d;p]]`;
 if[2=count distinct d[0]1;t:.5<raze t];
 (t;d[1]1)}

i.gsseed:{[xv;x;y;a;f;s]
 $[s~(::);xv[x;y;a;f[::]];
   105h~type a;value .ml.xval.gridsearch[xv;x;y;a;f;s];xv[x;y;a;f[s]]]}

i.runmodel:{[xv;x;y;a;f;s]
 s:$[not type[s]in(101h;-7h);@[{"i"$x};s;'`$"type not convertable"];s];
 if[(-7h~type s)&105h~type a;s:enlist[`random_state]!enlist s];
 raze i.gsseed[xv;x;y;a;f;s]}

if[0>system"s";.ml.mproc.init[abs system"s"]enlist".ml.loadfile`:init.q"];   / allow multiprocess
