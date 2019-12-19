#!/bin/bash
echo "${1}"
mkdir "${1}"
featurearray=( go  pfam panther pathway kegg_enzyme smart kog )
for i in "${featurearray[@]}"
do
    sleep 30
    perl fetch_genlist_v3.pl $1 $i
    input="${1}/${1}_${i}_result.txt"
    output="${1}/${1}_${i}_geneset.txt"
    if [ ${i} == "go" ]; then
       echo "${i}"
       perl add_go_desc.pl $input > "${1}/${1}_${i}_tmp.txt"
       mv "${1}/${1}_${i}_tmp.txt" $input
    fi
 
    echo "${input}"
    perl create_genset_v2.pl "${input}" 2 > "${output}" 
done




