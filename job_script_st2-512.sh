#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J vanGogh-512
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/vanGogh_st2-512.out --error=/users/ostmeyer/volatile2/art-recognition/vanGogh_st2-512.err
#SBATCH -t 3-0
#SBATCH --gres=gpu:4
#SBATCH -N 1 --exclusive

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

python train.py --outdir=../training-runs --cfg=stylegan2 --data=../datasets/vanGoghSelfFaces-512x512.zip \
	--gpus=4 --workers=1 --batch=12 --gamma=5 --mirror=1 --kimg=5000 --snap=50 --tick=1 \
	--glr=0.001 --dlr=0.001 --mbstd-group=3 --metrics=pr50k3_full,kid50k_full,fid50k_full \
	--resume=../training-runs/00056-stylegan2-vanGoghSelfFaces-512x512-gpus4-batch12-gamma5/network-snapshot-001562.pkl
	#--resume=https://api.ngc.nvidia.com/v2/models/nvidia/research/stylegan2/versions/1/files/stylegan2-ffhq-512x512.pkl

exit 0
