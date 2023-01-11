#!/bin/bash

size=256
for dir in ../wikiarts_split/10_Portrait_Artists/*-${size}; do
	name="$(echo "${dir##*/}" | tr ' ' '_')"
	echo $name
	old="$(ls -t ../training-runs/ | grep portrait | head -1)"
	pkl="$(ls -t "../training-runs/${old}/"*.pkl | head -1)"
	data="../datasets/${name}x${size}.zip"
	sed "s@DATA@${data}@g; s@NAME@${name}@g; s@RESUME@${pkl}@g" job_script_st2-${size}.sh > "job_script_st2-${name}.sh"
	sbatch "job_script_st2-${name}.sh"
done
