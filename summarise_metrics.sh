#!/bin/bash

mkdir -p final_fakes
rm -f 000*/metrics.eps

for num in {89..94}; do
	dir=$(ls | grep "000${num}")
	if [ ! "$dir" ]; then continue; fi
	name=$(echo "$dir" | sed 's/[0-9]*-stylegan2-//g; s/-256x256-.*//g')
	oldDir=$(ls | grep "$name" | tail -2 | head -1)

	cd $dir
	for dat in metric-*.jsonl; do
		rm -f "${dat%.jsonl}.csv"
		met=${dat%.jsonl}
		met=${met#.*metric-}
		oldCsv="../${oldDir}/${dat%.jsonl}.csv"
		if [ -e "$oldCsv" ]; then
			cp "$oldCsv" .
		else
			echo "kimag	$met" > "${dat%.jsonl}.csv"
		fi
		awk '{print $3,$14,$15,$16}' "$dat" | sed 's/},.*"network-snapshot-/ /g;s/,.*"network-snapshot-/ /g;s/.pkl.*$//g' |awk '{print $2+0,$1}' | sort -n >> "${dat%.jsonl}.csv"
	done
	cd ..

	cp "$(ls -t "${dir}"/fakes*.png | head -1)" final_fakes/"${name}.png"

	cp plot_metrics.gp $dir
	cd $dir
	gnuplot -e "tt='${name}'" plot_metrics.gp

	cd ..

done

gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -sOutputFile=all_metrics.pdf 000*/metrics.eps
