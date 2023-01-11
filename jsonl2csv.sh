#!/bin/bash

dir=$1

for dat in ${dir}/metric-*.jsonl; do
	met=${dat%.jsonl}
	met=${met#.*metric-}
	echo "kimag	$met" > "${dat%.jsonl}.csv"
	awk '{print $3,$14,$15,$16}' "$dat" | sed 's/},.*"network-snapshot-/ /g;s/,.*"network-snapshot-/ /g;s/.pkl.*$//g' |awk '{print $2,$1}' | sort -n >> "${dat%.jsonl}.csv"
done
