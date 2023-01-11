#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J vanGogh
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/vanGogh.out --error=/users/ostmeyer/volatile2/art-recognition/vanGogh.err
#SBATCH -t 3-0
#SBATCH --gres=gpu:4
#SBATCH -N 1 --exclusive

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

python train.py --outdir=../training-runs --cfg=stylegan3-r --data=../datasets/vanGoghFaces-256x256.zip \
	--gpus=4 --workers=1 --batch=32 --gamma=2 --mirror=1 --kimg=5000 --snap=20 --tick=5 --metrics=none --cbase=16384 \
	--resume=../training-runs/00040-stylegan3-r-vanGoghFaces-256x256-gpus1-batch48-gamma2/network-snapshot-000050.pkl

exit 0
