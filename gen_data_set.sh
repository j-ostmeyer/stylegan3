#!/usr/bin/bash

#SBATCH -p gpu,gpuc
#SBATCH -D /users/ostmeyer/volatile2/art-recognition/stylegan3
#SBATCH -J data-sets
#SBATCH --output=/users/ostmeyer/volatile2/art-recognition/data-sets.out --error=/users/ostmeyer/volatile2/art-recognition/data-sets.err
#SBATCH -t 3-0
#SBATCH --gres=gpu:4
#SBATCH -N 1 --exclusive

export CXX=g++

source activate gpu

echo "print SLURM_JOB_NODELIST = $SLURM_JOB_NODELIST"
pwd

size=256
for dir in ../wikiarts_split/10_Portrait_Artists/*-${size}; do
	name="$(echo "${dir##*/}x${size}" | tr ' ' '_')"
	python dataset_tool.py --source="${dir}" --dest="../datasets/${name}.zip" \
		    --resolution=${size}x${size}
done

exit 0
