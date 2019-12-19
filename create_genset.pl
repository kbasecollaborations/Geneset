#!/usr/bin/perl
use strict;
use warnings;

open(my $fh,$ARGV[0]) or die "could not open file";

my $index;
$index = $ARGV[1];
=pod
if($ARGV[1] eq "pfam")
{
  $index = 3;
} elsif($ARGV[1] eq "pathway") {
  $index = 5;
}
=cut

my %gphash;
my %deschash;
while(my $input = <$fh>)
{
  if ($input !~ /Gene_ID/) {
  chomp($input);
  my @rec =();
  @rec = split("\t",$input);
  my $gene_id;
  $gene_id = $rec[0];
  my $id;
  $id = $rec[$index]; 
  my $description;
  $description = $rec[$index+1];
  if(defined $id && defined $description)
  {
     my $key;
     $key = $id."_".$description;
     $deschash{$key}=$id;
     if (exists $gphash{$key})
     {
               push(@{$gphash{$key}},$gene_id);
     }
     else
     {
          my @genarray = ();
          push(@genarray, $gene_id);
          $gphash{$key}=\@genarray;
     }
  }
 }
}
close($fh);

while (my ( $k, $v) = each %gphash) {
    my @keys = @$v;
    my %hash;
    @hash{@keys} = ();
    my @geneids = keys %hash;
    my $genesets = join ("\t", @geneids);
	print("$k\t$deschash{$k}\t$genesets\n");
}


