date;

echo "Compare performance of 2-level & Tournament predictors for $1";

if [ ! -d "../output/" ]; then
   mkdir "../output/";
fi

if [ ! -d "../output/$1/" ]; then
   mkdir "../output/$1/";
fi

cd ../../spec2000args/$1/;

if [ ! -f RUN$1 ]; then
   echo "RUN$1 not found in ../../spec2000args/$1/! Exiting."
   exit;
fi

OUTPUTDIR="../../assignment4/output/$1";
#rm -rf $OUTPUTDIR/*;

l1size=1;
l2size=4096;
width=9;

echo "2-level Predictor -";
echo "l1size               = $l1size";
echo "l2size               = $l2size";
echo "shift register width = $width";
echo "./RUN$1 ../../assignment4/simplesim-3.0/sim-outorder ../../spec2000binaries/$100.peak.ev6 -max:inst 50000000 -fastfwd 20000000 -redir:sim $OUTPUTDIR/output_2lev_$l1size\_$l2size\_$width -bpred 2lev -bpred:2lev $l1size $l2size $width 0 -bpred:ras 8 -bpred:btb 64 2";
./RUN$1 ../../assignment4/simplesim-3.0/sim-outorder ../../spec2000binaries/$100.peak.ev6 -max:inst 50000000 -fastfwd 20000000 -redir:sim $OUTPUTDIR/output_2lev_${l1size}_${l2size}_${width} -bpred 2lev -bpred:2lev $l1size $l2size $width 0 -bpred:ras 8 -bpred:btb 64 2

selsize=4096;
globalregsize=12;
localhtbsize=1024;
localhrsize=10;
echo "Tournament Predictor -";
echo "sel_size             = $selsize";
echo "global_regsize       = $globalregsize";
echo "local_htb_size       = $localhtbsize";
echo "local_hr_size        = $localhrsize";
echo "./RUN$1 ../../assignment4/simplesim-3.0/sim-outorder ../../spec2000binaries/$100.peak.ev6 -max:inst 50000000 -fastfwd 20000000 -redir:sim $OUTPUTDIR/output_tour_${selsize}_${globalregsize}_${localhtbsize}_${localhrsize} -bpred tournament -bpred:tournament $selsize $globalregsize $localhtbsize $localhrsize 0 -bpred:ras 8 -bpred:btb 64 2";
./RUN$1 ../../assignment4/simplesim-3.0/sim-outorder ../../spec2000binaries/$100.peak.ev6 -max:inst 50000000 -fastfwd 20000000 -redir:sim $OUTPUTDIR/output_tour_${selsize}_${globalregsize}_${localhtbsize}_${localhrsize} -bpred tournament -bpred:tournament $selsize $globalregsize $localhtbsize $localhrsize 0 -bpred:ras 8 -bpred:btb 64 2

date;
exit;
