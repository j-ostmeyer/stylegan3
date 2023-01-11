#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J gen_NAME
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/gen_NAME.out --error=/users/ostmeyer/volatile2/art-recognition/gen_NAME.err
#SBATCH -t 0-1
#SBATCH --gres=gpu:1
#SBATCH -N 1

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

python gen_images.py --outdir=LOCATIONout --trunc=1 --seeds=0-2000 \
	    --network=RESUME

exit 0
