# Geneset

## Step 1 Getting smart description file </br>
wget http://smart.embl-heidelberg.de/smart/descriptions.pl

## Step 2. Extracting smart id description list. </br>
awk -F "\t" '{print $2"\t"$3}' descriptions.pl > smart_id_desc.txt

## Step 3. Getting obo file from GO. </br>
wget http://current.geneontology.org/ontology/go.obo

## Step 4. Extracting GO id description list. </br>
awk ‘BEGIN{OFS=“\t”}/\[Term\]/{getline n1; getline n2; print $0, n1,n2}’ go.obo |cut -f 2,3 | sed -e ‘s/id: //g’ | sed -e ‘s/name: //g’ >go_id_desc.txt

## Command for creating geneset directory structure for biomart-kbase species. <br>
awk '{if (NR!=1) {print "bash run_gen_geneset.sh "$2 }}' mapping_biomart_kbase.txt | bash
