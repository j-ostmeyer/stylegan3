#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J NAME
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/NAME.out --error=/users/ostmeyer/volatile2/art-recognition/NAME.err
#SBATCH -t 3-0
#SBATCH --gres=gpu:4
#SBATCH -N 1 --exclusive

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

python train.py --outdir=../training-runs --cfg=stylegan2 --data=DATA \
	--kimg=5000 --snap=100 --tick=1 \
	--gpus=4 --workers=1 --batch=16 --gamma=1 --mirror=1 --cbase=16384 \
	--glr=0.001 --dlr=0.001 --mbstd-group=4 --metrics=kid50k_full,fid50k_full \
	--resume=RESUME
	#--resume=https://api.ngc.nvidia.com/v2/models/nvidia/research/stylegan2/versions/1/files/stylegan2-ffhq-512x512.pkl

exit 0
