use strict;
my $genome_id = $ARGV[0];
my $feature = $ARGV[1];
print("*********".$feature);
my $output = $ARGV[0]."/".$genome_id."_".$feature."_result.txt";
my $phytozome_url = "http://phytozome.jgi.doe.gov/biomart/martservice?query=";
my $feature_id = $feature."_id";
my $feature_desc = $feature."_desc";

my $xml = <<string_ending_delimiter;
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE Query>
<Query  virtualSchemaName = "zome_mart" formatter = "TSV" header = "0" uniqueRows = "0" count = "" datasetConfigVersion = "0.6" >
        <Dataset name = "phytozome" interface = "default" >
                <Filter name = "organism_id" value = "$genome_id"/>
                <Attribute name = "gene_name1" />
                        <Attribute name = "transcript_name1" />
                        <Attribute name = "$feature_id" />
                        <Attribute name = "$feature_desc" />
        </Dataset>
</Query>
string_ending_delimiter

print $xml;
my @xml = split ("\n", $xml);
my $xmlstr = join ("", @xml);
my $biomart_phytozome_query_url = $phytozome_url . $xmlstr;
my $cmd =  "wget -O $output  '" . $biomart_phytozome_query_url . "'";
system ($cmd);


