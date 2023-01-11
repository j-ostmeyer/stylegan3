#!/bin/bash

size=256
dim="${size}x${size}"

cd 10_Portrait_Artists

endings="tif tiff JPG jpg"

for dir in */; do
#dir='history and genre painting'
	cp -r "${dir}/images" "${dir%/}-${size}"
	cd "${dir%/}-${size}"

	#for pic in *.jpg *.png; do
	#	minS=$(convert "${pic}" -print "%w %h\n" /dev/null)
	#	for s in $minS; do
	#		if [ $s -lt $size ]; then rm -f "${pic}"; fi
	#	done
	#done

	for suff in $endings; do
		for pic in *.${suff}; do convert "${pic}" "${pic%.${suff}}".png; done
		rm *.${suff}
		#for pic in *.JPG; do mv "${pic}" "${pic%.JPG}".bla; mv "${pic%.JPG}".bla "${pic%.JPG}".jpg; done
		#for pic in *.jpg; do convert "${pic}" "${pic%.jpg}".png; done
		#rm *.jpg
	done

	for pic in *.png; do convert -define png:size=${dim} "${pic}" -thumbnail ${dim}^ -gravity north -extent ${dim} "${pic}"; done
	for pic in *.png; do convert "${pic}" -alpha off "${pic}"; done

	for pic in *.png; do
		if (identify -verbose "${pic}" | grep -q Gray); then
			echo "${dir}${pic}"
			rm "${pic}"
		fi
	done

	cd ..
done
