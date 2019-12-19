#!/bin/bash
echo "${1}"
mkdir "${1}"
featurearray=( go pfam panther pathway kegg_enzyme smart kog )
for i in "${featurearray[@]}"
do
    sleep 30
    perl fetch_genlist.pl $1 $i
    input="${1}/${1}_${i}_result.txt"
    output="${1}/${1}_${i}.gmt"
    if [ ${i} == "go" ]; then
       echo "${i}"
       perl add_go_smart_desc.pl go_id_desc.txt $input > "${1}/${1}_${i}_tmp.txt"
       cp "${1}/${1}_${i}_tmp.txt" $input
    elif [ ${i} == "smart" ]; then
       echo "${i}"
       perl add_go_smart_desc.pl smart_id_desc.txt $input > "${1}/${1}_${i}_tmp.txt"
       cp "${1}/${1}_${i}_tmp.txt" $input
    fi
    
    echo "${input}"
    perl create_genset.pl "${input}" 2 > "${output}" 
    rm $input
done

tar -cvzf "${1}".tar.gz "${1}"

rm -r "${1}"
