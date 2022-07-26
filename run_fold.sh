#!/bin/bash
#SBATCH -J run_fold
#SBATCH -N 1
#SBATCH -n 8
#SBATCH --mem=64GB
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -t 24:00:00
#SBATCH --mail-user=michael.jendrusch@embl.de
#SBATCH -e slurm-%j.err-%N
#SBATCH -o slurm-%j.out-%N
#SBATCH --mail-type=FAIL

source $HOME/.bashrc
module load CUDA/11.1.1-GCC-10.2.0
conda activate colabfold
cd $COLABFOLD

python runner.py $@

