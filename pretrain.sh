#!/bin/bash

size=1024
for dir in ../wikiarts_split/*-${size}; do
	#if [ "$(echo $dir | grep illustration)" ]; then continue; fi
	name="$(echo "${dir##*/}" | tr ' ' '_')"
	echo $name
	old="$(ls -t ../training-runs/ | grep "$name" | head -1)"
	pkl="$(ls -dt "../training-runs/${old}/"*.pkl | head -1)"
	echo $pkl
	data="../datasets/${name}x${size}.zip"
	#sed "s@DATA@${data}@g; s@NAME@${name}@g" job_script_st2-${size}.sh > "job_script_st2-${name}.sh"
	sed "s@DATA@${data}@g; s@NAME@${name}@g; s@RESUME@${pkl}@g" job_script_st2-${size}.sh > "job_script_st2-${name}.sh"
	sbatch "job_script_st2-${name}.sh"
done
