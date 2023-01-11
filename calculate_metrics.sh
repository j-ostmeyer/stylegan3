#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J metTAUSEND_vanGogh
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/metTAUSEND_vanGogh.out --error=/users/ostmeyer/volatile2/art-recognition/metTAUSEND_vanGogh.err
#SBATCH -t 3-0
#SBATCH --gres=gpu:1
#SBATCH -N 1

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

for pkl in ../training-runs/00054-stylegan2-vanGoghSelfFaces-512x512-gpus4-batch32-gamma5/network-snapshot-00TAUSEND*.pkl; do
	time python calc_metrics.py \
		--network="$pkl"
done

exit 0
