OUT_PATH=$1
CSV_FILE=$2
OPTS="--num_recycle 96 --msa_method mmseqs2 --num_ensemble 1 --num_samples 1 --tol 0.1 --out_path $OUT_PATH"

DEPS=("" "" "" "")
index=0
for line in `cat $CSV_FILE`; do
  set -f; IFS=","; arr=($line)
  candidate=${arr[0]}
  sequence=${arr[1]}
  DEPS[$index]="--dependency=afterany:$(sbatch ${DEPS[$index]} run_fold.sh $OPTS --jobname ${candidate}_$method --sequence $sequence --homooligomer 1 2>&1 | sed 's/[S,a-z]* //g')"
  index=$(( ( $index + 1 ) % 4 ))
done
