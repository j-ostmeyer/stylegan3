#!/bin/bash

size=256
for dir in ../wikiarts_split/*-${size}; do
	#if [ "$(echo $dir | grep illustration)" ]; then continue; fi
	name="$(echo "${dir##*/}" | tr ' ' '_')"
	echo $name
	old="$(ls -t ../training-runs/ | grep "$name" | head -1)"
	loc="../training-runs/${old}/"
	pkl="$(ls -dt "$loc"*.pkl | head -1)"
	echo $pkl
	sed "s@LOCATION@${loc}@g; s@NAME@${name}@g; s@RESUME@${pkl}@g" generate_images.sh > "generate_images-${name}.sh"
	sbatch "generate_images-${name}.sh"
done
