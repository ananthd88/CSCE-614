date;

echo "Running simulations for $1";

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

OUTPUTDIR="../../assignment4/output/$1/";
rm -rf $OUTPUTDIR/*;

l1sizes=( 1 1 8 8);
l2sizes=( 512 512 512 512);
widths=( 9 6 9 6);
count=${#l1sizes[*]};

for (( i=0; i<=$(( count -1 )); i++ ))
do
   echo "Running simulation with -";
   echo "l1size               = ${l1sizes[$i]}";
   echo "l2size               = ${l2sizes[$i]}";
   echo "shift register width = ${widths[$i]}";
   echo "./RUN$1 ../../assignment4/simplesim-3.0/sim-outorder ../../spec2000binaries/$100.peak.ev6 -max:inst 50000000 -fastfwd 20000000 -redir:sim $OUTPUTDIR/output_${l1sizes[$i]}_${l2sizes[$i]}_${widths[$i]} -bpred 2lev -bpred:2lev ${l1sizes[$i]} ${l2sizes[$i]} ${widths[$i]} 0 -bpred:ras 8 -bpred:btb 64 2";
   ./RUN$1 ../../assignment4/simplesim-3.0/sim-outorder ../../spec2000binaries/$100.peak.ev6 -max:inst 50000000 -fastfwd 20000000 -redir:sim $OUTPUTDIR/output_${l1sizes[$i]}_${l2sizes[$i]}_${widths[$i]} -bpred 2lev -bpred:2lev ${l1sizes[$i]} ${l2sizes[$i]} ${widths[$i]} 0 -bpred:ras 8 -bpred:btb 64 2
   echo "Done";
   echo;
done
date;
exit;
