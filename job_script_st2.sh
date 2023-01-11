#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J vanGogh
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/vanGogh_st2.out --error=/users/ostmeyer/volatile2/art-recognition/vanGogh_st2.err
#SBATCH -t 3-0
#SBATCH --gres=gpu:4
#SBATCH -N 1 --exclusive

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

python train.py --outdir=../training-runs --cfg=stylegan2 --data=../datasets/vanGoghSelfFaces-256x256.zip \
	--gpus=4 --workers=1 --batch=64 --gamma=1 --mirror=1 --kimg=5000 --snap=20 --tick=5 --metrics=none --cbase=16384 \
	--glr=0.0025 --dlr=0.0025 --mbstd-group=8 \
	--resume=https://api.ngc.nvidia.com/v2/models/nvidia/research/stylegan2/versions/1/files/stylegan2-ffhqu-256x256.pkl

exit 0
