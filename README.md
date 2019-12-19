# Geneset

#Getting obo file from GO.
wget http://current.geneontology.org/ontology/go.obo

#Extracting GO id description list.
awk ‘BEGIN{OFS=“\t”}/\[Term\]/{getline n1; getline n2; print $0, n1,n2}’ go.obo |cut -f 2,3 | sed -e ‘s/id: //g’ | sed -e ‘s/name: //g’ >go_id_desc.txt
