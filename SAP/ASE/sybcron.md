# SybCron / AudRow (interchangeable)

```
startserver -f ./RUN_train_ds
Gsnh=Settle_sybcron
sudo chmod 755 ./audrow
./audrow -dbgl 99> output.log 2>&1
```


### Commands manual

| command | description |
| ----------- | ------------ |
|  ./sybcron ver  | Prints sybcron version |
|  ./sybcron ver exp | Prints sybcron version plus expire info if expires or expired |
|  ./sybcron saccom - - - - - - - | Crypts hostname into ${0}.dat file |
|  ./sybcron Afreedsk bsl18heu3ds ! - - - ./interfaces | |
|  ./sybcron afreedsk bsl18heu3ds ! - - - ./interfaces | |
|  ./sybcron rfreedsk prgtct1irs ! - - - ./interfaces   |  Shows free disk space |
|  ./sybcron rresthr prgtbdars ! - - - ./interfaces |  Resumes all threads | 
|  ./sybcron rqueuesize prgtbdars ! - - - ./interfaces |  Shows queue sizes | 
|  ./sybcron adblst bsl18heu3ds ! - - - ./interfaces |  Lists all databases | 
|  ./sybcron rgst.prgtbdars_RSSD.108 bsl18heu3ds ! - - - ./interfaces |  Get skipped trans | 
|  ./sybcron radminwho prgtbdars ! - - - ./interfaces |  |  
|  ./sybcron radminwhoisdown prgtbdars ! - - - ./interfaces |  | 
|  ./sybcron acredbcomm bsl18heu3ds ! - - - ./interfaces |  Generate create db commands | 
|  ./sybcron rgslst.par21hpr1rs_RSSD par21hpr2ss ! + - - ./interfaces |  | 
|  ./sybcron rgslst.par21hpr1rs_RSSD par21hpr2ss ! + - - ./interfaces |  Get skipped trans list | 
|  ./sybcron rgst.par21hpr1rs_RSSD.3221 par21hpr2ss ! + tr.3221 - ./interfaces |  | 
|  ./sybcron rresthr par29hpr1rs ! ^ - - /home/sim/czhs0448/peta/prd/interfaces |  | 
|  ./sybcron rlogtr.EUct2pas.eupct2p euct1prs ! W |   Log first tran | 
|  ./sybcron agetnewobj!10! dzseucpds ! ! |  Get new objects | 
|  ./sybcron atrlog!t!11998277,4!!12! eucntods ! ! |  Get transaction log records for transaction ID | 
|  ./sybcron atrlog!l!!eupeinp!14! eucntods ! ! |   Get transaction log records from begining | 
|  ./sybcron atempdiag eucntods ! !  |  Diagnostics of tempdb if full |  
|  ./sybcron adump!/tmp/sybsol_ds_model!model!7 sybsol_ds + N - - - 99 |   |  
|  ./sybcron adumpl!/tmp/sybsol_ds_prim_l!prim!7 sybsol_ds + N - - - 99 |  | 
|  ./sybcron adbspace sybsol_ds + N - - - 0 |   | 
|  ./sybcron aloginlst sybsol_ds + N - - - 0 |  | 
|  ./sybcron aloginlstlck sybsol_ds + N - - - 0  |  | 
|  ./sybcron aaddlgn sybsol_ds + N - - - 8 |   | 
|  ./sybcron achpswd sybsol_ds + N - - - 8  |  | 
|  ./sybcron abldmps sybsol_ds ! N  | Shows tran dumps blocked by db dumps | 
|  ./sybcron asql.29 sybsol_ds + N - - - 2  |  Has to have dbgl at least 2  | 
|  ./sybcron ablckprc!10! sybsol_ds ? N  |  Prints blocked and blocking processes over time in param in seconds | 
|  ./sybcron alckeupa sybsol_ds ! ^  | Locks euplus logins |
|  ./sybcron atstovo sybsol_ds ! ^ |  |
|  ./sybcron acleanp sybsol_ds ! ^ |  Kills CIC based on IP ( plus suid=3 added now ) |
|  ./sybcron aspikill.21 sybsol_ds ? N  | Kills spid 21 if no sa role |
|  ./sybcron athrlst sybsol_ds + N | awk '{ print $1"!"$2"!"$3"!"$4"!"$5 }'  | Gives all thresholds  |
|  ./sybcron aupdstats!7! sybsol16_ds + N  | Updates 20 oldest stats older than 7 days |


